//
//  NSDate+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/25.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUXCategory.h"

ZUX_CATEGORY_H(ZUX_NSDate)

typedef long long ZUXTimeIntervalMills;

@interface NSDate (ZUX)

- (ZUXTimeIntervalMills)timeIntervalMillsSinceDate:(NSDate *)anotherDate;
@property (readonly) ZUXTimeIntervalMills timeIntervalMillsSinceNow;
@property (readonly) ZUXTimeIntervalMills timeIntervalMillsSince1970;

- (NSString *)stringWithDateFormat:(NSString *)dateFormat;

@end

@interface NSString (ZUXDate)

- (NSDate *)dateWithDateFormat:(NSString *)dateFormat;

@end