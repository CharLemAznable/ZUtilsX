//
//  zarc.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/17.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_zarc_h
#define ZUtilsX_zarc_h

#define IS_ARC                          __has_feature(objc_arc)

#if IS_ARC
# define ZUX_STRONG                     strong
# define __ZUX_STRONG                   __strong
#else
# define ZUX_STRONG                     retain
# define __ZUX_STRONG
#endif

#if __has_feature(objc_arc_weak)
# define ZUX_WEAK                       weak
# define __ZUX_WEAK                     __weak
#elif IS_ARC
# define ZUX_WEAK                       unsafe_unretained
# define __ZUX_WEAK                     __unsafe_unretained
#else
# define ZUX_WEAK                       assign
# define __ZUX_WEAK
#endif

#if IS_ARC
# define __ZUX_AUTORELEASE              __autoreleasing
#else
# define __ZUX_AUTORELEASE
#endif

#if IS_ARC
# define ZUX_JUST_AUTORELEASE(exp)
# define ZUX_AUTORELEASE(exp)           exp
# define ZUX_RELEASE(exp)
# define ZUX_RETAIN(exp)                exp
# define ZUX_SUPER_DEALLOC
#else
# define ZUX_JUST_AUTORELEASE(exp)      [exp autorelease]
# define ZUX_AUTORELEASE(exp)           [exp autorelease]
# define ZUX_RELEASE(exp)               [exp release]
# define ZUX_RETAIN(exp)                [exp retain]
# define ZUX_SUPER_DEALLOC              [super dealloc]
#endif

#if IS_ARC
# define ZUX_BRIDGE                     __bridge
# define ZUX_BRIDGE_TRANSFER            __bridge_transfer
# define ZUX_BRIDGE_RETAIN              __bridge_retained
# define ZUX_CFRelease(exp)             CFRelease(exp)
#else
# define ZUX_BRIDGE
# define ZUX_BRIDGE_TRANSFER
# define ZUX_BRIDGE_RETAIN
# define ZUX_CFRelease(exp)
#endif

#if IS_ARC
# define ZUX_BLOCK_COPY(exp)            exp
# define ZUX_BLOCK_RELEASE(exp)
#else
# define ZUX_BLOCK_COPY(exp)            _Block_copy(exp)
# define ZUX_BLOCK_RELEASE(exp)         _Block_release(exp)
#endif

#endif /* ZUtilsX_zarc_h */
