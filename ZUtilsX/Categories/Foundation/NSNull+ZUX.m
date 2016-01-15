//
//  NSNull+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSNull+ZUX.h"

@category_implementation(NSNull, ZUX)

+ (BOOL)isNull:(id)obj {
    return obj == nil || [obj isEqual:[self null]];
}

+ (BOOL)isNotNull:(id)obj {
    return obj != nil && ![obj isEqual:[self null]];
}

@end
