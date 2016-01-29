//
//  ZUXTransform.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXConstraint_h
#define ZUtilsX_ZUXConstraint_h

#import <UIKit/UIKit.h>
#import "zobjc.h"

typedef CGFloat (^ZUXConstraintBlock)(UIView *view);

// ZUXConstraint will copy its block.
// So use self in the block will produces self retain and circular reference.
// As far as possible use the block's parameter "view",
// or use "__weak/__block typeof(self) weakSelf = self" instead of "self".

@interface ZUXConstraint : NSObject <NSCopying>

@property (nonatomic, readonly) ZUXConstraintBlock block;

+ (ZUX_INSTANCETYPE)constraintWithBlock:(ZUXConstraintBlock)block;
- (ZUX_INSTANCETYPE)initWithBlock:(ZUXConstraintBlock)block;

- (BOOL)isEqualToConstraint:(ZUXConstraint *)constraint;

+ (ZUXConstraint *)nilConstraint;

+ (ZUXConstraint *)fullWidthConstraint;
+ (ZUXConstraint *)fullHeightConstraint;

+ (ZUXConstraint *)halfWidthConstraint;
+ (ZUXConstraint *)halfHeightConstraint;

+ (ZUXConstraint *)aThirdWidthConstraint;
+ (ZUXConstraint *)aThirdHeightConstraint;

+ (ZUXConstraint *)quarterWidthConstraint;
+ (ZUXConstraint *)quarterHeightConstraint;

@end

#endif /* ZUtilsX_ZUXConstraint_h */
