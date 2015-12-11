//
//  ZUXColorDictionaryTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/11.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface ZUXColorDictionaryTest : XCTestCase

@end

@implementation ZUXColorDictionaryTest

- (void)testZUXColorDictionary {
    ZUXColorDictionary *dict = [[ZUXColorDictionary alloc] initWithContentsOfUserFile:@"ZUXColorDictionaryTest" bundle:nil];
    XCTAssertEqualObjects(dict[@"blackColor"], [UIColor colorWithRed:0 green:0 blue:0 alpha:1]);
    XCTAssertEqualObjects(dict[@"whiteColor"], [UIColor colorWithRed:1 green:1 blue:1 alpha:1]);
    [dict reloadWithContentsOfUserFile:@"ZUXColorDictionaryTest2" bundle:nil];
    XCTAssertEqualObjects(dict[@"blackColor"], [UIColor colorWithRed:1 green:1 blue:1 alpha:1]);
    XCTAssertEqualObjects(dict[@"whiteColor"], [UIColor colorWithRed:0 green:0 blue:0 alpha:1]);
}

@end
