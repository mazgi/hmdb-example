//
//  main.m
//  HMDBExample4MacOSX
//
//  Created by Matsuki Hidenori on 3/13/13.
//  Copyright (c) 2013 Matsuki Hidenori. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "hmdb.hpp"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        using hmdb::HMDatabase;
        HMDatabase *db = new HMDatabase("/tmp/tmp.db");
        db->open();
        db->close();
        delete db;
    }
    return 0;
}

