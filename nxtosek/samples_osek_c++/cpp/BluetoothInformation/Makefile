# Target specific macros
TARGET = btinfo

TARGET_CPP_SOURCES = sample.cpp
	
TOPPERS_OSEK_OIL_SOURCE = ./sample.oil

# Don't modify below part
O_PATH ?= build

# makefile for C++(.cpp) build
ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot++.mak
