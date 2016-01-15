//
//  ZUXTransform.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXConstraint.h"
#import "zarc.h"

#if NS_BLOCKS_AVAILABLE

@implementation ZUXConstraint

+ (ZUX_INSTANCETYPE)constraintWithBlock:(ZUXConstraintBlock)block {
    return ZUX_AUTORELEASE([[self alloc] initWithBlock:block]);
}

- (ZUX_INSTANCETYPE)init {
    if (ZUX_EXPECT_T(self = [super init])) _block = nil;
    return self;
}

- (ZUX_INSTANCETYPE)initWithBlock:(ZUXConstraintBlock)block {
    if (ZUX_EXPECT_T(self = [super init])) _block = ZUX_BLOCK_COPY(block);
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] allocWithZone:zone] initWithBlock:_block];
}

- (void)dealloc {
    if (ZUX_EXPECT_T(_block)) ZUX_BLOCK_RELEASE(_block);
    ZUX_SUPER_DEALLOC;
}

- (BOOL)isEqual:(id)object {
    if (object == self) return YES;
    if (!object || ![object isKindOfClass:[self class]]) return NO;
    return [self isEqualToConstraint:object];
}

- (BOOL)isEqualToConstraint:(ZUXConstraint *)constraint {
    if (constraint == self) return YES;
    if (_block == nil && constraint.block == nil) return YES;
    if (_block == nil || constraint.block == nil) return NO;
    return _block == constraint.block;
}

#pragma mark - Some Convenience Constraints -

#define ZUXConstraint_implement(constraint, block)          \
+ (ZUXConstraint *)constraint {                             \
    static dispatch_once_t once_t;                          \
    dispatch_once(&once_t, ^{                               \
        constraint = [[self alloc] initWithBlock:block];    \
    });                                                     \
    return constraint;                                      \
}

ZUXConstraint_implement(nilConstraint, nil)
ZUXConstraint_implement(fullWidthConstraint, fullWidthBlock)
ZUXConstraint_implement(fullHeightConstraint, fullHeightBlock)
ZUXConstraint_implement(halfWidthConstraint, halfWidthBlock)
ZUXConstraint_implement(halfHeightConstraint, halfHeightBlock)
ZUXConstraint_implement(aThirdWidthConstraint, aThirdWidthBlock)
ZUXConstraint_implement(aThirdHeightConstraint, aThirdHeightBlock)
ZUXConstraint_implement(quarterWidthConstraint, quarterWidthBlock)
ZUXConstraint_implement(quarterHeightConstraint, quarterHeightBlock)

#pragma mark - multi singleton instances

static ZUXConstraint *nilConstraint = nil;
static ZUXConstraint *fullWidthConstraint = nil;
static ZUXConstraint *fullHeightConstraint = nil;
static ZUXConstraint *halfWidthConstraint = nil;
static ZUXConstraint *halfHeightConstraint = nil;
static ZUXConstraint *aThirdWidthConstraint = nil;
static ZUXConstraint *aThirdHeightConstraint = nil;
static ZUXConstraint *quarterWidthConstraint = nil;
static ZUXConstraint *quarterHeightConstraint = nil;

#pragma mark - static constraint blocks

static ZUXConstraintBlock fullWidthBlock = ^CGFloat(UIView *view) {
    return view.bounds.size.width;
};
static ZUXConstraintBlock fullHeightBlock = ^CGFloat(UIView *view) {
    return view.bounds.size.height;
};
static ZUXConstraintBlock halfWidthBlock = ^CGFloat(UIView *view) {
    return view.bounds.size.width / 2;
};
static ZUXConstraintBlock halfHeightBlock = ^CGFloat(UIView *view) {
    return view.bounds.size.height / 2;
};
static ZUXConstraintBlock aThirdWidthBlock = ^CGFloat(UIView *view) {
    return view.bounds.size.width / 3;
};
static ZUXConstraintBlock aThirdHeightBlock = ^CGFloat(UIView *view) {
    return view.bounds.size.height / 3;
};
static ZUXConstraintBlock quarterWidthBlock = ^CGFloat(UIView *view) {
    return view.bounds.size.width / 4;
};
static ZUXConstraintBlock quarterHeightBlock = ^CGFloat(UIView *view) {
    return view.bounds.size.height / 4;
};

@end

#endif // NS_BLOCKS_AVAILABLE
