//
//  ZUXIvarTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/5.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface IvarDetailBean : NSObject
@end
@implementation IvarDetailBean
@end

@interface IvarTestBean : NSObject {
    NSString *name;
    int age;
    IvarDetailBean *detail;
    CGPoint point;
    id others;
}
@end
@implementation IvarTestBean
@end

@interface ZUXIvarTest : XCTestCase

@end

@implementation ZUXIvarTest

- (void)testZUXIvar {
    ZUXIvar *ivar = [ZUXIvar instanceIvarWithName:@"name" inClass:[IvarTestBean class]];
    XCTAssertEqualObjects([ivar name], @"name");
    XCTAssertEqualObjects([ivar typeName], @"NSString");
    XCTAssertEqualObjects([ivar typeEncoding], @"@\"NSString\"");
    
    ivar = [ZUXIvar instanceIvarWithName:@"age" inClass:[IvarTestBean class]];
    XCTAssertEqualObjects([ivar name], @"age");
    XCTAssertEqualObjects([ivar typeName], @"i");
    XCTAssertEqualObjects([ivar typeEncoding], @"i");
    
    ivar = [ZUXIvar instanceIvarWithName:@"detail" inClass:[IvarTestBean class]];
    XCTAssertEqualObjects([ivar name], @"detail");
    XCTAssertEqualObjects([ivar typeName], @"IvarDetailBean");
    XCTAssertEqualObjects([ivar typeEncoding], @"@\"IvarDetailBean\"");
    
    ivar = [ZUXIvar instanceIvarWithName:@"point" inClass:[IvarTestBean class]];
    XCTAssertEqualObjects([ivar name], @"point");
    XCTAssertEqualObjects([ivar typeName], @"{CGPoint=\"x\"d\"y\"d}");
    XCTAssertEqualObjects([ivar typeEncoding], @"{CGPoint=\"x\"d\"y\"d}");
    
    ivar = [ZUXIvar instanceIvarWithName:@"others" inClass:[IvarTestBean class]];
    XCTAssertEqualObjects([ivar name], @"others");
    XCTAssertEqualObjects([ivar typeName], @"");
    XCTAssertEqualObjects([ivar typeEncoding], @"@");
}

@end
