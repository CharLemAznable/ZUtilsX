//
//  UIApplication+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_UIApplication_ZUX_h
#define ZUtilsX_UIApplication_ZUX_h

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"
#import "zobjc.h"
#import "zadapt.h"

@category_interface(UIApplication, ZUX)

+ (void)registerUserNotificationTypes:(ZUXUserNotificationType)types;
- (void)registerUserNotificationTypes:(ZUXUserNotificationType)types;
+ (void)registerUserNotificationTypes:(ZUXUserNotificationType)types
                           categories:(NSSet ZUX_GENERIC(UIUserNotificationCategory *) *)categories;
- (void)registerUserNotificationTypes:(ZUXUserNotificationType)types
                           categories:(NSSet ZUX_GENERIC(UIUserNotificationCategory *) *)categories;

+ (BOOL)notificationTypeRegisted:(ZUXUserNotificationType)type;
- (BOOL)notificationTypeRegisted:(ZUXUserNotificationType)type;

+ (BOOL)noneNotificationTypeRegisted;
- (BOOL)noneNotificationTypeRegisted;

@end

#endif /* ZUtilsX_UIApplication_ZUX_h */
