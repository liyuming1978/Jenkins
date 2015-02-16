LOCAL_PATH := $(call my-dir)

#
# Prebuilt Shared library
#
ifeq ($(TARGET_ARCH_ABI), x86_64)
else
	include $(CLEAR_VARS)
	LOCAL_MODULE	:= lenthevcdec
	LOCAL_SRC_FILES	:= lib/$(ARCH_ABI)/liblenthevcdec.so
	include $(PREBUILT_SHARED_LIBRARY)
endif