//
//  UIView+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UIView+ZUX.h"
#import "NSObject+ZUX.h"
#import "NSNull+ZUX.h"
#import "NSNumber+ZUX.h"
#import "NSString+ZUX.h"
#import "UILabel+ZUX.h"
#import "ZUXTransform.h"
#import "zadapt.h"
#import "zappearance.h"
#import <objc/runtime.h>

ZUX_CATEGORY_M(ZUX_UIView)

@implementation UIView (ZUX)

#pragma mark - Properties Methods -

- (BOOL)masksToBounds {
    return self.layer.masksToBounds;
}

- (void)setMasksToBounds:(BOOL)masksToBounds {
    self.layer.masksToBounds = masksToBounds;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)shadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

- (float)shadowOpacity {
    return self.layer.shadowOpacity;
}

- (void)setShadowOpacity:(float)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;
}

- (CGSize)shadowOffset {
    return self.layer.shadowOffset;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

- (CGFloat)shadowSize {
    return self.layer.shadowRadius;
}

- (void)setShadowSize:(CGFloat)shadowSize {
    self.layer.shadowRadius = shadowSize;
}

- (UIImage *)imageRepresentation {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

#pragma mark - AutoLayout -

NSString *const zLayoutKVOContext           = @"ZLayoutKVOContext";
NSString *const zTransformKVOKey            = @"zTransform";
NSString *const zTransformLeftKVOKey        = @"left";
NSString *const zTransformRightKVOKey       = @"right";
NSString *const zTransformTopKVOKey         = @"top";
NSString *const zTransformBottomKVOKey      = @"bottom";
NSString *const zTransformWidthKVOKey       = @"width";
NSString *const zTransformHeightKVOKey      = @"height";
NSString *const zTransformCenterXKVOKey     = @"centerX";
NSString *const zTransformCenterYKVOKey     = @"centerY";
NSString *const zTransformViewKVOKey        = @"view";
NSString *const zTransformViewFrameKVOKey   = @"frame";
NSString *const zTransformViewBoundsKVOKey  = @"bounds";

@implementation UIView (ZUXAutoLayout)

- (ZUX_INSTANCETYPE)initWithTransform:(ZUXTransform *)transform {
    if (ZUX_EXPECT_T(self = [self init])) {
        objc_setAssociatedObject(self, (ZUX_BRIDGE const void *)(zTransformKVOKey),
                                 transform, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (transform && !transform.view) transform.view = self.superview; // default transform by superview
        [self p_AddObserversToTransform:transform];
        [self p_AddFrameAndBoundsObserversToView:transform.view];
    }
    return self;
}

#pragma mark - Swizzle & Override Methods -

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        ZUX_ENABLE_CATEGORY(ZUX_NSObject);
        // observe superview change
        [self swizzleInstanceOriSelector:@selector(willMoveToSuperview:)
                         withNewSelector:@selector(zuxWillMoveToSuperview:)];
#if !IS_ARC
        // dealloc with removeObserver
        [self swizzleInstanceOriSelector:@selector(dealloc)
                         withNewSelector:@selector(zuxAutoLayoutDealloc)];
#endif
    });
}

- (void)zuxWillMoveToSuperview:(UIView *)newSuperview {
    [self zuxWillMoveToSuperview:newSuperview];
    if (self.zTransform && !self.zTransform.view) { // default transform by superview
        self.zTransform.view = newSuperview;
        [self p_AddFrameAndBoundsObserversToView:self.zTransform.view];
    }
}

