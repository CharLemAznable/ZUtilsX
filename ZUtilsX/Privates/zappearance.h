//
//  zappearance.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_zappearance_h
#define ZUtilsX_zappearance_h

#import "zobjc.h"
#import "zarc.h"
#import "zadapt.h"
#import "UIImage+ZUX.h"

#pragma mark - appearance -

#define APPEARANCE [self appearance]

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000
# define APPEARANCE_IN_CLASS(clz)   [self appearanceWhenContainedInInstancesOfClasses:@[(clz)]]
#else
# define APPEARANCE_IN_CLASS(clz)   (IOS9_OR_LATER?[self appearanceWhenContainedInInstancesOfClasses:@[(clz)]]:[self appearanceWhenContainedIn:(clz), nil])
#endif

#pragma mark - titleTextAttribute -

ZUX_STATIC_INLINE id titleTextAttributeForKey(id instance, NSString *key) {
    return [[instance titleTextAttributes] objectForKey:key];
}

ZUX_STATIC_INLINE void setTitleTextAttributeForKey(id instance, NSString *key, id value) {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:
                                       [instance titleTextAttributes]];
    [attributes setObject:value forKey:key];
    [instance setTitleTextAttributes:attributes];
}

ZUX_STATIC_INLINE NSShadow *titleShadowAttribute(id instance) {
    return titleTextAttributeForKey(instance, NSShadowAttributeName);
}

ZUX_STATIC_INLINE NSShadow *defaultTitleShadowAttribute(id instance) {
    return titleShadowAttribute(instance) ?: ZUX_AUTORELEASE([[NSShadow alloc] init]);
}

ZUX_STATIC_INLINE void setTitleShadowAttribute(id instance, NSShadow *shadow) {
    setTitleTextAttributeForKey(instance, NSShadowAttributeName, shadow);
}

#pragma mark - titleTextAttributeForState -

ZUX_STATIC_INLINE id titleTextAttributeForStateAndKey(id instance, UIControlState state, NSString *key) {
    return [[instance titleTextAttributesForState:state] objectForKey:key];
}

ZUX_STATIC_INLINE void setTitleTextAttributeForStateAndKey(id instance, UIControlState state, NSString *key, id value) {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:
                                       [instance titleTextAttributesForState:state]];
    [attributes setObject:value forKey:key];
    [instance setTitleTextAttributes:attributes forState:state];
}

ZUX_STATIC_INLINE NSShadow *titleShadowAttributeForState(id instance, UIControlState state) {
    return titleTextAttributeForStateAndKey(instance, state, NSShadowAttributeName);
}

ZUX_STATIC_INLINE NSShadow *defaultTitleShadowAttributeForState(id instance, UIControlState state) {
    return titleShadowAttributeForState(instance, state) ?: ZUX_AUTORELEASE([[NSShadow alloc] init]);
}

ZUX_STATIC_INLINE void setTitleShadowAttributeForState(id instance, UIControlState state, NSShadow *shadow) {
    setTitleTextAttributeForStateAndKey(instance, state, NSShadowAttributeName, shadow);
}

#pragma mark - selectionIndicatorColor -

ZUX_STATIC_INLINE UIColor *selectionIndicatorColor
(ZUX_KINDOF(UITabBar *) instance) {
    return [[instance selectionIndicatorImage] dominantColor];
}

ZUX_STATIC_INLINE void setSelectionIndicatorColor
(ZUX_KINDOF(UITabBar *) instance, UIColor *selectionIndicatorColor) {
    [instance setSelectionIndicatorImage:[UIImage imagePointWithColor:selectionIndicatorColor]];
}

#pragma mark - backgroundImageForBarMetrics -

ZUX_STATIC_INLINE UIImage *backgroundImageForBarMetrics
(ZUX_KINDOF(UINavigationBar *) instance, UIBarMetrics barMetrics) {
    return [instance backgroundImageForBarMetrics:barMetrics];
}

ZUX_STATIC_INLINE void setBackgroundImageForBarMetrics
(ZUX_KINDOF(UINavigationBar *) instance, UIImage *backgroundImage, UIBarMetrics barMetrics) {
    [instance setBackgroundImage:backgroundImage forBarMetrics:barMetrics];
}

#pragma mark - backgroundColorForBarMetrics -

ZUX_STATIC_INLINE UIColor *backgroundColorForBarMetrics
(ZUX_KINDOF(UINavigationBar *) instance, UIBarMetrics barMetrics) {
    return [backgroundImageForBarMetrics(instance, barMetrics) dominantColor];
}

ZUX_STATIC_INLINE void setBackgroundColorForBarMetrics
(ZUX_KINDOF(UINavigationBar *) instance, UIColor *backgroundColor, UIBarMetrics barMetrics) {
    setBackgroundImageForBarMetrics(instance, [UIImage imagePointWithColor:backgroundColor], barMetrics);
}

#pragma mark - backgroundImageForStateAndBarMetrics -

ZUX_STATIC_INLINE UIImage *backgroundImageForStateAndBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIControlState state, UIBarMetrics barMetrics) {
    return [instance backgroundImageForState:state barMetrics:barMetrics];
}

ZUX_STATIC_INLINE void setBackgroundImageForStateAndBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIImage *backgroundImage, UIControlState state, UIBarMetrics barMetrics) {
    [instance setBackgroundImage:backgroundImage forState:state barMetrics:barMetrics];
}

#pragma mark - backgroundColorForStateAndBarMetrics -

ZUX_STATIC_INLINE UIColor *backgroundColorForStateAndBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIControlState state, UIBarMetrics barMetrics) {
    return [backgroundImageForStateAndBarMetrics(instance, state, barMetrics) dominantColor];
}

