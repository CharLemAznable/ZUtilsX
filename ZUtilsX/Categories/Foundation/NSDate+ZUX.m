//
//  NSDate+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/25.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSDate+ZUX.h"
#import "zarc.h"
#import "zadapt.h"

@category_implementation(NSDate, ZUX)

- (ZUXTimeIntervalMills)timeIntervalMillsSinceDate:(NSDate *)anotherDate {
    return [self timeIntervalSinceDate:anotherDate] * 1000;
}

- (ZUXTimeIntervalMills)timeIntervalMillsSinceNow {
    return [self timeIntervalSinceNow] * 1000;
}

- (ZUXTimeIntervalMills)timeIntervalMillsSince1970 {
    return [self timeIntervalSince1970] * 1000;
}

#define ZUXNSDateComponent_implement(calendarUnit, componentName)                               \
- (NSInteger)componentName {                                                                    \
    return [[NSCalendar currentCalendar] components:calendarUnit fromDate:self].componentName;  \
}

ZUXNSDateComponent_implement(ZUXCalendarUnitEra, era);
ZUXNSDateComponent_implement(ZUXCalendarUnitYear, year);
ZUXNSDateComponent_implement(ZUXCalendarUnitMonth, month);
ZUXNSDateComponent_implement(ZUXCalendarUnitDay, day);
ZUXNSDateComponent_implement(ZUXCalendarUnitHour, hour);
ZUXNSDateComponent_implement(ZUXCalendarUnitMinute, minute);
ZUXNSDateComponent_implement(ZUXCalendarUnitSecond, second);
ZUXNSDateComponent_implement(ZUXCalendarUnitWeekday, weekday);

@end

@category_implementation(NSDate, ZUXStringDate)

- (NSString *)stringWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = ZUX_AUTORELEASE([[NSDateFormatter alloc] init]);
    formatter.dateFormat = dateFormat;
    return [formatter stringFromDate:self];
}

@end

@category_implementation(NSString, ZUXStringDate)

- (NSDate *)dateWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = ZUX_AUTORELEASE([[NSDateFormatter alloc] init]);
    formatter.dateFormat = dateFormat;
    return [formatter dateFromString:self];
}

@end
