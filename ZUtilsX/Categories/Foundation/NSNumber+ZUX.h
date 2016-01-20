//
//  NSNumber+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_NSNumber_ZUX_h
#define ZUtilsX_NSNumber_ZUX_h

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "zobjc.h"
#import "ZUXCategory.h"

@category_interface(NSNumber, ZUX)

+ (ZUX_INSTANCETYPE)numberWithCGFloat:(CGFloat)value;
- (ZUX_INSTANCETYPE)initWithCGFloat:(CGFloat)value;
- (CGFloat)cgfloatValue;

@end // NSNumber (ZUX)

@category_interface(NSString, ZUXNumber)

- (CGFloat)cgfloatValue;

@end // NSNumber (ZUX)

#endif /* ZUtilsX_NSNumber_ZUX_h */
