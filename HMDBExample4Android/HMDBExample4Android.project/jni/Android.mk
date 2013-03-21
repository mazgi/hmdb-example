LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_CXX_SRC_FILES	:= $(wildcard $(LOCAL_PATH)/../../../hmdb/sources/**/*.cpp)

LOCAL_CFLAGS		:= -I$(LOCAL_PATH)/../libs/sqlite3
LOCAL_CPPFLAGS		:= $(LOCAL_CFLAGS)
LOCAL_CPPFLAGS		+= -std=c++11
LOCAL_CPP_FEATURES	+= rtti
LOCAL_MODULE		:= HMDBCPPDriverForAndroid
LOCAL_SRC_FILES		:= HMDBCPPDriverForAndroid.cpp
LOCAL_SRC_FILES		+= ../libs/sqlite3/sqlite3.c
LOCAL_SRC_FILES		+= $(LOCAL_CXX_SRC_FILES:$(LOCAL_PATH)/%=%)
LOCAL_C_INCLUDES	:= $(JNI_H_INCLUDE)
LOCAL_C_INCLUDES	+= $(LOCAL_PATH)/../libs/sqlite3
LOCAL_C_INCLUDES	+= $(LOCAL_PATH)/../../../hmdb/sources
LOCAL_LDLIBS		:= -llog

include $(BUILD_SHARED_LIBRARY)
