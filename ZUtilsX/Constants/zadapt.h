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

#define BEFORE_IOS6                     ([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] == NSOrderedAscending)
#define BEFORE_IOS7                     ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedAscending)
#define BEFORE_IOS8                     ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] == NSOrderedAscending)
#define BEFORE_IOS9                     ([[[UIDevice currentDevice] systemVersion] compare:@"9.0"] == NSOrderedAscending)

#define IOS6_OR_LATER                   !BEFORE_IOS6
#define IOS7_OR_LATER                   !BEFORE_IOS7
#define IOS8_OR_LATER                   !BEFORE_IOS8
#define IOS9_OR_LATER                   !BEFORE_IOS9

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
# define ZUXTextAlignmentLeft               (IOS6_OR_LATER? NSTextAlignmentLeft : UITextAlignmentLeft)
# define ZUXTextAlignmentCenter             (IOS6_OR_LATER? NSTextAlignmentCenter : UITextAlignmentCenter)
# define ZUXTextAlignmentRight              (IOS6_OR_LATER? NSTextAlignmentRight : UITextAlignmentRight)
# define ZUXLineBreakByWordWrapping         (IOS6_OR_LATER? NSLineBreakByWordWrapping : UILineBreakModeWordWrap)
# define ZUXLineBreakByCharWrapping         (IOS6_OR_LATER? NSLineBreakByCharWrapping : UILineBreakModeCharacterWrap)
# define ZUXLineBreakByClipping             (IOS6_OR_LATER? NSLineBreakByClipping : UILineBreakModeClip)
# define ZUXLineBreakByTruncatingHead       (IOS6_OR_LATER? NSLineBreakByTruncatingHead : UILineBreakModeHeadTruncation)
# define ZUXLineBreakByTruncatingTail       (IOS6_OR_LATER? NSLineBreakByTruncatingTail : UILineBreakModeTailTruncation)
# define ZUXLineBreakByTruncatingMiddle     (IOS6_OR_LATER? NSLineBreakByTruncatingMiddle : UILineBreakModeMiddleTruncation)
# define zkCTTextAlignmentLeft              (IOS6_OR_LATER? kCTTextAlignmentLeft : kCTLeftTextAlignment)
# define zkCTTextAlignmentRight             (IOS6_OR_LATER? kCTTextAlignmentRight : kCTRightTextAlignment)
# define zkCTTextAlignmentCenter            (IOS6_OR_LATER? kCTTextAlignmentCenter : kCTCenterTextAlignment)
# define zkCTTextAlignmentJustified         (IOS6_OR_LATER? kCTTextAlignmentJustified : kCTJustifiedTextAlignment)
# define zkCTTextAlignmentNatural           (IOS6_OR_LATER? kCTTextAlignmentNatural : kCTNaturalTextAlignment)

# define ZUXFontAttributeName               (IOS6_OR_LATER? NSFontAttributeName : UITextAttributeFont)
# define ZUXForegroundColorAttributeName    (IOS6_OR_LATER? NSForegroundColorAttributeName : UITextAttributeTextColor)
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
# define ZUXCalendarUnitEra                 (IOS8_OR_LATER? NSCalendarUnitEra : NSEraCalendarUnit)
# define ZUXCalendarUnitYear                (IOS8_OR_LATER? NSCalendarUnitYear : NSYearCalendarUnit)
# define ZUXCalendarUnitMonth               (IOS8_OR_LATER? NSCalendarUnitMonth : NSMonthCalendarUnit)
# define ZUXCalendarUnitDay                 (IOS8_OR_LATER? NSCalendarUnitDay : NSDayCalendarUnit)
# define ZUXCalendarUnitHour                (IOS8_OR_LATER? NSCalendarUnitHour : NSHourCalendarUnit)
# define ZUXCalendarUnitMinute              (IOS8_OR_LATER? NSCalendarUnitMinute : NSMinuteCalendarUnit)
# define ZUXCalendarUnitSecond              (IOS8_OR_LATER? NSCalendarUnitSecond : NSSecondCalendarUnit)
# define ZUXCalendarUnitWeekday             (IOS8_OR_LATER? NSCalendarUnitWeekday : NSWeekdayCalendarUnit)
# define ZUXCalendarUnitWeekdayOrdinal      (IOS8_OR_LATER? NSCalendarUnitWeekdayOrdinal : NSWeekdayOrdinalCalendarUnit)

# define ZUXUserNotificationType            UIRemoteNotificationType
# define ZUXUserNotificationTypeNone        UIRemoteNotificationTypeNone
# define ZUXUserNotificationTypeBadge       UIRemoteNotificationTypeBadge
# define ZUXUserNotificationTypeSound       UIRemoteNotificationTypeSound
# define ZUXUserNotificationTypeAlert       UIRemoteNotificationTypeAlert
#endif // __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000

#endif /* ZUtilsX_zadapt_h */
