//
//  ZUXTransform.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zobjc.h"
#import "zarc.h"

@interface ZUXTransform : NSObject

@property (nonatomic, ZUX_STRONG) id left;
@property (nonatomic, ZUX_STRONG) id right;
@property (nonatomic, ZUX_STRONG) id top;
@property (nonatomic, ZUX_STRONG) id bottom;
@property (nonatomic, ZUX_STRONG) id width;
@property (nonatomic, ZUX_STRONG) id height;
@property (nonatomic, ZUX_STRONG) id centerX;
@property (nonatomic, ZUX_STRONG) id centerY;
@property (nonatomic, ZUX_WEAK) UIView *view;

- (ZUX_INSTANCETYPE)initWithView:(UIView *)view left:(id)left right:(id)right top:(id)top bottom:(id)bottom;
- (ZUX_INSTANCETYPE)initWithView:(UIView *)view width:(id)width height:(id)height centerX:(id)centerX centerY:(id)centerY;
- (ZUX_INSTANCETYPE)initWithView:(UIView *)view left:(id)left right:(id)right top:(id)top bottom:(id)bottom width:(id)width height:(id)height centerX:(id)centerX centerY:(id)centerY;

- (BOOL)isEqualToTransform:(ZUXTransform *)transform;
- (CGRect)transformRect;

@end
