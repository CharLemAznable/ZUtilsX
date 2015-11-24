//
//  NSArrayZUXTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/24.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface NSArrayZUXTest : XCTestCase

@end

@implementation NSArrayZUXTest

- (void)setUp {
    [super setUp];
    ZUX_ENABLE_CATEGORY(ZUX_NSArray);
}

- (void)testNSArrayZUX {
    NSArray *array = @[@"AAA"];
    NSArray *arrayCopy = [array deepCopy];
    NSArray *arrayMutableCopy = [array deepMutableCopy];
    
    XCTAssertEqualObjects(array, arrayCopy);
    XCTAssertEqualObjects(array, arrayMutableCopy);
    XCTAssertNotEqual(array[0], arrayCopy[0]);
    XCTAssertNotEqual(array[0], arrayMutableCopy[0]);
    XCTAssertTrue([arrayMutableCopy isKindOfClass:[NSMutableArray class]]);
}

- (void)testNSArrayDirectory {
    NSArray *array = @[@"AAA"];
    XCTAssertFalse([ZUXDirectory fileExists:@"arrayfile.plist"]);
    [array writeToUserFile:@"arrayfile.plist"];
    XCTAssertTrue([ZUXDirectory fileExists:@"arrayfile.plist"]);
    NSArray *array2 = [NSArray arrayWithContentsOfUserFile:@"arrayfile.plist"];
    XCTAssertEqualObjects(array, array2);
    XCTAssertTrue([ZUXDirectory deleteAllFiles]);
}

@end
