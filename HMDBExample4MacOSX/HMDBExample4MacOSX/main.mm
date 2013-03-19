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
        HMError *err = nullptr;
        HMResultSet *ret = nullptr;

        HMDatabaseRef db(new HMDatabase("/tmp/tmp.db"));
        db->open();
        db->executeQueryWithResults(
                         err,
                         ret,
                         "SELECT * FROM T WHERE KEY=? OR VALUE IN (?, ?, ?) OR SCORE > ?",
                         1, "value1", "value2", "value3", 1.0
                         );
        db->close();
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

