# It needs to define this macro to use TOPPERS/JSP
TOPPERS_KERNEL = NXT_JSP

# Target specific macros
TARGET = helloworld

TARGET_CPP_SOURCES = sample.cpp
	
TOPPERS_JSP_CFG_SOURCE = ./sample.cfg

# Don't modify below part
O_PATH ?= build

# makefile for C++(.cpp) build
ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot++.mak
