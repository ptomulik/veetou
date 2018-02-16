# -*- coding: utf8 -*-
"""`veetou.util`

Utility functions
"""

import subprocess


def backtick(cmd, input=None, timeout=None):
    """Executes external command and returns its output.

    If the command exits with non-zero exit status, a ``CalledProcessError``
    exception is raised with (stdout and stderr separated).
    """
    PIPE = subprocess.PIPE
    stdin = PIPE if input is not None else None
    return subprocess.check_output(cmd, stdin=stdin, stderr=PIPE, universal_newlines=True, timeout=timeout)

def filecmd(filename, flags):
    """Executes 'file <flags> filename' and returns its output"""
    cmd = [ 'file' ] + list(flags)
    if isinstance(filename, str):
        if filename == '-':
            raise NotImplementedError("stdin input is not implemented")
        cmd.append(filename)
        out = backtick(cmd).strip()
    else:
        fnames = list(filename)
        if len(fnames) > 0:
            if '-' in fnames:
                raise NotImplementedError("stdin input is not implemented")
            cmd.extend(fnames)
            out = [ s.strip() for s in backtick(cmd).splitlines() ]
        else:
            out = []
    return out

def filetype(filename):
    """Executes 'file -b filename' and returns its output"""
    return filecmd(filename, ['-E', '-b'])

def filemime(filename):
    """Executes 'file -bi filename' and returns its output"""
    return filecmd(filename, ['-E', '-b', '-i'])

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
