//
//  NSObjectZUXTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/24.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface MyObject : NSObject
+ (NSString *)classMethod;
- (NSString *)instanceMethod;
+ (NSString *)swizzleClassMethod;
- (NSString *)swizzleInstanceMethod;
@end
@implementation MyObject
+ (NSString *)classMethod {
    return @"classMethod";
}
- (NSString *)instanceMethod {
    return @"instanceMethod";
}
+ (NSString *)swizzleClassMethod {
    return @"swizzleClassMethod";
}
- (NSString *)swizzleInstanceMethod {
    return @"swizzleInstanceMethod";
}
@end

@interface NSObjectZUXTest : XCTestCase

@end

@implementation NSObjectZUXTest

- (void)testNSObjectZUX {
    [MyObject swizzleClassOriSelector:@selector(classMethod) withNewSelector:@selector(swizzleClassMethod)];
    [MyObject swizzleInstanceOriSelector:@selector(instanceMethod) withNewSelector:@selector(swizzleInstanceMethod)];
    
    XCTAssertEqualObjects([MyObject classMethod], @"swizzleClassMethod");
    XCTAssertEqualObjects([MyObject swizzleClassMethod], @"classMethod");
    
    MyObject *myObject = [[MyObject alloc] init];
    XCTAssertEqualObjects([myObject instanceMethod], @"swizzleInstanceMethod");
    XCTAssertEqualObjects([myObject swizzleInstanceMethod], @"instanceMethod");
}

@end
