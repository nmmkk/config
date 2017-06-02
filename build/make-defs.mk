SYMLINK := ln -s

INSTALL_BASE := ~

# readlink on macOS is different from one on Linux
READLINK := $(shell type greadlink >/dev/null 2>&1 && echo greadlink || echo readlink)

BASE_DIR := $(shell $(READLINK) -f $(CURDIR)/../)
