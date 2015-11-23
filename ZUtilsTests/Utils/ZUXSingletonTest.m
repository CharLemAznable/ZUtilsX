//
//  ZUXSingletonTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/23.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface MySingleton : NSObject
ZUX_SINGLETON_H
@end

@implementation MySingleton
ZUX_SINGLETOM_M
@end

@interface ZUXSingletonTest : XCTestCase

@end

@implementation ZUXSingletonTest

- (void)testMySingleton {
    XCTAssertEqual([MySingleton new], [MySingleton sharedInstance]);
    XCTAssertEqual([MySingleton sharedInstance], [[MySingleton sharedInstance] copy]);
    XCTAssertNil([MySingleton new]);
}

@end
