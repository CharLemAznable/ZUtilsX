//
//  ZUXMethodTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/5.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface MethodTestBean : NSObject
+ (NSString *)classMethod1;
+ (NSString *)classMethod2;
- (NSString *)instanceMethod1:(NSString *)param;
- (NSString *)instanceMethod2:(NSString *)param;
@end
@implementation MethodTestBean
+ (NSString *)classMethod1 { return @"classMethod1"; }
+ (NSString *)classMethod2 { return @"classMethod2"; }
- (NSString *)instanceMethod1:(NSString *)param { return @"instanceMethod1"; }
- (NSString *)instanceMethod2:(NSString *)param { return @"instanceMethod2"; }
@end

@interface ZUXMethodTest : XCTestCase

@end

@implementation ZUXMethodTest

- (void)testZUXMethod {
    ZUXMethod *method1 = [ZUXMethod classMethodWithName:@"classMethod1" inClass:[MethodTestBean class]];
    ZUXMethod *method2 = [ZUXMethod classMethodWithName:@"classMethod2" inClass:[MethodTestBean class]];
    XCTAssertEqualObjects([method1 selectorName], @"classMethod1");
    XCTAssertEqualObjects([method2 selectorName], @"classMethod2");
    IMP imp1 = [method1 implementation];
    IMP imp2 = [method2 implementation];
    [method1 setImplementation:imp2];
    [method2 setImplementation:imp1];
    XCTAssertEqualObjects([MethodTestBean classMethod1], @"classMethod2");
    XCTAssertEqualObjects([MethodTestBean classMethod2], @"classMethod1");
    
    
    method1 = [ZUXMethod instanceMethodWithName:@"instanceMethod1:" inClass:[MethodTestBean class]];
    method2 = [ZUXMethod instanceMethodWithName:@"instanceMethod2:" inClass:[MethodTestBean class]];
    XCTAssertEqualObjects([method1 selectorName], @"instanceMethod1:");
    XCTAssertEqualObjects([method2 selectorName], @"instanceMethod2:");
    imp1 = [method1 implementation];
    imp2 = [method2 implementation];
    [method1 setImplementation:imp2];
    [method2 setImplementation:imp1];
    XCTAssertEqualObjects([[[MethodTestBean alloc] init] instanceMethod1:nil], @"instanceMethod2");
    XCTAssertEqualObjects([[[MethodTestBean alloc] init] instanceMethod2:nil], @"instanceMethod1");
    
}

@end
