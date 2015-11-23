//
//  zobjc.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/17.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_zobjc_h
#define ZUtilsX_zobjc_h

#ifdef __cplusplus
# define ZUX_EXTERN                     extern "C" __attribute__((visibility ("default")))
#else
# define ZUX_EXTERN                     extern __attribute__((visibility ("default")))
#endif

#define ZUX_STATIC                      static

#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
# define ZUX_INLINE                     inline
# define ZUX_STATIC_INLINE              static inline
#elif defined(__cplusplus)
# define ZUX_INLINE                     inline
# define ZUX_STATIC_INLINE              static inline
#elif defined(__GNUC__)
# define ZUX_INLINE                     __inline__
# define ZUX_STATIC_INLINE              static __inline__
#else
# define ZUX_INLINE
# define ZUX_STATIC_INLINE              static
#endif

#if __has_feature(objc_instancetype)
# define ZUX_INSTANCETYPE               instancetype
#else
# define ZUX_INSTANCETYPE               id
#endif

#if __has_feature(objc_kindof)
# define ZUX_KINDOF(exp)                __kindof exp
#else
# define ZUX_KINDOF(exp)                id
#endif

#if __has_feature(objc_generics)
# define ZUX_KEY_TYPE                   KeyType
# define ZUX_OBJECT_TYPE                ObjectType
# define ZUX_GENERIC(a)                 <a>
# define ZUX_COVARIANT_GENERIC(a)       <__covariant a>
# define ZUX_GENERIC2(a, b)             <a, b>
# define ZUX_COVARIANT_GENERIC2(a, b)   <__covariant a, __covariant b>
#else
# define ZUX_KEY_TYPE                   id
# define ZUX_OBJECT_TYPE                id
# define ZUX_GENERIC(a)
# define ZUX_COVARIANT_GENERIC(a)
# define ZUX_GENERIC2(a, b)
# define ZUX_COVARIANT_GENERIC2(a, b)
#endif

#if __has_feature(nullability)
# define ZUX_NONNULL                    __nonnull
# define ZUX_NULLABLE                   __nullable
#else
# define ZUX_NONNULL
# define ZUX_NULLABLE
#endif

#if __has_feature(assume_nonnull)
# ifdef NS_ASSUME_NONNULL_BEGIN
#  define ZUX_ASSUME_NONNULL_BEGIN      NS_ASSUME_NONNULL_BEGIN
# else
#  define ZUX_ASSUME_NONNULL_BEGIN      _Pragma("clang assume_nonnull begin")
# endif
# ifdef NS_ASSUME_NONNULL_END
#  define ZUX_ASSUME_NONNULL_END        NS_ASSUME_NONNULL_END
# else
#  define ZUX_ASSUME_NONNULL_END        _Pragma("clang assume_nonnull end")
# endif
#else
# define ZUX_ASSUME_NONNULL_BEGIN
# define ZUX_ASSUME_NONNULL_END
#endif

#endif /* ZUtilsX_zobjc_h */
