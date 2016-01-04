//
//  UIColorZUXTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/26.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface UIColorZUXTest : XCTestCase

@end

@implementation UIColorZUXTest

- (void)testUIColorZUX {
    ZUX_ENABLE_CATEGORY(ZUX_UIColor);
    
    UIColor *integerDarkGrayColor = [UIColor colorWithIntegerRed:85 green:85 blue:85];
    UIColor *darkGrayColor = [UIColor darkGrayColor];
    XCTAssertTrue([integerDarkGrayColor isEqualToColor:darkGrayColor]);
    
    UIColor *integerLightGrayColor = [UIColor colorWithIntegerRed:170 green:170 blue:170];
    UIColor *lightGrayColor = [UIColor lightGrayColor];
    XCTAssertTrue([integerLightGrayColor isEqualToColor:lightGrayColor]);
}

@end
