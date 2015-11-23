//
//  UIView+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UIView+ZUX.h"
#import "NSObject+ZUX.h"
#import "ZUXTransform.h"
#import <objc/runtime.h>

ZUX_CATEGORY_M(ZUX_UIView)

@implementation UIView (ZUX)

#pragma mark - Properties Methods.

- (BOOL)maskToBounds {
    return self.layer.masksToBounds;
}

- (void)setMaskToBounds:(BOOL)maskToBounds {
    self.layer.masksToBounds = maskToBounds;
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

@end // UIView (ZUX) end

#pragma mark -

NSString *const zLayoutTransformKey             = @"ZLayoutTransformKey";

NSString *const zLayoutKVOContext               = @"ZLayoutKVOContext";
NSString *const zTransformKVOKey                = @"zTransform";
NSString *const zTransformLeftKVOKey            = @"left";
NSString *const zTransformRightKVOKey           = @"right";
NSString *const zTransformTopKVOKey             = @"top";
NSString *const zTransformBottomKVOKey          = @"bottom";
NSString *const zTransformWidthKVOKey           = @"width";
NSString *const zTransformHeightKVOKey          = @"height";
NSString *const zTransformCenterXKVOKey         = @"centerX";
NSString *const zTransformCenterYKVOKey         = @"centerY";
NSString *const zTransformViewKVOKey            = @"view";
NSString *const zTransformViewFrameKVOKey       = @"frame";
NSString *const zTransformViewBoundsKVOKey      = @"bounds";

@implementation UIView (ZUXAutoLayout)

- (ZUX_INSTANCETYPE)initWithTransform:(ZUXTransform *)transform {
    if (self = [self init]) {
        objc_setAssociatedObject(self, (__bridge const void *)(zLayoutTransformKey),
                                 transform, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (transform && !transform.view) transform.view = self.superview; // default transform by superview
        [self p_AddObserversToTransform:transform];
        [self p_AddFrameAndBoundsObserversToView:transform.view];
    }
    return self;
}

#pragma mark - Swizzle & Override Methods.

+ (void)load {
    [super load];
    
    ZUX_ENABLE_CATEGORY(ZUX_NSObject);
    // observe superview change
    [self swizzleInstanceOriSelector:@selector(willMoveToSuperview:)
                     withNewSelector:@selector(zuxWillMoveToSuperview:)];
#if !IS_ARC
    // dealloc with removeObserver
    [self swizzleInstanceOriSelector:@selector(dealloc)
                     withNewSelector:@selector(zuxDealloc)];
#endif
}

- (void)zuxWillMoveToSuperview:(UIView *)newSuperview {
    [self zuxWillMoveToSuperview:newSuperview];
    if (self.zTransform && !self.zTransform.view) { // default transform by superview
        self.zTransform.view = newSuperview;
        [self p_AddFrameAndBoundsObserversToView:self.zTransform.view];
    }
}

- (void)zuxDealloc {
    [self p_RemoveFrameAndBoundsObserversFromView:self.zTransform.view];
    [self p_RemoveObserversFromTransform:self.zTransform];
    objc_setAssociatedObject(self, (__bridge const void *)(zLayoutTransformKey),
                             nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self zuxDealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (![zLayoutKVOContext isEqual:(__bridge id)(context)]) {
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

#pragma mark - Properties Methods.

- (ZUXTransform *)zTransform {
    return objc_getAssociatedObject(self, (__bridge const void *)(zLayoutTransformKey));
}

- (void)setZTransform:(ZUXTransform *)zTransform {
    ZUXTransform *oriTransform = objc_getAssociatedObject(self, (__bridge const void *)(zLayoutTransformKey));
    if ([oriTransform isEqualToTransform:zTransform]) return;
    
    [self p_RemoveFrameAndBoundsObserversFromView:oriTransform.view];
    [self p_RemoveObserversFromTransform:oriTransform];
    objc_setAssociatedObject(self, (__bridge const void *)(zLayoutTransformKey),
                             zTransform, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (zTransform && !zTransform.view) zTransform.view = self.superview; // default transform by superview
    [self p_AddObserversToTransform:zTransform];
    [self p_AddFrameAndBoundsObserversToView:zTransform.view];
    
    if (zTransform) self.frame = [zTransform transformRect];
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

#pragma mark - Private Methods.

- (ZUXTransform *)p_ZTransform {
    if (!objc_getAssociatedObject(self, (__bridge const void *)zLayoutTransformKey)) {
        [self setZTransform:ZUX_AUTORELEASE([[ZUXTransform alloc] init])];
    }
    return self.zTransform;
}

- (void)p_AddFrameAndBoundsObserversToView:(UIView *)view {
    [view addObserver:self forKeyPaths:@[zTransformViewFrameKVOKey, zTransformViewBoundsKVOKey]
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
              context:(__bridge void *)(zLayoutKVOContext)];
}

- (void)p_RemoveFrameAndBoundsObserversFromView:(UIView *)view {
    [view removeObserver:self forKeyPaths:@[zTransformViewFrameKVOKey, zTransformViewBoundsKVOKey]
                 context:(__bridge void *)(zLayoutKVOContext)];
}

- (void)p_AddObserversToTransform:(ZUXTransform *)transform {
    [transform addObserver:self forKeyPaths:@[zTransformLeftKVOKey, zTransformRightKVOKey,
                                              zTransformTopKVOKey, zTransformBottomKVOKey,
                                              zTransformWidthKVOKey, zTransformHeightKVOKey,
                                              zTransformCenterXKVOKey, zTransformCenterYKVOKey,
                                              zTransformViewKVOKey]
                   options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                   context:(__bridge void *)(zLayoutKVOContext)];
}

- (void)p_RemoveObserversFromTransform:(ZUXTransform *)transform {
    [transform removeObserver:self forKeyPaths:@[zTransformLeftKVOKey, zTransformRightKVOKey,
                                                 zTransformTopKVOKey, zTransformBottomKVOKey,
                                                 zTransformWidthKVOKey, zTransformHeightKVOKey,
                                                 zTransformCenterXKVOKey, zTransformCenterYKVOKey,
                                                 zTransformViewKVOKey]
                      context:(__bridge void *)(zLayoutKVOContext)];
}

@end // UIView (ZUXAutoLayout) end

#pragma mark -

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

#pragma mark - ZUXAnimate Implement Methods.

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

@end // UIView (ZUXAnimate) end