- (void)zuxAutoLayoutDealloc {
    [self p_RemoveFrameAndBoundsObserversFromView:self.zTransform.view];
    [self p_RemoveObserversFromTransform:self.zTransform];
    objc_setAssociatedObject(self, (ZUX_BRIDGE const void *)(zTransformKVOKey),
                             nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self zuxAutoLayoutDealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (![zLayoutKVOContext isEqual:(ZUX_BRIDGE id)(context)]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    if (([object isEqual:self.zTransform.view] &&
         [@[zTransformViewFrameKVOKey, zTransformViewBoundsKVOKey] containsObject:keyPath]) ||
        ([object isEqual:self.zTransform] &&
         [@[zTransformLeftKVOKey, zTransformRightKVOKey,
            zTransformTopKVOKey, zTransformBottomKVOKey,
            zTransformWidthKVOKey, zTransformHeightKVOKey,
            zTransformCenterXKVOKey, zTransformCenterYKVOKey,
            zTransformViewKVOKey] containsObject:keyPath])) {
        if (self.zTransform) self.frame = [self.zTransform transformRect];
    }
}

#pragma mark - Properties Methods -

- (ZUXTransform *)zTransform {
    return [self propertyForAssociateKey:zTransformKVOKey];
}

- (void)setZTransform:(ZUXTransform *)zTransform {
    [self setProperty:zTransform forAssociateKey:zTransformKVOKey];
}

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    if ([key isEqualToString:zTransformKVOKey]) {
        ZUXTransform *oriTransform = self.zTransform;
        [self p_RemoveFrameAndBoundsObserversFromView:oriTransform.view];
        [self p_RemoveObserversFromTransform:oriTransform];
    }
}

- (void)didChangeValueForKey:(NSString *)key {
    [super didChangeValueForKey:key];
    if ([key isEqualToString:zTransformKVOKey]) {
        ZUXTransform *newTransform = self.zTransform;
        // default transform by superview
        if (newTransform && !newTransform.view) newTransform.view = self.superview;
        [self p_AddObserversToTransform:newTransform];
        [self p_AddFrameAndBoundsObserversToView:newTransform.view];
        if (newTransform) self.frame = [newTransform transformRect];
    }
}

- (id)zLeft {
    return self.zTransform.left;
}

- (void)setZLeft:(id)zLeft {
    [self p_ZTransform].left = zLeft;
}

- (id)zRight {
    return self.zTransform.right;
}

- (void)setZRight:(id)zRight {
    [self p_ZTransform].right = zRight;
}

- (id)zTop {
    return self.zTransform.top;
}

- (void)setZTop:(id)zTop {
    [self p_ZTransform].top = zTop;
}

- (id)zBottom {
    return self.zTransform.bottom;
}

- (void)setZBottom:(id)zBottom {
    [self p_ZTransform].bottom = zBottom;
}

- (id)zWidth {
    return self.zTransform.width;
}

- (void)setZWidth:(id)zWidth {
    [self p_ZTransform].width = zWidth;
}

- (id)zHeight {
    return self.zTransform.height;
}

- (void)setZHeight:(id)zHeight {
    [self p_ZTransform].height = zHeight;
}

- (id)zCenterX {
    return self.zTransform.centerX;
}

- (void)setZCenterX:(id)zCenterX {
    [self p_ZTransform].centerX = zCenterX;
}

- (id)zCenterY {
    return self.zTransform.centerY;
}

- (void)setZCenterY:(id)zCenterY {
    [self p_ZTransform].centerY = zCenterY;
}

- (UIView *)zView {
    return self.zTransform.view;
}

- (void)setZView:(UIView *)zView {
    [self p_ZTransform].view = zView;
}

#pragma mark - Private Methods -

- (ZUXTransform *)p_ZTransform {
    if (ZUX_EXPECT_T(self.zTransform)) return self.zTransform;
    ZUXTransform *transform = [[ZUXTransform alloc] init];
    [self setZTransform:transform];
    return ZUX_AUTORELEASE(transform);
}

- (void)p_AddFrameAndBoundsObserversToView:(UIView *)view {
    [view addObserver:self forKeyPaths:@[zTransformViewFrameKVOKey, zTransformViewBoundsKVOKey]
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
              context:(ZUX_BRIDGE void *)(zLayoutKVOContext)];
}

- (void)p_RemoveFrameAndBoundsObserversFromView:(UIView *)view {
    [view removeObserver:self forKeyPaths:@[zTransformViewFrameKVOKey, zTransformViewBoundsKVOKey]
                 context:(ZUX_BRIDGE void *)(zLayoutKVOContext)];
}

- (void)p_AddObserversToTransform:(ZUXTransform *)transform {
    [transform addObserver:self forKeyPaths:@[zTransformLeftKVOKey, zTransformRightKVOKey,
                                              zTransformTopKVOKey, zTransformBottomKVOKey,
                                              zTransformWidthKVOKey, zTransformHeightKVOKey,
                                              zTransformCenterXKVOKey, zTransformCenterYKVOKey,
                                              zTransformViewKVOKey]
                   options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                   context:(ZUX_BRIDGE void *)(zLayoutKVOContext)];
}

- (void)p_RemoveObserversFromTransform:(ZUXTransform *)transform {
    [transform removeObserver:self forKeyPaths:@[zTransformLeftKVOKey, zTransformRightKVOKey,
                                                 zTransformTopKVOKey, zTransformBottomKVOKey,
                                                 zTransformWidthKVOKey, zTransformHeightKVOKey,
                                                 zTransformCenterXKVOKey, zTransformCenterYKVOKey,
                                                 zTransformViewKVOKey]
                      context:(ZUX_BRIDGE void *)(zLayoutKVOContext)];
}

@end

#pragma mark - Animate -

CGFloat ZUXAnimateZoomRatio = 2;

ZUX_INLINE ZUXAnimation ZUXAnimationMake(ZUXAnimateType type,
                                         ZUXAnimateDirection direction,
                                         NSTimeInterval duration,
                                         NSTimeInterval delay) {
    ZUXAnimation animation;
    animation.type      = type;
    animation.direction = direction;
    animation.duration  = duration;
    animation.delay     = delay;
    return animation;
}

ZUX_INLINE ZUXAnimation ZUXImmediateAnimationMake(ZUXAnimateType type,
                                                  ZUXAnimateDirection direction,
                                                  NSTimeInterval duration) {
    return ZUXAnimationMake(type, direction, duration, 0);
}

@implementation UIView (ZUXAnimate)

- (void)zuxAnimate:(ZUXAnimation)animation {
    [self zuxAnimate:animation completion:^{}];
}

- (void)zuxAnimate:(ZUXAnimation)animation completion:(void (^)())completion {
    CGAffineTransform selfStartTrans = self.transform;
    CGAffineTransform selfFinalTrans = self.transform;
    CGAffineTransform *selfTrans = &selfStartTrans;
    
    CGFloat selfStartAlpha = self.alpha;
    CGFloat selfFinalAlpha = self.alpha;
    CGFloat *selfAlpha = &selfStartAlpha;
    
    UIView *maskView = nil;
    CGAffineTransform maskStartTrans = CGAffineTransformIdentity;
    CGAffineTransform maskFinalTrans = CGAffineTransformIdentity;
    CGAffineTransform *maskTrans = &maskStartTrans;

    if (hasZUXAnimateType(animation, ZUXAnimateOut)) {
        selfTrans = &selfFinalTrans;
        selfAlpha = &selfFinalAlpha;
        maskTrans = &maskFinalTrans;
    }
    
    if (hasZUXAnimateType(animation, ZUXAnimateMove)) {
        ZUXCGAffineTransformTranslate(selfTrans, ZUXAnimateTranslateVector(self, animation));
    }
    
    if (hasZUXAnimateType(animation, ZUXAnimateFade)) *selfAlpha = 0;
    
    if (hasZUXAnimateType(animation, ZUXAnimateSlide)) {
        maskView = ZUX_AUTORELEASE([[UIView alloc] initWithFrame:self.bounds]);
        maskView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.layer.mask = maskView.layer;
        ZUXCGAffineTransformTranslate(maskTrans, ZUXAnimateTranslateVector(self, animation));
    }
    
    CGFloat scale = 1;
    if (hasZUXAnimateType(animation, ZUXAnimateExpand)) scale /= MAX(ZUXAnimateZoomRatio, 1);
    if (hasZUXAnimateType(animation, ZUXAnimateShrink)) scale *= MAX(ZUXAnimateZoomRatio, 1);
    if (hasZUXAnimateType(animation, ZUXAnimateOut)) scale = 1 / scale;
    ZUXCGAffineTransformScale(selfTrans, scale);
    ZUXCGAffineTransformScale(maskTrans, scale);
    
    self.transform = selfStartTrans;
    self.alpha = selfStartAlpha;
    maskView.transform = maskStartTrans;
    [UIView animateWithDuration:animation.duration delay:animation.delay options:0
                     animations:^{
                         self.transform = selfFinalTrans;
                         self.alpha = selfFinalAlpha;
                         maskView.transform = maskFinalTrans;
                     } completion:^(BOOL finished) { completion(); }];
}

#pragma mark - ZUXAnimate Implement Methods -

ZUX_STATIC_INLINE bool hasZUXAnimateType(ZUXAnimation animation, ZUXAnimateType type)
{ return animation.type & type; }

ZUX_STATIC_INLINE bool hasZUXAnimateDirection(ZUXAnimation animation, ZUXAnimateDirection type)
{ return animation.direction & type; }

ZUX_STATIC_INLINE void ZUXCGAffineTransformTranslate(CGAffineTransform *t, CGVector vector)
{ *t = CGAffineTransformTranslate(*t, vector.dx, vector.dy); }

ZUX_STATIC_INLINE void ZUXCGAffineTransformScale(CGAffineTransform *t, CGFloat scale)
{ *t = CGAffineTransformScale(*t, scale, scale); }

ZUX_STATIC_INLINE CGVector ZUXAnimateTranslateVector(UIView *view, ZUXAnimation animation) {
    CGSize relativeSize = view.frame.size;
    if (hasZUXAnimateType(animation, ZUXAnimateByWindow))
        relativeSize = [UIScreen mainScreen].bounds.size;
    
    int direction = 1;
    if (hasZUXAnimateType(animation, ZUXAnimateOut)) direction = -1;
    
    CGVector vector = CGVectorMake(0, 0);
    if (hasZUXAnimateDirection(animation, ZUXAnimateUp)) vector.dy += direction * relativeSize.height;
    if (hasZUXAnimateDirection(animation, ZUXAnimateLeft)) vector.dx += direction * relativeSize.width;
    if (hasZUXAnimateDirection(animation, ZUXAnimateDown)) vector.dy -= direction * relativeSize.height;
    if (hasZUXAnimateDirection(animation, ZUXAnimateRight)) vector.dx -= direction * relativeSize.width;
    
    return vector;
}

@end

#pragma mark - General badge -

static NSInteger const ZUX_BADGE_TAG = 2147520;

NSString *const zBadgeTextFontKVOKey    = @"zbadgeTextFont";
NSString *const zBadgeTextColorKVOKey   = @"zbadgeTextColor";
NSString *const zBadgeColorKVOKey       = @"zbadgeColor";
NSString *const zBadgeOffsetKVOKey      = @"zbadgeOffset";
NSString *const zBadgeSizeKVOKey        = @"zbadgeSize";

@implementation UIView (ZUXBadge)

- (void)showBadge {
    [self showBadgeWithValue:nil];
}

- (void)showBadgeWithValue:(NSString *)badgeValue {
    [self hideBadge];
    self.masksToBounds = NO;
    
    UILabel *badgeLabel = ZUX_AUTORELEASE([[UILabel alloc] init]);
    badgeLabel.tag = ZUX_BADGE_TAG;
    badgeLabel.backgroundColor = self.badgeColor;
    badgeLabel.masksToBounds = YES;
    [self addSubview:badgeLabel];
    
    CGSize offset = self.badgeOffset;
    ZUX_ENABLE_CATEGORY(ZUX_NSNull);
    ZUX_ENABLE_CATEGORY(ZUX_NSString);
    if ([NSNull isNotNull:badgeValue] && [badgeValue isNotEmpty]) {
        badgeLabel.text = badgeValue;
        badgeLabel.font = self.badgeTextFont;
        badgeLabel.textColor = self.badgeTextColor;
        badgeLabel.textAlignment = ZUXTextAlignmentCenter;
        
        ZUX_ENABLE_CATEGORY(ZUX_UILabel);
        CGSize size = [badgeLabel sizeThatConstraintToSize:
                       CGSizeMake(self.bounds.size.width, self.bounds.size.height)];
        badgeLabel.center = CGPointMake(self.bounds.size.width + offset.width, size.height / 4 + offset.height);
        badgeLabel.bounds = CGRectMake(0, 0, MAX(size.width + badgeLabel.font.pointSize / 2, size.height), size.height);
        badgeLabel.cornerRadius = size.height / 2;
        
    } else {
        CGFloat badgeSize = self.badgeSize;
        badgeLabel.center = CGPointMake(self.bounds.size.width + offset.width, badgeSize / 4 + offset.height);
        badgeLabel.bounds = CGRectMake(0, 0, badgeSize, badgeSize);
        badgeLabel.cornerRadius = badgeSize / 2;
    }
}

- (void)hideBadge {
    [[self viewWithTag:ZUX_BADGE_TAG] removeFromSuperview];
}

- (UIFont *)badgeTextFont {
    return [self propertyForAssociateKey:zBadgeTextFontKVOKey] ?: [UIFont fontWithName:@".SFUIText-Regular" size:13];
}

- (void)setBadgeTextFont:(UIFont *)badgeTextFont {
    [self setProperty:badgeTextFont forAssociateKey:zBadgeTextFontKVOKey];
    
    ((UILabel *)[self viewWithTag:ZUX_BADGE_TAG]).font = self.badgeTextFont;
}

- (UIColor *)badgeTextColor {
    return [self propertyForAssociateKey:zBadgeTextColorKVOKey] ?: [UIColor whiteColor];
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    [self setProperty:badgeTextColor forAssociateKey:zBadgeTextColorKVOKey];
    
    ((UILabel *)[self viewWithTag:ZUX_BADGE_TAG]).textColor = self.badgeTextColor;
}

- (UIColor *)badgeColor {
    return [self propertyForAssociateKey:zBadgeColorKVOKey] ?: [UIColor redColor];
}

- (void)setBadgeColor:(UIColor *)badgeColor {
    [self setProperty:badgeColor forAssociateKey:zBadgeColorKVOKey];
    
    [self viewWithTag:ZUX_BADGE_TAG].backgroundColor = self.badgeColor;
}

- (CGSize)badgeOffset {
    NSValue *badgeOffset = [self propertyForAssociateKey:zBadgeOffsetKVOKey];
    return badgeOffset ? [badgeOffset CGSizeValue] : CGSizeZero;
}

- (void)setBadgeOffset:(CGSize)badgeOffset {
    CGSize oriOffset = self.badgeOffset;
    CGPoint center = [self viewWithTag:ZUX_BADGE_TAG].center;
    
    [self setProperty:[NSValue valueWithCGSize:badgeOffset] forAssociateKey:zBadgeOffsetKVOKey];
    
    [self viewWithTag:ZUX_BADGE_TAG].center = CGPointMake(center.x - oriOffset.width + badgeOffset.width,
                                                          center.y - oriOffset.height + badgeOffset.height);
}

- (CGFloat)badgeSize {
    NSNumber *badgeSize = [self propertyForAssociateKey:zBadgeSizeKVOKey];
    ZUX_ENABLE_CATEGORY(ZUX_NSNumber);
    return badgeSize ? [badgeSize cgfloatValue] : 8;
}

- (void)setBadgeSize:(CGFloat)badgeSize {
    ZUX_ENABLE_CATEGORY(ZUX_NSNumber);
    [self setProperty:[NSNumber numberWithCGFloat:badgeSize] forAssociateKey:zBadgeSizeKVOKey];
    
    if (!((UILabel *)[self viewWithTag:ZUX_BADGE_TAG]).text) {
        [self viewWithTag:ZUX_BADGE_TAG].bounds = CGRectMake(0, 0, badgeSize, badgeSize);
        [self viewWithTag:ZUX_BADGE_TAG].cornerRadius = badgeSize / 2;
    }
}

#pragma mark - Swizzle & Override Methods -

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
#if !IS_ARC
        ZUX_ENABLE_CATEGORY(ZUX_NSObject);
        // dealloc badge's associate objects
        [self swizzleInstanceOriSelector:@selector(dealloc)
                         withNewSelector:@selector(zuxBadgeDealloc)];
#endif
    });
}

