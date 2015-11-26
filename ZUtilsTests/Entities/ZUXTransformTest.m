//
//  ZUXTransformTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/26.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface ZUXTransformTest : XCTestCase

@end

@implementation ZUXTransformTest

- (void)testZUXTransform {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 1000)];
    
    ZUXTransform *transform1 = [[ZUXTransform alloc] initWithView:view left:@20 right:@30 top:@40 bottom:@50];
    XCTAssertTrue(CGRectEqualToRect([transform1 transformRect], CGRectMake(20, 40, 450, 910)));
    
    ZUXTransform *transform2 = [[ZUXTransform alloc] initWithView:view width:[ZUXConstraint constraintWithBlock:^CGFloat(UIView *view) { return view.bounds.size.width / 5 * 2; }] height:[ZUXConstraint constraintWithBlock:^CGFloat(UIView *view) { return view.bounds.size.height / 10 * 3; }] centerX:@"bounds.#size.width / 5" centerY:[NSExpression expressionWithParametricFormat:@"bounds.#size.height / 5"]];
    XCTAssertTrue(CGRectEqualToRect([transform2 transformRect], CGRectMake(0, 50, 200, 300)));
    
    view.frame = CGRectMake(0, 0, 50, 100);
    XCTAssertTrue(CGRectEqualToRect([transform2 transformRect], CGRectMake(0, 5, 20, 30)));
}

@end
