/*
 * HMDBCPPDriverForAndroid.cpp
 *
 *  Created on: Mar 13, 2013
 *      Author: mazgi
 */

#include "HMDBCPPDriverForAndroid.h"
#include "hmdb.hpp"

HMDBCPPDriverForAndroid::HMDBCPPDriverForAndroid() {
	// TODO Auto-generated constructor stub
}

HMDBCPPDriverForAndroid::~HMDBCPPDriverForAndroid() {
	// TODO Auto-generated destructor stub
}

void HMDBCPPDriverForAndroid::run(const char* path) {
    using hmdb::HMDatabase;
    using hmdb::HMError;
    using hmdb::HMRecordReader;

    HMError *err = HMDB_NULL;
    HMDatabase* db = new HMDatabase(path);

    HMLog("DB:OPENED[%d]", db->open());
    HMLog("TABLE:DROPED[%d]", db->executeFormattedQuery(err, "DROP TABLE IF EXISTS SAMPLE_TABLE"));
    HMLog("TABLE:CREATED[%d]", db->executeFormattedQuery(err,
                                                         "CREATE TABLE SAMPLE_TABLE("
                                                         "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
                                                         " DBL_COL REAL,"
                                                         " INT_COL INT,"
                                                         " NULL_COL NONE,"
                                                         " CHAR_COL TEXT,"
                                                         " STR_COL TEXT"
                                                         ")"
                                                         ));
    for (int i = 0; i < 10; i++) {
        HMLog("RECORD:CREATED[%d]", db->executeFormattedQuery(err,
                                                              "INSERT INTO SAMPLE_TABLE("
                                                              " DBL_COL,"
                                                              " INT_COL,"
                                                              " NULL_COL,"
                                                              " CHAR_COL,"
                                                              " STR_COL"
                                                              ")"
                                                              "VALUES(%f, %d, %s, %s, %s)",
                                                              0.0, i, HMDB_NULL, "char*[0]", "str[0]"
                                                              ));
    }
    {
        HMRecordReader *reader = HMDB_NULL;
        HMLog("RECORD:READED[%d]", db->executeFormattedQueryForRead(
                                                                    err,
                                                                    reader,
                                                                    "SELECT * FROM SAMPLE_TABLE"
                                                                    " WHERE DBL_COL=%f"
                                                                    " OR INT_COL>%d"
                                                                    " OR NULL_COL = %s"
                                                                    " OR CHAR_COL = %s"
                                                                    " OR STR_COL IN(%s)",
                                                                    1.0, 2, "HMDB_NULL", "str", "str5"
                                                                    ));
        while (reader && reader->next()) {
            HMLog("DBL_COL:%f", reader->doubleValue("DBL_COL"));
        }
    }
    for (int i = 0; i < 10; i++) {
        double d = i + 0.1;
        HMLog("RECORD:UPDATED[%d]", db->executeFormattedQuery(err,
                                                              "UPDATE SAMPLE_TABLE"
                                                              " SET DBL_COL = %f"
                                                              " WHERE INT_COL = %d",
                                                              d, i));
    }
    {
        HMRecordReader *reader = HMDB_NULL;
        HMLog("RECORD:READED[%d]", db->executeFormattedQueryForRead(
                                                                    err,
                                                                    reader,
                                                                    "SELECT * FROM SAMPLE_TABLE"
                                                                    " WHERE DBL_COL=%f"
                                                                    " OR INT_COL > %d"
                                                                    " OR NULL_COL = %s"
                                                                    " OR CHAR_COL = %s"
                                                                    " OR STR_COL IN(%s)",
                                                                    1.0, 2, HMDB_NULL, "str4", "str5"
                                                                    ));
        while (reader && reader->next()) {
            HMLog("ID:%d", reader->intValue("ID"));
            HMLog("DBL_COL:%f", reader->doubleValue("DBL_COL"));
            HMLog("INT_COL:%d", reader->intValue("INT_COL"));
            HMLog("DBL_COL:%s", reader->textValue("NULL_COL"));
            HMLog("DBL_COL:%s", reader->textValue("CHAR_COL"));
            HMLog("DBL_COL:%s", reader->textValue("STR_COL"));
        }
    }
    HMLog("BEGIN TRANSACTION[%d]", db->beginTransaction());
    for (int i = 0; i < 10; i += 2) {
        HMLog("RECORD:DELETED[%d]", db->executeFormattedQuery(err,
                                                              "DELETE FROM SAMPLE_TABLE"
                                                              " WHERE INT_COL = %d",
                                                              i));
    }
    HMLog("COMMIT TRANSACTION[%d]", db->commitTransaction());
    HMLog("BEGIN TRANSACTION[%d]", db->beginTransaction());
    for (int i = 1; i < 10; i += 2) {
        HMLog("RECORD:DELETED[%d]", db->executeFormattedQuery(err,
                                                              "DELETE FROM SAMPLE_TABLE"
                                                              " WHERE INT_COL = %d",
                                                              i));
    }
    HMLog("ROLLBACK TRANSACTION[%d]", db->rollbackTransaction());
    HMLog("DB:CLOSED[%d]", db->close());
}
