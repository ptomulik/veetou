#!/usr/bin/env python3

import os
import sys
import time
import math
import random
import requests
import hashlib
import shutil
import argparse

# port of uniqmodule.c to pure python by Derwentx,
# inspired by http://gurukhalsa.me/2011/uniqid-in-python/

def uniqid(prefix='', more_entropy=False):
    """uniqid([prefix=''[, more_entropy=False]]) -> str
    Gets a prefixed unique identifier based on the current
    time in microseconds.

    prefix
        Can be useful, for instance, if you generate identifiers
        simultaneously on several hosts that might happen to generate
        the identifier at the same microsecond.
        With an empty prefix, the returned string will be 13 characters
        long. If more_entropy is True, it will be 23 characters.

    more_entropy
        If set to True, uniqid() will add additional entropy (using
        the combined linear congruential generator) at the end of
        the return value, which increases the likelihood that
        the result will be unique.

    Returns the unique identifier, as a string."""
    m = time.time()
    sec = math.floor(m)
    usec = math.floor(1000000 * (m - sec))
    if more_entropy:
        lcg = random.random()
        the_uniqid = "%08x%05x%.8F" % (sec, usec, lcg * 10)
    else:
        the_uniqid = '%8x%05x' % (sec, usec)

    the_uniqid = prefix + the_uniqid
    return the_uniqid


class AbstractInstaller:

    def __init__(self, install_dir=None,
                       filename=None,
                       url=None,
                       sig_url=None,
                       tmpdir=None):

        if install_dir is None: install_dir = self.default_install_dir()
        if filename is None: filename = self.default_filename()
        if url is None: url = self.default_url()
        if sig_url is None: sig_url = self.default_sig_url()
        if tmpdir is None: tmpdir = self.default_tmpdir()

        self._init(install_dir, filename, url, sig_url, tmpdir)

    def __del__(self):
        self._cleanup()

    def default_install_dir(self):
        return '.'

    def default_filename(self):
        raise NotImplementedError()

    def default_url(self):
        raise NotImplementedError()

    def default_sig_url(self):
        raise NotImplementedError()

    def default_tmpdir(self):
        return 'tmp'

    def tmp_filename_prefix(self):
        raise NotImplementedError()

    def tmp_filename_suffix(self):
        return ''

    def run_install_cmd(self):
        raise NotImplementedError()

    def _init(self, install_dir, filename, url, sig_url, tmpdir):

        self.install_dir = install_dir
        self.filename = filename
        self.url = url
        self.sig_url = sig_url
        self.tmpdir = tmpdir

        suffix = self.tmp_filename_suffix()
        prefix = self.tmp_filename_prefix()
        basename = uniqid(prefix, True) + suffix
        self.tmpfile = os.path.join(tmpdir, basename)
        self.remove_tmpdir = False

    def _prepare(self):
        if not os.path.exists(self.tmpdir):
            sys.stdout.write('info: temporary directory %s does not exist yet\n' % repr(self.tmpdir))
            sys.stdout.write('info: creating temporary directory %s\n' % repr(self.tmpdir))
            os.mkdir(self.tmpdir, mode=0o755)
            self.remove_tmpdir = True
        if os.path.exists(self.tmpfile):
            sys.stdout.write('info: file %s already exists\n' % repr(self.tmpfile))
            sys.stdout.write('info: trying to remove %s\n' % repr(self.tmpfile))
            try:
                os.unlink(self.tmpfile)
            except OSError as e:
                sys.stderr.write("warning: could not remove %s: %s\n" % (repr(self.tmpfile), str(e)))

    def _cleanup(self):
        if hasattr(self, 'tmpfile') and os.path.exists(self.tmpfile):
            sys.stdout.write('info: removing temporary file %s\n' % repr(self.tmpfile))
            try:
                os.unlink(self.tmpfile)
            except OSError as e:
                sys.stderr.write("warning: could not remove %s: %s\n" % (repr(self.tmpfile), str(e)))

        if hasattr(self, 'remove_tmpdir') and self.remove_tmpdir and \
           hasattr(self, 'tmpdir') and os.path.exists(self.tmpdir):
            sys.stdout.write('info: removing temporary directory %s\n' % repr(self.tmpdir))
            try:
                os.rmdir(self.tmpdir)
            except OSError as e:
                sys.stderr.write("warning: could not remove %s: %s\n" % (repr(self.tmpdir), str(e)))

    def _download_installer(self):
        sys.stdout.write('info: downloading %s -> %s\n' % (repr(self.url), repr(self.tmpfile)))
        with requests.Session() as s:
            r = s.get(self.url, allow_redirects=True)
            r.raise_for_status()
            with open(self.tmpfile, 'wb') as out:
                out.write(r.content)

    def _get_expected_sig(self):
        sys.stdout.write('info: retrieving expected signature from %s\n' % repr(self.sig_url))
        with requests.Session() as s:
            r = s.get(self.sig_url, allow_redirects=True)
            r.raise_for_status()
            sig = r.text.strip()
            if sig:
                sig = sig.split()[0].lower()
        return sig

    def _get_actual_sig(self):
        sys.stdout.write('info: computing actual signature for %s\n' % repr(self.tmpfile))
        with open(self.tmpfile, 'rb') as f:
            return self.compute_sig(f.read())

    def _check_sig(self, expected, actual):
        sys.stdout.write('info: expect signature: %s\n' % expected)
        sys.stdout.write('info: actual signature: %s\n' % actual)
        if actual != expected:
            raise RuntimeError('installer corrupt (signatures do not match)')
        sys.stdout.write('info: ok, signatures match\n')

    def compute_sig(self, content):
        return hashlib.sha384(content).hexdigest().lower()

    def install(self):
        try:
            self._prepare()

            self._download_installer()

            if self.sig_url is not None:
                expected = self._get_expected_sig()
                actual = self._get_actual_sig()
                self._check_sig(expected, actual)

            self.run_install_cmd()

        finally:
            self._cleanup()

    @classmethod
    def sysname(cls):
        try:
            return cls._sysname
        except AttributeError:
            u = os.uname()
            try:
                cls._sysname = u.sysname
            except AttributeError:
                cls._sysname = u[0]
            return cls._sysname

    @classmethod
    def machine(cls):
        try:
            return cls._machine
        except AttributeError:
            u = os.uname()
            try:
                cls._machine = u.machine
            except AttributeError:
                cls._machine = u[4]
            return cls._machine


