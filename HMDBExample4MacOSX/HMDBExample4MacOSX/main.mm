//
//  main.m
//  HMDBExample4MacOSX
//
//  Created by Matsuki Hidenori on 3/13/13.
//  Copyright (c) 2013 Matsuki Hidenori. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "hmdb.hpp"

class Driver {
public:
    void run()
    {
#if HMDB_CXX_DIALECT_CXX11
        using hmdb::HMDatabaseRef;
#endif
        using hmdb::HMDatabase;
        using hmdb::HMError;
        using hmdb::HMRecordReader;

        HMError *err = HMDB_NULL;
#if HMDB_CXX_DIALECT_CXX11
        HMDatabaseRef db(new HMDatabase("/tmp/tmp.db"));
#else
        HMDatabase *db = new HMDatabase("/tmp/tmp.db");
#endif
        HMLog("DB:OPENED[%d]", db->open());
        HMLog("TABLE:DROPED[%d]", db->executeQuery(err, "DROP TABLE IF EXISTS SAMPLE_TABLE"));
        HMLog("TABLE:CREATED[%d]", db->executeQuery(err,
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
#if HMDB_CXX_FEATURE_CXX_VARIADIC_TEMPLATES
            HMLog("RECORD:CREATED[%d]", db->executeQuery(err,
                                                         "INSERT INTO SAMPLE_TABLE("
                                                         " DBL_COL,"
                                                         " INT_COL,"
                                                         " NULL_COL,"
                                                         " CHAR_COL,"
                                                         " STR_COL"
                                                         ")"
                                                         "VALUES(?, ?, ?, ?, ?)",
                                                         0.0, i, HMDB_NULL, "char*[0]", std::string("str[0]")
                                                         ));
#endif
        }
        {
            HMRecordReader *reader = HMDB_NULL;
#if HMDB_CXX_FEATURE_CXX_VARIADIC_TEMPLATES
            HMLog("RECORD:READED[%d]", db->executeQueryForRead(
                                                               err,
                                                               reader,
                                                               "SELECT * FROM SAMPLE_TABLE"
                                                               " WHERE DBL_COL=?"
                                                               " OR INT_COL > ?"
                                                               " OR NULL_COL = ?"
                                                               " OR CHAR_COL = ?"
                                                               " OR STR_COL IN(?)",
                                                               1.0, 2, HMDB_NULL, "str4", std::string("str5")
                                                               ));
#endif
            while (reader && reader->next()) {
                HMLog("DBL_COL:%f", reader->doubleValue("DBL_COL"));
            }
        }
        for (int i = 0; i < 10; i++) {
#if HMDB_CXX_FEATURE_CXX_VARIADIC_TEMPLATES
            double d = i + 0.1;
            HMLog("RECORD:UPDATED[%d]", db->executeQuery(err,
                                                         "UPDATE SAMPLE_TABLE"
                                                         " SET DBL_COL = ?"
                                                         " WHERE INT_COL = ?",
                                                         d, i));
#endif
        }
        {
            HMRecordReader *reader = HMDB_NULL;
#if HMDB_CXX_FEATURE_CXX_VARIADIC_TEMPLATES
            HMLog("RECORD:READED[%d]", db->executeQueryForRead(
                                                               err,
                                                               reader,
                                                               "SELECT * FROM SAMPLE_TABLE"
                                                               " WHERE DBL_COL=?"
                                                               " OR INT_COL > ?"
                                                               " OR NULL_COL = ?"
                                                               " OR CHAR_COL = ?"
                                                               " OR STR_COL IN(?)",
                                                               1.0, 2, HMDB_NULL, "str4", std::string("str5")
                                                               ));
#endif
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
#if HMDB_CXX_FEATURE_CXX_VARIADIC_TEMPLATES
            HMLog("RECORD:DELETED[%d]", db->executeQuery(err,
                                                         "DELETE FROM SAMPLE_TABLE"
                                                         " WHERE INT_COL = ?",
                                                         i));
#endif
        }
        HMLog("COMMIT TRANSACTION[%d]", db->commitTransaction());
        HMLog("BEGIN TRANSACTION[%d]", db->beginTransaction());
        for (int i = 1; i < 10; i += 2) {
#if HMDB_CXX_FEATURE_CXX_VARIADIC_TEMPLATES
            HMLog("RECORD:DELETED[%d]", db->executeQuery(err,
                                                         "DELETE FROM SAMPLE_TABLE"
                                                         " WHERE INT_COL = ?",
                                                         i));
#endif
        }
        HMLog("ROLLBACK TRANSACTION[%d]", db->rollbackTransaction());
        HMLog("DB:CLOSED[%d]", db->close());
#if !HMDB_CXX_DIALECT_CXX11
        delete db;
#endif
    }
};

int main(int argc, const char * argv[])
{
    Driver driver;
    driver.run();
    return 0;
}

