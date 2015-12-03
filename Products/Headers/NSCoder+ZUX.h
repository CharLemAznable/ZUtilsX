//
//  NSCoder+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "ZUXCategory.h"

#ifndef ZUtilsX_NSCoder_ZUX_h
#define ZUtilsX_NSCoder_ZUX_h

ZUX_CATEGORY_H(ZUX_NSCoder)

@interface NSCoder (ZUX)

- (void)encodeCGFloat:(CGFloat)realv forKey:(NSString *)key;
- (CGFloat)decodeCGFloatForKey:(NSString *)key;

@end

#endif /* ZUtilsX_NSCoder_ZUX_h */
