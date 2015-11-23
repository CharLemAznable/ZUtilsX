//
//  ZUXGeometryTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/23.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface ZUXGeometryTest : XCTestCase

@end

@implementation ZUXGeometryTest

- (void)testGeometry {
    CGRect rect = ZUX_CGRectMake(CGPointMake(0, 10), CGSizeMake(100, 200));
    XCTAssertEqual(rect.origin.x, 0);
    XCTAssertEqual(rect.origin.y, 10);
    XCTAssertEqual(rect.size.width, 100);
    XCTAssertEqual(rect.size.height, 200);
}

@end
