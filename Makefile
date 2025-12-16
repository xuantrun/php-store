export TARGET = iphone:clang:latest:7.0
export ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = DDOS

DDOS_FILES = DDOS.m DDOS.mm
DDOS_CFLAGS = -fobjc-arc
DDOS_FRAMEWORKS = UIKit Foundation
DDOS_INSTALL_PATH = /Applications

include $(THEOS_MAKE_PATH)/application.mk
