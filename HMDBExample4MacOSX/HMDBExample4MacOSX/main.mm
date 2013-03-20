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
        using hmdb::HMDatabase;
        using hmdb::HMDatabaseRef;
        using hmdb::HMError;
        using hmdb::HMRecordReader;

        HMError *err = nullptr;
        HMDatabaseRef db(new HMDatabase("/tmp/tmp.db"));

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
            HMLog("RECORD:CREATED[%d]", db->executeQuery(err,
                                                         "INSERT INTO SAMPLE_TABLE("
                                                         " DBL_COL,"
                                                         " INT_COL,"
                                                         " NULL_COL,"
                                                         " CHAR_COL,"
                                                         " STR_COL"
                                                         ")"
                                                         "VALUES(?, ?, ?, ?, ?)",
                                                         0.0, i, nullptr, "char*[0]", std::string("str[0]")
                                                         ));
        }
        {
            HMRecordReader *reader = nullptr;
            while (reader->next()) {
//                reader[0];
            }
            HMLog("RECORD:READED[%d]", db->executeQueryForRead(
                                                               err,
                                                               reader,
                                                               "SELECT * FROM SAMPLE_TABLE"
                                                               " WHERE DBL_COL=?"
                                                               " OR INT_COL > ?"
                                                               " OR NULL_COL = ?"
                                                               " OR CHAR_COL = ?"
                                                               " OR STR_COL IN(?)",
                                                               1.0, 2, nullptr, "str4", std::string("str5")
                                                               ));
        }
        for (int i = 0; i < 10; i++) {
            double d = i + 0.1;
            HMLog("RECORD:UPDATED[%d]", db->executeQuery(err,
                                                         "UPDATE SAMPLE_TABLE"
                                                         " SET DBL_COL = ?"
                                                         " WHERE INT_COL = ?",
                                                         d, i));
        }
        HMLog("BEGIN TRANSACTION[%d]", db->beginTransaction());
        for (int i = 0; i < 10; i += 2) {
            HMLog("RECORD:DELETED[%d]", db->executeQuery(err,
                                                         "DELETE FROM SAMPLE_TABLE"
                                                         " WHERE INT_COL = ?",
                                                         i));
        }
        HMLog("COMMIT TRANSACTION[%d]", db->commitTransaction());
        HMLog("BEGIN TRANSACTION[%d]", db->beginTransaction());
        for (int i = 1; i < 10; i += 2) {
            HMLog("RECORD:DELETED[%d]", db->executeQuery(err,
                                                         "DELETE FROM SAMPLE_TABLE"
                                                         " WHERE INT_COL = ?",
                                                         i));
        }
        HMLog("ROLLBACK TRANSACTION[%d]", db->rollbackTransaction());
        HMLog("DB:CLOSED[%d]", db->close());
    }
};

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        Driver driver;
        driver.run();
    }
    return 0;
}

