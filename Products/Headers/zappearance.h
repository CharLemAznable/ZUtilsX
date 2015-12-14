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

#pragma mark - titleTextAttributes -

#define TitleTextAttributeForKey(key) \
[[APPEARANCE titleTextAttributes] objectForKey:(key)]

#define SetTitleTextAttributeForKey(key, value) \
NSMutableDictionary *attributes = ZUX_AUTORELEASE([[APPEARANCE titleTextAttributes] mutableCopy]); \
[attributes setObject:(value) forKey:(key)]; \
[APPEARANCE setTitleTextAttributes:attributes]

#define TitleShadowAttribute \
((NSShadow *)TitleTextAttributeForKey(NSShadowAttributeName))

#define DefaultTitleShadowAttribute \
TitleShadowAttribute ?: ZUX_AUTORELEASE([[NSShadow alloc] init])

#define SetTitleShadowAttribute(shadow) \
SetTitleTextAttributeForKey(NSShadowAttributeName, shadow)

#pragma mark - titleTextAttributes with (UIControlState)state -

#define TitleTextAttributeForKeyForState(key, state) \
[[APPEARANCE titleTextAttributesForState:(state)] objectForKey:(key)]

#define SetTitleTextAttributeForKeyForState(key, value, state) \
NSMutableDictionary *attributes = ZUX_AUTORELEASE([[APPEARANCE titleTextAttributesForState:(state)] mutableCopy]); \
[attributes setObject:(value) forKey:(key)]; \
[APPEARANCE setTitleTextAttributes:attributes forState:(state)]

#define TitleShadowAttributeForState(state) \
((NSShadow *)TitleTextAttributeForKeyForState(NSShadowAttributeName, state))

#define DefaultTitleShadowAttributeForState(state) \
TitleShadowAttributeForState(state) ?: ZUX_AUTORELEASE([[NSShadow alloc] init])

#define SetTitleShadowAttributeForState(shadow, state) \
SetTitleTextAttributeForKeyForState(NSShadowAttributeName, shadow, state)

#endif /* ZUtilsX_zappearance_h */
