import sys

if sys.version_info < (3, 10):
    raise RuntimeError(
        f"Your Python version is {sys.version.split()[0]}. "
        "This program requires Python 3.10 or higher. "
        "Please upgrade at https://www.python.org/downloads/"
    )