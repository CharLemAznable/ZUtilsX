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
#else
# define ZUX_STRONG                     retain
#endif

#if __has_feature(objc_arc_weak)
# define ZUX_WEAK                       weak
#elif IS_ARC
# define ZUX_WEAK                       unsafe_unretained
#else
# define ZUX_WEAK                       assign
#endif

#if IS_ARC
# define ZUX_AUTORELEASE(exp)           exp
#else
# define ZUX_AUTORELEASE(exp)           [exp autorelease]
#endif

#if IS_ARC
# define ZUX_RELEASE(exp)
#else
# define ZUX_RELEASE(exp)               [exp release]
#endif

#if IS_ARC
# define ZUX_RETAIN(exp)                exp
#else
# define ZUX_RETAIN(exp)                [exp retain]
#endif

#if IS_ARC
# define ZUX_BRIDGE_TRANSFER            __bridge_transfer
#else
# define ZUX_BRIDGE_TRANSFER            __bridge
#endif

#if IS_ARC
# define ZUX_SUPER_DEALLOC
#else
# define ZUX_SUPER_DEALLOC              [super dealloc]
#endif

#if IS_ARC
# define ZUX_BLOCK_COPY(exp)            exp
#else
# define ZUX_BLOCK_COPY(exp)            _Block_copy(exp)
#endif

#if IS_ARC
# define ZUX_BLOCK_RELEASE(exp)
#else
# define ZUX_BLOCK_RELEASE(exp)         _Block_release(exp)
#endif

#endif /* ZUtilsX_zarc_h */
