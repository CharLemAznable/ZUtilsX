//
//  NSDate+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/25.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSDate+ZUX.h"
#import "zarc.h"

ZUX_CATEGORY_M(ZUX_NSDate)

@implementation NSDate (ZUX)

- (ZUXTimeIntervalMills)timeIntervalMillsSinceDate:(NSDate *)anotherDate {
    return [self timeIntervalSinceDate:anotherDate] * 1000;
}

- (ZUXTimeIntervalMills)timeIntervalMillsSinceNow {
    return [self timeIntervalSinceNow] * 1000;
}

- (ZUXTimeIntervalMills)timeIntervalMillsSince1970 {
    return [self timeIntervalSince1970] * 1000;
}

- (NSString *)stringWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = ZUX_AUTORELEASE([[NSDateFormatter alloc] init]);
    formatter.dateFormat = dateFormat;
    return [formatter stringFromDate:self];
}

@end

@implementation NSString (ZUXDate)

- (NSDate *)dateWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = ZUX_AUTORELEASE([[NSDateFormatter alloc] init]);
    formatter.dateFormat = dateFormat;
    return [formatter dateFromString:self];
}

@end
