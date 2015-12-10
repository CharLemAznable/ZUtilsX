//
//  NSNumber+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSNumber+ZUX.h"
#import "zarc.h"

ZUX_CATEGORY_M(ZUX_NSNumber)

@implementation NSNumber (ZUX)

+ (ZUX_INSTANCETYPE)numberWithCGFloat:(CGFloat)value {
    return ZUX_AUTORELEASE([[self alloc] initWithCGFloat:value]);
}

#if defined(__LP64__) && __LP64__

- (ZUX_INSTANCETYPE)initWithCGFloat:(CGFloat)value {
    return [self initWithDouble:value];
}

- (CGFloat)cgfloatValue {
    return [self doubleValue];
}

#else // defined(__LP64__) && __LP64__

- (ZUX_INSTANCETYPE)initWithCGFloat:(CGFloat)value {
    return [self initWithFloat:value];
}

- (CGFloat)cgfloatValue {
    return [self floatValue];
}

#endif // defined(__LP64__) && __LP64__

@end
