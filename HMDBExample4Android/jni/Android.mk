LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_CPPFLAGS	+= -std=c++11
LOCAL_MODULE    := HMDBCPPDriverForAndroid
LOCAL_SRC_FILES := HMDBCPPDriverForAndroid.cpp
LOCAL_SRC_FILES += ../../../hmdb/common/
LOCAL_C_INCLUDES := $(JNI_H_INCLUDE)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../hmdb/common
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../hmdb/platrom/android
LOCAL_LDLIBS := -llog

include $(BUILD_SHARED_LIBRARY)
