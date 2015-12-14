//
//  UIApplication+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"
#import "zadapt.h"

#ifndef ZUtilsX_UIApplication_ZUX_h
#define ZUtilsX_UIApplication_ZUX_h

ZUX_CATEGORY_H(ZUX_UIApplication)

@interface UIApplication (ZUX)

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
+ (void)registerUserNotificationTypes:(ZUXUserNotificationType)types
                           categories:(NSSet<UIUserNotificationCategory *> *)categories;
- (void)registerUserNotificationTypes:(ZUXUserNotificationType)types
                           categories:(NSSet<UIUserNotificationCategory *> *)categories;
#else
+ (void)registerUserNotificationTypes:(ZUXUserNotificationType)types;
- (void)registerUserNotificationTypes:(ZUXUserNotificationType)types;
#endif

+ (BOOL)noneNotificationTypeRegisted;
- (BOOL)noneNotificationTypeRegisted;

+ (BOOL)notificationTypeRegisted:(ZUXUserNotificationType)type;
- (BOOL)notificationTypeRegisted:(ZUXUserNotificationType)type;

@end

#endif /* ZUtilsX_UIApplication_ZUX_h */