class DockerComposeInstaller(AbstractInstaller):

    def __init__(self, *args, **kw):
        self.release = kw.get('docker_compose_release', self.default_release())
        self.urlbase = kw.get('docker_compose_urlbase', self.default_urlbase())
        super().__init__(*args, **kw)

    @classmethod
    def default_release(cls):
        return '1.23.2'

    @classmethod
    def default_urlbase(cls):
        return "https://github.com/docker/compose/releases/download"

    def default_url(self):
        fname = 'docker-compose-' + self.sysname() + '-' + self.machine() + self.exe_suffix()
        return '/'.join([self.urlbase, ("%s/%s" % (self.release, fname))])

    def default_sig_url(self):
        return self.default_url() + '.sha256'

    def compute_sig(self, content):
        return hashlib.sha256(content).hexdigest().lower()

    def exe_suffix(self):
        if 'win' == self.sysname()[0:3].lower():
          return '.exe'
        else:
          return ''

    def default_filename(self):
        return 'docker-compose' + self.exe_suffix()

    def tmp_filename_prefix(self):
        return 'docker-compose-'

    def tmp_filename_suffix(self):
        return self.exe_suffix()

    _instance = None

    def run_install_cmd(self):
        destfile = os.path.join(self.install_dir, self.filename)
        sys.stdout.write('info: cp %s %s\n' % (repr(self.tmpfile), repr(destfile)))
        shutil.copy2(self.tmpfile, destfile)
        if 'win' != self.sysname():
            sys.stdout.write('info: chmod 755 %s\n' % repr(destfile))
            os.chmod(destfile, 0o755)

def main():
    try:
        DockerComposeInstaller().install()
    except (OSError, RuntimeError) as e:
        sys.stderr.write('error: %s\n' % str(e))
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())

# vim: set ft=python ts=4 sw=4 et:
