//
//  ZUXConstraintTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/26.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface ZUXConstraintTest : XCTestCase

@end

@implementation ZUXConstraintTest

- (void)testZUXConstraint {
    XCTAssertEqualObjects([ZUXConstraint nilConstraint],
                          [ZUXConstraint constraintWithBlock:nil]);
    XCTAssertNotEqualObjects([ZUXConstraint fullWidthConstraint],
                             [ZUXConstraint constraintWithBlock:
                              ^CGFloat(UIView *view) {
                                  return view.bounds.size.width;
                              }]);
}

@end
