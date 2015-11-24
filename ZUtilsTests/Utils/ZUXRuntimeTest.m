//
//  ZUXRuntimeTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/23.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface Detail : NSObject
@end
@implementation Detail
@end

@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, strong) Detail *detail;
@property (nonatomic, strong) id others;
@end
@implementation Person
@end

@interface ZUXRuntimeTest : XCTestCase

@end

@implementation ZUXRuntimeTest

- (void)testRuntime {
    XCTAssertEqualObjects(ZUX_GetPropertyClassName([Person class], @"name"), @"NSString");
    XCTAssertEqualObjects(ZUX_GetPropertyClassName([Person class], @"age"), @"int");
    XCTAssertEqualObjects(ZUX_GetPropertyClassName([Person class], @"detail"), @"Detail");
    XCTAssertNil(ZUX_GetPropertyClassName([Person class], @"others"));
}

@end
