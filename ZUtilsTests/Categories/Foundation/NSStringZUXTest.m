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

- (void)testNSStringZUXSafe {
    NSString *string = nil;
    const char *cString = [string UTF8String];
    XCTAssert(cString == NULL);
    XCTAssertNil(@(cString));
}

- (void)testNSStringZUX {
    NSDictionary *dict = @{@"last name":@"Doe", @"first name":@"John"};
    NSString *parametric = @"He's name is ${first name}·${last name}.";
    XCTAssertEqualObjects([parametric parametricStringWithObject:dict], @"He's name is John·Doe.");
    
    NSArray *array = @[@1, @"is", @"name"];
    XCTAssertTrue([@"He's name is John·Doe. 1" containsAllOfStringInArray:array]);
    
    NSString *oriString = @"Lorem<==>ipsum=dolar>=<sit<>amet.";
    XCTAssertEqualObjects([oriString stringByReplacingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=><"] withString:@" "], @"Lorem    ipsum dolar   sit  amet.");
    XCTAssertEqualObjects([oriString stringByReplacingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=><"] withString:@" " mergeContinuous:YES], @"Lorem ipsum dolar sit amet.");
    XCTAssertEqualObjects([oriString stringByReplacingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=><"] withString:@""], @"Loremipsumdolarsitamet.");
}

@end
