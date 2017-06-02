SYMLINK := ln -s

INSTALL_BASE := ~

# readlink on macOS is different from one on Linux
READLINK := readlink
READLINK := $(shell which greadlink && echo greadlink)

BASE_DIR := $(shell $(READLINK) -f $(CURDIR)/../)
