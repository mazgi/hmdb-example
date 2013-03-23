/*
 * com_mazgi_example_hmdbexample4android_JNIBridge.cpp
 *
 *  Created on: Mar 22, 2013
 *      Author: matsuki_hidenori
 */

#include "com_mazgi_example_hmdbexample4android_JNIBridge.h"
#include <android/log.h>
#include "HMDBCPPDriverForAndroid.h"

JNIEXPORT void JNICALL Java_com_mazgi_example_hmdbexample4android_JNIBridge_execHMDatabase
  (JNIEnv *env, jobject obj, jstring jPath)
{
	__android_log_print(ANDROID_LOG_INFO, "hmdbexample4android", "%d:in %s", __LINE__, __PRETTY_FUNCTION__);
	const char *path = env->GetStringUTFChars(jPath, 0);
	__android_log_print(ANDROID_LOG_INFO, "hmdbexample4android", "%d:path=>%s", __LINE__, path);

	HMDBCPPDriverForAndroid *driver = new HMDBCPPDriverForAndroid();
	driver->run(path);
	delete(driver);

	__android_log_print(ANDROID_LOG_INFO, "hmdbexample4android", "%d:out %s", __LINE__, __PRETTY_FUNCTION__);
}
