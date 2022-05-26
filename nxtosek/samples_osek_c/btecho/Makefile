# Target specific macros
TARGET = btecho
TARGET_SOURCES = \
	btecho.c
TOPPERS_OSEK_OIL_SOURCE = ./btecho.oil

# Don't modify below part
O_PATH ?= build
ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
