//
//  zadapt.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/17.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_zadapt_h
#define ZUtilsX_zadapt_h

#define IS_IPHONE4                      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE5                      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE6                      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE6P                     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define DeviceScale                     (IS_IPHONE6P ? 1.29375 : (IS_IPHONE6 ? 1.171875 : 1.0))

#define IOS6_OR_LATER                   ([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending)
#define IOS7_OR_LATER                   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#define IOS8_OR_LATER                   ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)
#define IOS9_OR_LATER                   ([[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending)

#define statusBarHeight                 (IOS7_OR_LATER ? 20 : 0)
#define statusBarFix                    (IOS7_OR_LATER ? 0 : 20)

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
# define ZUXTextAlignmentLeft               NSTextAlignmentLeft
# define ZUXTextAlignmentCenter             NSTextAlignmentCenter
# define ZUXTextAlignmentRight              NSTextAlignmentRight
# define ZUXLineBreakByWordWrapping         NSLineBreakByWordWrapping
# define ZUXLineBreakByCharWrapping         NSLineBreakByCharWrapping
# define ZUXLineBreakByClipping             NSLineBreakByClipping
# define ZUXLineBreakByTruncatingHead       NSLineBreakByTruncatingHead
# define ZUXLineBreakByTruncatingTail       NSLineBreakByTruncatingTail
# define ZUXLineBreakByTruncatingMiddle     NSLineBreakByTruncatingMiddle
# define zkCTTextAlignmentLeft              kCTTextAlignmentLeft
# define zkCTTextAlignmentRight             kCTTextAlignmentRight
# define zkCTTextAlignmentCenter            kCTTextAlignmentCenter
# define zkCTTextAlignmentJustified         kCTTextAlignmentJustified
# define zkCTTextAlignmentNatural           kCTTextAlignmentNatural

# define ZUXFontAttributeName               NSFontAttributeName
# define ZUXForegroundColorAttributeName    NSForegroundColorAttributeName
#else // __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
# define ZUXTextAlignmentLeft               UITextAlignmentLeft
# define ZUXTextAlignmentCenter             UITextAlignmentCenter
# define ZUXTextAlignmentRight              UITextAlignmentRight
# define ZUXLineBreakByWordWrapping         UILineBreakModeWordWrap
# define ZUXLineBreakByCharWrapping         UILineBreakModeCharacterWrap
# define ZUXLineBreakByClipping             UILineBreakModeClip
# define ZUXLineBreakByTruncatingHead       UILineBreakModeHeadTruncation
# define ZUXLineBreakByTruncatingTail       UILineBreakModeTailTruncation
# define ZUXLineBreakByTruncatingMiddle     UILineBreakModeMiddleTruncation
# define zkCTTextAlignmentLeft              kCTLeftTextAlignment
# define zkCTTextAlignmentRight             kCTRightTextAlignment
# define zkCTTextAlignmentCenter            kCTCenterTextAlignment
# define zkCTTextAlignmentJustified         kCTJustifiedTextAlignment
# define zkCTTextAlignmentNatural           kCTNaturalTextAlignment

# define ZUXFontAttributeName               UITextAttributeFont
# define ZUXForegroundColorAttributeName    UITextAttributeTextColor
#endif // __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
# define ZUXCalendarUnitEra                 NSCalendarUnitEra
# define ZUXCalendarUnitYear                NSCalendarUnitYear
# define ZUXCalendarUnitMonth               NSCalendarUnitMonth
# define ZUXCalendarUnitDay                 NSCalendarUnitDay
# define ZUXCalendarUnitHour                NSCalendarUnitHour
# define ZUXCalendarUnitMinute              NSCalendarUnitMinute
# define ZUXCalendarUnitSecond              NSCalendarUnitSecond
# define ZUXCalendarUnitWeekday             NSCalendarUnitWeekday
# define ZUXCalendarUnitWeekdayOrdinal      NSCalendarUnitWeekdayOrdinal

# define ZUXUserNotificationType            UIUserNotificationType            
# define ZUXUserNotificationTypeNone        UIUserNotificationTypeNone
# define ZUXUserNotificationTypeBadge       UIUserNotificationTypeBadge
# define ZUXUserNotificationTypeSound       UIUserNotificationTypeSound
# define ZUXUserNotificationTypeAlert       UIUserNotificationTypeAlert
#else // __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
# define ZUXCalendarUnitEra                 NSEraCalendarUnit
# define ZUXCalendarUnitYear                NSYearCalendarUnit
# define ZUXCalendarUnitMonth               NSMonthCalendarUnit
# define ZUXCalendarUnitDay                 NSDayCalendarUnit
# define ZUXCalendarUnitHour                NSHourCalendarUnit
# define ZUXCalendarUnitMinute              NSMinuteCalendarUnit
# define ZUXCalendarUnitSecond              NSSecondCalendarUnit
# define ZUXCalendarUnitWeekday             NSWeekdayCalendarUnit
# define ZUXCalendarUnitWeekdayOrdinal      NSWeekdayOrdinalCalendarUnit

# define ZUXUserNotificationType            UIRemoteNotificationType
# define ZUXUserNotificationTypeNone        UIRemoteNotificationTypeNone
# define ZUXUserNotificationTypeBadge       UIRemoteNotificationTypeBadge
# define ZUXUserNotificationTypeSound       UIRemoteNotificationTypeSound
# define ZUXUserNotificationTypeAlert       UIRemoteNotificationTypeAlert
#endif // __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000

#endif /* ZUtilsX_zadapt_h */
