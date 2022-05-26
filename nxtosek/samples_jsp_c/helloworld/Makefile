# It needs to define this macro to use TOPPERS/JSP
TOPPERS_KERNEL = NXT_JSP

# Target specific macros
TARGET = helloworld_JSP
TARGET_SOURCES = \
	helloworld.c
TOPPERS_JSP_CFG_SOURCE = ./helloworld.cfg

# Don't modify below part
O_PATH ?= build
ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
