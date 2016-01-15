//
//  NSDateZUXTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/25.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface NSDateZUXTest : XCTestCase

@end

@implementation NSDateZUXTest

- (void)testNSDateZUX {
    NSString *string = @"2015-11-25 11:48";
    NSDate *stringDate = [string dateWithDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [stringDate stringWithDateFormat:@"yyyy-MM-dd HH:mm"];
    XCTAssertEqualObjects(string, dateString);
}

@end
