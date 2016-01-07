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
    
    NSObject *nilObject = nil;
    XCTAssertNil(dict[nilObject]);
    XCTAssertEqualObjects([dict objectForKey:nilObject defaultValue:@"bbb"], @"bbb");
    ((NSMutableDictionary *)dictMutableCopy)[[nilObject description]] = @"bbb";
    XCTAssertNil(dict[nilObject]);
    [((NSMutableDictionary *)dictMutableCopy) setObject:nilObject forKey:@"AAA"];
    XCTAssertNotNil(dictMutableCopy[@"AAA"]);
    XCTAssertEqualObjects([dictMutableCopy objectForKey:@"AAA" defaultValue:@"bbb"], @"aaa");
    ((NSMutableDictionary *)dictMutableCopy)[@"AAA"] = nilObject;
    XCTAssertNotNil(dictMutableCopy[@"AAA"]);
    XCTAssertEqualObjects([dictMutableCopy objectForKey:@"AAA" defaultValue:@"bbb"], @"aaa");
    [((NSMutableDictionary *)dictMutableCopy) removeObjectForKey:@"AAA"];
    XCTAssertNil(dictMutableCopy[@"AAA"]);
    XCTAssertEqualObjects([dictMutableCopy objectForKey:@"AAA" defaultValue:@"bbb"], @"bbb");
}

- (void)testNSDictionarySafe {
    NSString *nilStr = nil;
    
    NSDictionary *dict = @{@"AAA":@"aaa", [NSNull null]:@"nil", @"nil":[NSNull null]};
    XCTAssertNil([dict objectForKey:nilStr]);
    XCTAssertNil(dict[nilStr]);
    XCTAssertEqualObjects([dict objectForKey:nilStr defaultValue:@"bbb"], @"bbb");
    XCTAssertNotNil([dict objectForKey:[NSNull null]]);
    XCTAssertNotNil(dict[[NSNull null]]);
    XCTAssertEqualObjects([dict objectForKey:[NSNull null] defaultValue:@"bbb"], @"nil");
    XCTAssertNotNil([dict objectForKey:@"nil"]);
    XCTAssertNotNil(dict[@"nil"]);
    XCTAssertEqualObjects([dict objectForKey:@"nil" defaultValue:@"bbb"], @"bbb");
    
    NSMutableDictionary *dictMutable = [dict mutableCopy];
    XCTAssertNil([dictMutable objectForKey:nilStr]);
    XCTAssertNil(dictMutable[nilStr]);
    XCTAssertEqualObjects([dictMutable objectForKey:nilStr defaultValue:@"bbb"], @"bbb");
    XCTAssertNotNil([dictMutable objectForKey:[NSNull null]]);
    XCTAssertNotNil(dictMutable[[NSNull null]]);
    XCTAssertEqualObjects([dictMutable objectForKey:[NSNull null] defaultValue:@"bbb"], @"nil");
    XCTAssertNotNil([dictMutable objectForKey:@"nil"]);
    XCTAssertNotNil(dictMutable[@"nil"]);
    XCTAssertEqualObjects([dictMutable objectForKey:@"nil" defaultValue:@"bbb"], @"bbb");
    
    [dictMutable setObject:@"ccc" forKey:nilStr];
    XCTAssertNil([dictMutable objectForKey:nilStr]);
    XCTAssertNil(dictMutable[nilStr]);
    XCTAssertEqualObjects([dictMutable objectForKey:nilStr defaultValue:@"bbb"], @"bbb");
    dictMutable[nilStr] = @"ccc";
    XCTAssertNil([dictMutable objectForKey:nilStr]);
    XCTAssertNil(dictMutable[nilStr]);
    XCTAssertEqualObjects([dictMutable objectForKey:nilStr defaultValue:@"bbb"], @"bbb");
    [dictMutable setObject:@"ccc" forKey:[NSNull null]];
    XCTAssertNotNil([dictMutable objectForKey:[NSNull null]]);
    XCTAssertNotNil(dictMutable[[NSNull null]]);
    XCTAssertEqualObjects([dictMutable objectForKey:[NSNull null] defaultValue:@"bbb"], @"ccc");
    dictMutable[[NSNull null]] = @"ccc";
    XCTAssertNotNil([dictMutable objectForKey:[NSNull null]]);
    XCTAssertNotNil(dictMutable[[NSNull null]]);
    XCTAssertEqualObjects([dictMutable objectForKey:[NSNull null] defaultValue:@"bbb"], @"ccc");
    
    [dictMutable setObject:nilStr forKey:@"AAA"];
    XCTAssertNotNil([dictMutable objectForKey:@"AAA"]);
    XCTAssertNotNil(dictMutable[@"AAA"]);
    XCTAssertEqualObjects([dictMutable objectForKey:@"AAA" defaultValue:@"bbb"], @"aaa");
    dictMutable[@"AAA"] = nilStr;
    XCTAssertNotNil([dictMutable objectForKey:@"AAA"]);
    XCTAssertNotNil(dictMutable[@"AAA"]);
    XCTAssertEqualObjects([dictMutable objectForKey:@"AAA" defaultValue:@"bbb"], @"aaa");
    [dictMutable setObject:[NSNull null] forKey:@"AAA"];
    XCTAssertNotNil([dictMutable objectForKey:@"AAA"]);
    XCTAssertNotNil(dictMutable[@"AAA"]);
    XCTAssertEqualObjects([dictMutable objectForKey:@"AAA" defaultValue:@"bbb"], @"bbb");
    dictMutable[@"AAA"] = [NSNull null];
    XCTAssertNotNil([dictMutable objectForKey:@"AAA"]);
    XCTAssertNotNil(dictMutable[@"AAA"]);
    XCTAssertEqualObjects([dictMutable objectForKey:@"AAA" defaultValue:@"bbb"], @"bbb");
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
