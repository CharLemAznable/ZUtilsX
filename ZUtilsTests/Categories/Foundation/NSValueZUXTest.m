//
//  NSValueZUXTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/22.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

typedef struct {
    int identity;
    float height;
    unsigned char flag;
} MyTestStruct;

@struct_boxed_interface(MyTestStruct)
@struct_boxed_implementation(MyTestStruct)

@interface NSValueZUXTest : XCTestCase

@end

@implementation NSValueZUXTest

- (void)testNSValueZUX {
    CGPoint point = CGPointMake(0, 10);
    NSValue *pointValue = [NSValue valueWithCGPoint:point];
    XCTAssertEqualObjects([pointValue valueForKey:@"x"], @0);
    XCTAssertEqualObjects([pointValue valueForKey:@"y"], @10);
    
    MyTestStruct testStruct = { 100, 20.0f, 'c' };
    NSValue *testStructValue = [NSValue valueWithMyTestStruct:testStruct];
    XCTAssertNotNil(testStructValue);
    MyTestStruct testStruct2 = [testStructValue MyTestStructValue];
    XCTAssertEqual(testStruct.identity, testStruct2.identity);
    XCTAssertEqual(testStruct.height, testStruct2.height);
    XCTAssertEqual(testStruct.flag, testStruct2.flag);
}

@end