- (void)zuxBadgeDealloc {
    [self setProperty:nil forAssociateKey:zBadgeTextFontKVOKey];
    [self setProperty:nil forAssociateKey:zBadgeTextColorKVOKey];
    [self setProperty:nil forAssociateKey:zBadgeColorKVOKey];
    [self setProperty:nil forAssociateKey:zBadgeOffsetKVOKey];
    [self setProperty:nil forAssociateKey:zBadgeSizeKVOKey];
    [self zuxBadgeDealloc];
}

@end

@implementation UIView (ZUXAppearance)

+ (CGFloat)borderWidth {
    return [(UIView *)APPEARANCE borderWidth];
}

+ (void)setBorderWidth:(CGFloat)borderWidth {
    [(UIView *)APPEARANCE setBorderWidth:borderWidth];
}

+ (UIColor *)borderColor {
    return [(UIView *)APPEARANCE borderColor];
}

+ (void)setBorderColor:(UIColor *)borderColor {
    [(UIView *)APPEARANCE setBorderColor:borderColor];
}

+ (UIColor *)shadowColor {
    return [(UIView *)APPEARANCE shadowColor];
}

+ (void)setShadowColor:(UIColor *)shadowColor {
    [(UIView *)APPEARANCE setShadowColor:shadowColor];
}

