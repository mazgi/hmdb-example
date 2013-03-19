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
        using hmdb::HMResultSet;
        using hmdb::HMNull;

        HMError *err = nullptr;
        HMResultSet *ret = nullptr;
        HMDatabaseRef db(new HMDatabase("/tmp/tmp.db"));

        HMLog("open db:%d", db->open());
        HMLog("drop table:%d", db->executeQuery(err, "DROP TABLE IF EXISTS SAMPLE_TABLE"));
        HMLog("crate table:%d", db->executeQuery(err,
                                                 "CREATE TABLE SAMPLE_TABLE("
                                                 " DBL_COL REAL,"
                                                 " INT_COL INT,"
                                                 " NULL_COL NONE,"
                                                 " CHAR_COL TEXT,"
                                                 " STR_COL TEXT"
                                                 ")"
                                                 ));
        HMLog("read:%d", db->executeQueryForRead(
                                                 err,
                                                 ret,
                                                 "SELECT * FROM SAMPLE_TABLE"
                                                 " WHERE DBL_COL=?"
                                                 " OR INT_COL > ?"
                                                 " OR NULL_COL = ?"
                                                 " OR CHAR_COL = ?"
                                                 " OR STR_COL IN(?)",
                                                 1.0, 2, HMNull, "str4", std::string("str5")
                                                 ));
        HMLog("close db:%d", db->close());
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

