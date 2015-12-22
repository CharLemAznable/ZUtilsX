//
//  UIImageZUXTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/22.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface UIImageZUXTest : XCTestCase

@end

@implementation UIImageZUXTest

- (void)testUIImageZUX {
    ZUX_ENABLE_CATEGORY(ZUX_UIImage);
    
    UIImage *bluePoint = [UIImage imageRectWithColor:[UIColor blueColor] size:CGSizeMake(1, 1)];
    UIColor *blueDominantColor = [bluePoint dominantColor];
    XCTAssertEqualObjects(blueDominantColor, [UIColor blueColor]);
    
    UIImage *redImage = [UIImage imageRectWithColor:[UIColor redColor] size:CGSizeMake(100, 100)];
    UIColor *redDominantColor = [redImage dominantColor];
    XCTAssertEqualObjects(redDominantColor, [UIColor redColor]);
}

@end
