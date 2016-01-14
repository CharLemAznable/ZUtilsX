//
//  ZUXSingletonTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/23.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"
#import "MySingleton.h"
#import "MySubSingleton.h"

@interface ZUXSingletonTest : XCTestCase

@end

@implementation ZUXSingletonTest

- (void)testMySingleton {
    XCTAssertEqual([MySingleton new], [MySingleton sharedInstance]);
    XCTAssertEqual([MySingleton sharedInstance], [[MySingleton sharedInstance] copy]);
    XCTAssertNil([MySingleton new]);
    XCTAssertEqual([MySubSingleton new], [MySubSingleton sharedInstance]);
    XCTAssertEqual([MySubSingleton sharedInstance], [[MySubSingleton sharedInstance] copy]);
    XCTAssertNil([MySubSingleton new]);
    XCTAssertNotEqual([MySingleton sharedInstance], [MySubSingleton sharedInstance]);
}

@end
