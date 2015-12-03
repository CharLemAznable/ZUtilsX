//
//  ZUXJSONKitTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/3.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUXJSONKit.h"

@interface ZUXJSONKitTest : XCTestCase

@end

@implementation ZUXJSONKitTest

- (void)testZUXJSONKit {
    ZUX_ENABLE_CATEGORY(ZUX_JSONKit);
    
    XCTAssertEqualObjects([@"Hello, World!" JSONString], @"\"Hello, World!\"");
    XCTAssertNil([@"\"Hello, World!\"" objectFromJSONString]);
    
    NSArray *array = @[@"AAA", @"BBB"];
    XCTAssertEqualObjects([array JSONString], @"[\"AAA\",\"BBB\"]");
    XCTAssertEqualObjects([@"[\"AAA\",\"BBB\"]" objectFromJSONString], array);
    
    NSDictionary *dict = @{@"1":@"AAA", @"2":@"BBB"};
    XCTAssertEqualObjects([dict JSONString], @"{\"1\":\"AAA\",\"2\":\"BBB\"}");
    XCTAssertEqualObjects([@"{\"1\":\"AAA\", \"2\":\"BBB\"}" objectFromJSONString], dict);
    
    NSDictionary *dict2 = @{@1:@"AAA", @2:@"BBB"};
    NSError *error;
    XCTAssertNil([dict2 JSONStringWithOptions:0 error:&error]);
    XCTAssertEqualObjects(error.domain, @"JKErrorDomain");
    XCTAssertEqual(error.code, -1);
    XCTAssertEqualObjects(error.userInfo[NSLocalizedDescriptionKey], @"Key must be a string object.");
}

@end
