# Target
TARGET = nxtway_gs++

# include path
USER_INC_PATH= $(NXTOSEK)/ecrobot/nxtway_gs_balancer

# library
USER_LIB = nxtway_gs_balancer

# C source file
TARGET_SOURCES = \
	balancer_param.c

# C++(.cpp) source files
TARGET_CPP_SOURCES = \
	GamePadDriver.cpp \
	SonarDriver.cpp \
	StartStopDriver.cpp \
	DriverManager.cpp \
	NXTway_GS.cpp \
	sample.cpp

# TOPPERS/ATK(OSEK) config file
TOPPERS_OSEK_OIL_SOURCE = sample.oil

# don't change this macro
O_PATH ?= build

# makefile for C++(.cpp) build
ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot++.mak
