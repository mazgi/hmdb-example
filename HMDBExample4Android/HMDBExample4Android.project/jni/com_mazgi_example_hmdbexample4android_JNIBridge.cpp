/*
 * com_mazgi_example_hmdbexample4android_JNIBridge.cpp
 *
 *  Created on: Mar 22, 2013
 *      Author: matsuki_hidenori
 */

#include "com_mazgi_example_hmdbexample4android_JNIBridge.h"
#include <android/log.h>
#include "hmdb.hpp"
#include "HMDBCPPDriverForAndroid.h"

JNIEXPORT void JNICALL Java_com_mazgi_example_hmdbexample4android_JNIBridge_execHMDatabase
  (JNIEnv *env, jobject obj, jstring jPath)
{
	__android_log_print(ANDROID_LOG_INFO, "hmdbexample4android", "%d:in %s", __LINE__, __PRETTY_FUNCTION__);
	const char *path = env->GetStringUTFChars(jPath, 0);
	__android_log_print(ANDROID_LOG_INFO, "hmdbexample4android", "%d:path=>%s", __LINE__, path);

	using hmdb::HMDatabase;

	HMLog("compiler:[%s]", HMDB_COMPILER);
	HMLog("__cplusplus:[%ld]", __cplusplus);
	HMLog("c++98:[%d]", HMDB_CXX_DIALECT_CXX98);
	HMLog("c++11:[%d]", HMDB_CXX_DIALECT_CXX11);

	HMDatabase* db = new HMDatabase(path);
	HMLog("open:[%d]", db->open());
//	HMLog("close:[%d]", db->close());
	delete(db);

	__android_log_print(ANDROID_LOG_INFO, "hmdbexample4android", "%d:out %s", __LINE__, __PRETTY_FUNCTION__);
}