ZUX_STATIC_INLINE void setBackgroundColorForStateAndBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIColor *backgroundColor, UIControlState state, UIBarMetrics barMetrics) {
    setBackgroundImageForStateAndBarMetrics(instance, [UIImage imagePointWithColor:backgroundColor], state, barMetrics);
}

#pragma mark - backgroundImageForStateAndStyleAndBarMetrics -

ZUX_STATIC_INLINE UIImage *backgroundImageForStateAndStyleAndBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIControlState state, UIBarButtonItemStyle style, UIBarMetrics barMetrics) {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    BEFORE_IOS6 ? [instance backgroundImageForState:state barMetrics:barMetrics] :
#endif
    [instance backgroundImageForState:state style:style barMetrics:barMetrics];
}

ZUX_STATIC_INLINE void setBackgroundImageForStateAndStyleAndBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIImage *backgroundImage, UIControlState state, UIBarButtonItemStyle style, UIBarMetrics barMetrics) {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
    if (BEFORE_IOS6) [instance setBackgroundImage:backgroundImage forState:state barMetrics:barMetrics]; else
#endif
    [instance setBackgroundImage:backgroundImage forState:state style:style barMetrics:barMetrics];
}

#pragma mark - backgroundColorForStateAndStyleAndBarMetrics -

ZUX_STATIC_INLINE UIColor *backgroundColorForStateAndStyleAndBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIControlState state, UIBarButtonItemStyle style, UIBarMetrics barMetrics) {
    return [backgroundImageForStateAndStyleAndBarMetrics(instance, state, style, barMetrics) dominantColor];
}

ZUX_STATIC_INLINE void setBackgroundColorForStateAndStyleAndBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIColor *backgroundColor, UIControlState state, UIBarButtonItemStyle style, UIBarMetrics barMetrics) {
    setBackgroundImageForStateAndStyleAndBarMetrics
    (instance, [UIImage imagePointWithColor:backgroundColor], state, style, barMetrics);
}

#pragma mark - backgroundVerticalPositionAdjustment -

ZUX_STATIC_INLINE CGFloat backgroundVerticalPositionAdjustmentForBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIBarMetrics barMetrics) {
    return [instance backgroundVerticalPositionAdjustmentForBarMetrics:barMetrics];
}

ZUX_STATIC_INLINE void setBackgroundVerticalPositionAdjustmentForBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, CGFloat adjustment, UIBarMetrics barMetrics) {
    [instance setBackgroundVerticalPositionAdjustment:adjustment forBarMetrics:barMetrics];
}

#pragma mark - titlePositionAdjustment -

ZUX_STATIC_INLINE UIOffset titlePositionAdjustmentForBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIBarMetrics barMetrics) {
    return [instance titlePositionAdjustmentForBarMetrics:barMetrics];
}

ZUX_STATIC_INLINE void setTitlePositionAdjustmentForBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIOffset adjustment, UIBarMetrics barMetrics) {
    [instance setTitlePositionAdjustment:adjustment forBarMetrics:barMetrics];
}

#pragma mark - backButtonBackgroundImage -

ZUX_STATIC_INLINE UIImage *backButtonBackgroundImageForStateAndBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIControlState state, UIBarMetrics barMetrics) {
    return [instance backButtonBackgroundImageForState:state barMetrics:barMetrics];
}

ZUX_STATIC_INLINE void setBackButtonBackgroundImageForStateAndBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIImage *backgroundImage, UIControlState state, UIBarMetrics barMetrics) {
    [instance setBackButtonBackgroundImage:backgroundImage forState:state barMetrics:barMetrics];
}

#pragma mark - backButtonBackgroundColor -

ZUX_STATIC_INLINE UIColor *backButtonBackgroundColorForStateAndBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIControlState state, UIBarMetrics barMetrics) {
    return [backButtonBackgroundImageForStateAndBarMetrics(instance, state, barMetrics) dominantColor];
}

ZUX_STATIC_INLINE void setBackButtonBackgroundColorForStateAndBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIColor *backgroundColor, UIControlState state, UIBarMetrics barMetrics) {
    setBackButtonBackgroundImageForStateAndBarMetrics
    (instance, [UIImage imagePointWithColor:backgroundColor], state, barMetrics);
}

#pragma mark - backButtonBackgroundVerticalPositionAdjustment -

ZUX_STATIC_INLINE CGFloat backButtonBackgroundVerticalPositionAdjustmentForBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIBarMetrics barMetrics) {
    return [instance backButtonBackgroundVerticalPositionAdjustmentForBarMetrics:barMetrics];
}

ZUX_STATIC_INLINE void setBackButtonBackgroundVerticalPositionAdjustmentForBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, CGFloat adjustment, UIBarMetrics barMetrics) {
    [instance setBackButtonBackgroundVerticalPositionAdjustment:adjustment forBarMetrics:barMetrics];
}

#pragma mark - backButtonTitlePositionAdjustment -

ZUX_STATIC_INLINE UIOffset backButtonTitlePositionAdjustmentForBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIBarMetrics barMetrics) {
    return [instance backButtonTitlePositionAdjustmentForBarMetrics:barMetrics];
}

ZUX_STATIC_INLINE void setBackButtonTitlePositionAdjustmentForBarMetrics
(ZUX_KINDOF(UIBarButtonItem *) instance, UIOffset adjustment, UIBarMetrics barMetrics) {
    [instance setBackButtonTitlePositionAdjustment:adjustment forBarMetrics:barMetrics];
}

#endif /* ZUtilsX_zappearance_h */
