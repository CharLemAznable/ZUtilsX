//
//  NSDictionaryZUXTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/24.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface NSDictionaryZUXTest : XCTestCase

@end

@implementation NSDictionaryZUXTest

- (void)setUp {
    [super setUp];
    ZUX_ENABLE_CATEGORY(ZUX_NSDictionary);
}

- (void)testNSDictionaryZUX {
    NSDictionary *dict = @{@"AAA":@"aaa"};
    NSDictionary *dictCopy = [dict deepCopy];
    NSDictionary *dictMutableCopy = [dict deepMutableCopy];
    
    XCTAssertEqualObjects(dict, dictCopy);
    XCTAssertEqualObjects(dict, dictMutableCopy);
    XCTAssertNotEqual([dict objectForKey:@"AAA"], [dictCopy objectForKey:@"AAA"]);
    XCTAssertNotEqual([dict objectForKey:@"AAA"], [dictMutableCopy objectForKey:@"AAA"]);
    XCTAssertTrue([dictMutableCopy isKindOfClass:[NSMutableDictionary class]]);
}

- (void)testNSDictionaryDirectory {
    NSDictionary *dict = @{@"AAA":@"aaa"};
    XCTAssertFalse([ZUXDirectory fileExists:@"dictionaryfile.plist"]);
    [dict writeToUserFile:@"dictionaryfile.plist"];
    XCTAssertTrue([ZUXDirectory fileExists:@"dictionaryfile.plist"]);
    NSDictionary *dict2 = [NSDictionary dictionaryWithContentsOfUserFile:@"dictionaryfile.plist"];
    XCTAssertEqualObjects(dict, dict2);
    XCTAssertTrue([ZUXDirectory deleteAllFiles]);
}

@end
