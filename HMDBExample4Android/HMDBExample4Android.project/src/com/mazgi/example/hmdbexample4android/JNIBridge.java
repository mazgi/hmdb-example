package com.mazgi.example.hmdbexample4android;

import java.io.File;

import android.util.Log;

public class JNIBridge {
	private File filesDir = null;
	static {
		System.loadLibrary("HMDBCPPDriverForAndroid");
	}
	private File getFilesDir() {
		return filesDir;
	}
	public void setFilesDir(File databaseFile) {
		this.filesDir = databaseFile;
	}
	public void run() {
		Log.i("HMDBCPPDriverForAndroid", "running execHMDatabase.");
		String path = getFilesDir().toString() + "/sample.sqlite3";
		Log.i("HMDBCPPDriverForAndroid", "database file path=>" + path);
		File old = new File(path);
		if (old.exists()) {
			Log.i("HMDBCPPDriverForAndroid", "deleting old database file...");
			old.delete();
		}
		execHMDatabase(path);
	}
	private native void execHMDatabase(String path);
}