+ (float)shadowOpacity {
    return [(UIView *)APPEARANCE shadowOpacity];
}

+ (void)setShadowOpacity:(float)shadowOpacity {
    [(UIView *)APPEARANCE setShadowOpacity:shadowOpacity];
}

+ (CGSize)shadowOffset {
    return [(UIView *)APPEARANCE shadowOffset];
}

+ (void)setShadowOffset:(CGSize)shadowOffset {
    [(UIView *)APPEARANCE setShadowOffset:shadowOffset];
}

+ (CGFloat)shadowSize {
    return [(UIView *)APPEARANCE shadowSize];
}

+ (void)setShadowSize:(CGFloat)shadowSize {
    [(UIView *)APPEARANCE setShadowSize:shadowSize];
}

+ (UIFont *)badgeTextFont {
    return [APPEARANCE badgeTextFont];
}

+ (void)setBadgeTextFont:(UIFont *)badgeTextFont {
    [APPEARANCE setBadgeTextFont:badgeTextFont];
}

+ (UIColor *)badgeTextColor {
    return [APPEARANCE badgeTextColor];
}

+ (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    [APPEARANCE setBadgeTextColor:badgeTextColor];
}

+ (UIColor *)badgeColor {
    return [APPEARANCE badgeColor];
}

+ (void)setBadgeColor:(UIColor *)badgeColor {
    [APPEARANCE setBadgeColor:badgeColor];
}

+ (CGSize)badgeOffset {
    return [APPEARANCE badgeOffset];
}

+ (void)setBadgeOffset:(CGSize)badgeOffset {
    [APPEARANCE setBadgeOffset:badgeOffset];
}

+ (CGFloat)badgeSize {
    return [APPEARANCE badgeSize];
}

+ (void)setBadgeSize:(CGFloat)badgeSize {
    [APPEARANCE setBadgeSize:badgeSize];
}

@end
