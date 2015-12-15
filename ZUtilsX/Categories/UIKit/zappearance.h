//
//  zappearance.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_zappearance_h
#define ZUtilsX_zappearance_h

#import "zarc.h"

#define APPEARANCE [self appearance]

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000
# define APPEARANCE_IN_CLASS(clz)   [self appearanceWhenContainedInInstancesOfClasses:@[(clz)]]
#else
# define APPEARANCE_IN_CLASS(clz)   [self appearanceWhenContainedIn:(clz), nil]
#endif

////////////////////////////////////
#pragma mark - titleTextAttributes -

#define TitleTextAttributeForKey(key) \
[[APPEARANCE titleTextAttributes] objectForKey:(key)]

#define SetTitleTextAttributeForKey(value, key) \
NSMutableDictionary *attributes = ZUX_AUTORELEASE([[APPEARANCE titleTextAttributes] mutableCopy]); \
[attributes setObject:(value) forKey:(key)]; \
[APPEARANCE setTitleTextAttributes:attributes]

#define TitleShadowAttribute \
((NSShadow *)TitleTextAttributeForKey(NSShadowAttributeName))

#define DefaultTitleShadowAttribute \
TitleShadowAttribute ?: ZUX_AUTORELEASE([[NSShadow alloc] init])

#define SetTitleShadowAttribute(shadow) \
SetTitleTextAttributeForKey(shadow, NSShadowAttributeName)

//////////////////////////////////////////////////////////////
#pragma mark - titleTextAttributes with (UIControlState)state -

#define TitleTextAttributeForKeyAndState(key, state) \
[[APPEARANCE titleTextAttributesForState:(state)] objectForKey:(key)]

#define SetTitleTextAttributeForKeyAndState(value, key, state) \
NSMutableDictionary *attributes = ZUX_AUTORELEASE([[APPEARANCE titleTextAttributesForState:(state)] mutableCopy]); \
[attributes setObject:(value) forKey:(key)]; \
[APPEARANCE setTitleTextAttributes:attributes forState:(state)]

#define TitleShadowAttributeForState(state) \
((NSShadow *)TitleTextAttributeForKeyAndState(NSShadowAttributeName, state))

#define DefaultTitleShadowAttributeForState(state) \
TitleShadowAttributeForState(state) ?: ZUX_AUTORELEASE([[NSShadow alloc] init])

#define SetTitleShadowAttributeForState(shadow, state) \
SetTitleTextAttributeForKeyAndState(shadow, NSShadowAttributeName, state)

/////////////////////////////////////////////////////////
#pragma mark - titleTextAttributes with container class -

#define TitleTextAttributeForKeyInClass(key, clz) \
[[APPEARANCE_IN_CLASS(clz) titleTextAttributes] objectForKey:(key)]

#define SetTitleTextAttributeForKeyInClass(value, key, clz) \
NSMutableDictionary *attributes = ZUX_AUTORELEASE([[APPEARANCE_IN_CLASS(clz) titleTextAttributes] mutableCopy]); \
[attributes setObject:(value) forKey:(key)]; \
[APPEARANCE_IN_CLASS(clz) setTitleTextAttributes:attributes]

#define TitleShadowAttributeInClass(clz) \
((NSShadow *)TitleTextAttributeForKeyInClass(NSShadowAttributeName, clz))

#define DefaultTitleShadowAttributeInClass(clz) \
TitleShadowAttributeInClass(clz) ?: ZUX_AUTORELEASE([[NSShadow alloc] init])

#define SetTitleShadowAttributeInClass(shadow, clz) \
SetTitleTextAttributeForKeyInClass(shadow, NSShadowAttributeName, clz)

///////////////////////////////////////////////////////////////////////////////////
#pragma mark - titleTextAttributes with container class and (UIControlState)state -

#define TitleTextAttributeForKeyAndStateInClass(key, state, clz) \
[[APPEARANCE_IN_CLASS(clz) titleTextAttributesForState:(state)] objectForKey:(key)]

#define SetTitleTextAttributeForKeyAndStateInClass(value, key, state, clz) \
NSMutableDictionary *attributes = ZUX_AUTORELEASE([[APPEARANCE_IN_CLASS(clz) \
titleTextAttributesForState:(state)] mutableCopy]); \
[attributes setObject:(value) forKey:(key)]; \
[APPEARANCE_IN_CLASS(clz) setTitleTextAttributes:attributes forState:(state)]

#define TitleShadowAttributeForStateInClass(state, clz) \
((NSShadow *)TitleTextAttributeForKeyAndStateInClass(NSShadowAttributeName, state, clz))

#define DefaultTitleShadowAttributeForStateInClass(state, clz) \
TitleShadowAttributeForStateInClass(state, clz) ?: ZUX_AUTORELEASE([[NSShadow alloc] init])

#define SetTitleShadowAttributeForStateInClass(shadow, state, clz) \
SetTitleTextAttributeForKeyAndStateInClass(shadow, NSShadowAttributeName, state, clz)

#endif /* ZUtilsX_zappearance_h */
