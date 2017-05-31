SYMLINK := ln -s

INSTALL_BASE := ~

BASE_DIR := $(shell readlink -f $(CURDIR)/../)
