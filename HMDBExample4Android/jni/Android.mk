LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := HMDBCPPDriverForAndroid
LOCAL_SRC_FILES := HMDBCPPDriverForAndroid.cpp
LOCAL_C_INCLUDES := $(JNI_H_INCLUDE)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../hmdb
LOCAL_LDLIBS := -llog

include $(BUILD_SHARED_LIBRARY)
