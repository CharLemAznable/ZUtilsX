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
    
    CGFloat idr, idg, idb, ida;
    [integerDarkGrayColor getRed:&idr green:&idg blue:&idb alpha:&ida];
    
    CGFloat dr, dg, db, da;
    [darkGrayColor getRed:&dr green:&dg blue:&db alpha:&da];
    
    XCTAssertEqual(idr, dr);
    XCTAssertEqual(idg, dg);
    XCTAssertEqual(idb, db);
    XCTAssertEqual(ida, da);
    
    UIColor *integerLightGrayColor = [UIColor colorWithIntegerRed:170 green:170 blue:170];
    UIColor *lightGrayColor = [UIColor lightGrayColor];
    
    CGFloat ilr, ilg, ilb, ila;
    [integerLightGrayColor getRed:&ilr green:&ilg blue:&ilb alpha:&ila];
    
    CGFloat lr, lg, lb, la;
    [lightGrayColor getRed:&lr green:&lg blue:&lb alpha:&la];
    
    XCTAssertEqual(ilr, lr);
    XCTAssertEqual(ilg, lg);
    XCTAssertEqual(ilb, lb);
    XCTAssertEqual(ila, la);
}

@end
