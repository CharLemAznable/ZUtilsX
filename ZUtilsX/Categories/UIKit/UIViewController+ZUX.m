//
//  UIViewController+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/17.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UIViewController+ZUX.h"
#import "NSObject+ZUX.h"
#import "ZUXRuntime.h"
#import "zarc.h"
#import <objc/runtime.h>

ZUX_CATEGORY_M(ZUX_UIViewController)

@implementation UIViewController (ZUX)

#pragma mark - Swizzle & Override Methods.

+ (void)load {
    [super load];
    
    ZUX_ENABLE_CATEGORY(ZUX_NSObject);
    // swizzle loadView
    [self swizzleInstanceOriSelector:@selector(loadView)
                     withNewSelector:@selector(zuxLoadView)];
}

- (void)zuxLoadView {
    [self zuxLoadView];
    
    NSString *viewClassName = ZUX_GetPropertyClassName([self class], @"view");
    if (!viewClassName || [@"UIView" isEqualToString:viewClassName]) return;
    
    Class viewClass = NSClassFromString(viewClassName);
    if (![viewClass isSubclassOfClass:[UIView class]]) return;
    
    self.view = ZUX_AUTORELEASE([[viewClass alloc] initWithFrame:self.view.frame]);
}

@end
