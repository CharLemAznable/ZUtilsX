//
//  NSDate+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/25.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_NSDate_ZUX_h
#define ZUtilsX_NSDate_ZUX_h

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

typedef long long ZUXTimeIntervalMills;

@category_interface(NSDate, ZUX)

- (ZUXTimeIntervalMills)timeIntervalMillsSinceDate:(NSDate *)anotherDate;
@property (readonly) ZUXTimeIntervalMills timeIntervalMillsSinceNow;
@property (readonly) ZUXTimeIntervalMills timeIntervalMillsSince1970;

@property (readonly) NSInteger era;
@property (readonly) NSInteger year;
@property (readonly) NSInteger month;
@property (readonly) NSInteger day;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger second;
@property (readonly) NSInteger weekday;

@end // NSDate (ZUX)

@category_interface(NSDate, ZUXStringDate)

- (NSString *)stringWithDateFormat:(NSString *)dateFormat;

@end // NSDate (ZUXStringDate)

@category_interface(NSString, ZUXStringDate)

- (NSDate *)dateWithDateFormat:(NSString *)dateFormat;

@end // NSString (ZUXStringDate)

#endif /* ZUtilsX_NSDate_ZUX_h */
