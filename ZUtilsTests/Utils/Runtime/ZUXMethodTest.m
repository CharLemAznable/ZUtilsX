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
+ (NSString *)classMethod;
- (NSString *)instanceMethod:(NSString *)param;
@end
@implementation MethodTestBean
+ (NSString *)classMethod { return @"classMethod"; }
- (NSString *)instanceMethod:(NSString *)param { return @"instanceMethod"; }
@end

@interface ZUXMethodTest : XCTestCase

@end

@implementation ZUXMethodTest

- (void)testZUXMethod {
    ZUXMethod *classMethod = [ZUXMethod classMethodWithName:@"classMethod" inClass:[MethodTestBean class]];
    XCTAssertEqualObjects([classMethod selectorName], @"classMethod");
    IMP classImp = [classMethod implementation];
    
    ZUXMethod *instanceMethod = [ZUXMethod instanceMethodWithName:@"instanceMethod:" inClass:[MethodTestBean class]];
    XCTAssertEqualObjects([instanceMethod selectorName], @"instanceMethod:");
    IMP instanceImp = [instanceMethod implementation];
    
    [classMethod setImplementation:instanceImp];
    [instanceMethod setImplementation:classImp];
    XCTAssertEqualObjects([MethodTestBean classMethod], @"instanceMethod");
    XCTAssertEqualObjects([[[MethodTestBean alloc] init] instanceMethod:nil], @"classMethod");
}

@end
