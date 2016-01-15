//
//  UIViewControllerZUXTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/26.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface MyView : UIView
@end
@implementation MyView
@end

@interface MyViewController : UIViewController
@property (nonatomic, strong) MyView *view;
@end
@implementation MyViewController
@dynamic view;
@end

@interface UIViewControllerZUXTest : XCTestCase

@end

@implementation UIViewControllerZUXTest

- (void)testUIViewControllerZUX {
    UIViewController *controller = [[UIViewController alloc] init];
    XCTAssertTrue(controller.view.class == [UIView class]);
    
    MyViewController *myController = [[MyViewController alloc] init];
    XCTAssertTrue(myController.view.class == [MyView class]);
}

@end
