//
//  NSStringZUXTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/24.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface NSStringZUXTest : XCTestCase

@end

@implementation NSStringZUXTest

- (void)testExample {
    ZUX_ENABLE_CATEGORY(ZUX_NSString);
    
    NSDictionary *dict = @{@"last name":@"Doe", @"first name":@"John"};
    NSString *parametric = @"He's name is ${first name}·${last name}.";
    XCTAssertEqualObjects([parametric parametricStringWithObject:dict], @"He's name is John·Doe.");
}

@end
