//
//  NSCoder+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSCoder+ZUX.h"

@category_implementation(NSCoder, ZUX)

#if defined(__LP64__) && __LP64__

- (void)encodeCGFloat:(CGFloat)realv forKey:(NSString *)key {
    [self encodeDouble:realv forKey:key];
}

- (CGFloat)decodeCGFloatForKey:(NSString *)key {
    return [self decodeDoubleForKey:key];
}

#else // defined(__LP64__) && __LP64__

- (void)encodeCGFloat:(CGFloat)realv forKey:(NSString *)key {
    [self encodeFloat:realv forKey:key];
}

- (CGFloat)decodeCGFloatForKey:(NSString *)key {
    return [self decodeFloatForKey:key];
}

#endif // defined(__LP64__) && __LP64__

@end
