# Target specific macros
TARGET = SonarTest
TARGET_SOURCES := \
	sonartest.c
TOPPERS_OSEK_OIL_SOURCE := ./sonartest.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
