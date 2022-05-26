# Target specific macros
TARGET = nxte_test
TARGET_SOURCES := \
	nxte_test.c \
	nxte.c
TOPPERS_OSEK_OIL_SOURCE := ./nxte_test.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
