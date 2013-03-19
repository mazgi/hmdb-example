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

        bool result = true;
        HMError *err = nullptr;
        HMResultSet *ret = nullptr;

        HMDatabaseRef db(new HMDatabase("/tmp/tmp.db"));
        result = db->open();
        result = db->executeQuery(err, "DROP TABLE IF EXISTS SAMPLE_TABLE");
        result &= db->executeQuery(err, "CREATE TABLE SAMPLE_TABLE(IDX INT, KEY TEXT, VALUE TEXT, SCORE REAL)");
        result &= db->executeQueryForRead(
                                          err,
                                          ret,
                                          "SELECT * FROM T WHERE KEY=? OR VALUE IN (?, ?, ?) OR SCORE > ?",
                                          1.0, 2, HMNull, "str4", std::string("str5")
                                          );
        result &= db->close();
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

