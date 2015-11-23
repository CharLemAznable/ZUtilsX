//
//  ZUXDirectoryTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/23.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface ZUXDirectoryTest : XCTestCase

@end

@implementation ZUXDirectoryTest

- (void)testExample {
    XCTAssertFalse([ZUXDirectory fileExists:@"tempfile"]);
    XCTAssertTrue([ZUXDirectory createDirectory:@"tempfile"]);
    XCTAssertTrue([ZUXDirectory fileExists:@"tempfile"]);
    XCTAssertTrue([ZUXDirectory deleteAllFiles]);
}

@end
