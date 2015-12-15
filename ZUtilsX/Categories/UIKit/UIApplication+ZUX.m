//
//  UIApplication+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UIApplication+ZUX.h"

ZUX_CATEGORY_M(ZUX_UIApplication)

@implementation UIApplication (ZUX)

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
+ (void)registerUserNotificationTypes:(ZUXUserNotificationType)types
                           categories:(NSSet<UIUserNotificationCategory *> *)categories {
    [[self sharedApplication] registerUserNotificationTypes:types categories:categories];
}

- (void)registerUserNotificationTypes:(ZUXUserNotificationType)types
                           categories:(NSSet<UIUserNotificationCategory *> *)categories {
    [self registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:types categories:categories]];
}
#endif // __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000

+ (void)registerUserNotificationTypes:(ZUXUserNotificationType)types {
    [[self sharedApplication] registerUserNotificationTypes:types];
}

- (void)registerUserNotificationTypes:(ZUXUserNotificationType)types {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
    [self registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:types categories:nil]];
#else
    [self registerForRemoteNotificationTypes:types];
#endif
}

+ (BOOL)noneNotificationTypeRegisted {
    return [[self sharedApplication] noneNotificationTypeRegisted];
}

- (BOOL)noneNotificationTypeRegisted {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
    return ZUXUserNotificationTypeNone == [self currentUserNotificationSettings].types;
#else
    return ZUXUserNotificationTypeNone == [self enabledRemoteNotificationTypes];
#endif
}

+ (BOOL)notificationTypeRegisted:(ZUXUserNotificationType)type {
    return [[self sharedApplication] notificationTypeRegisted:type];
}

- (BOOL)notificationTypeRegisted:(ZUXUserNotificationType)type {
    return type != ZUXUserNotificationTypeNone &&
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
    type == ([self currentUserNotificationSettings].types & type);
#else
    type == ([self enabledRemoteNotificationTypes] & type);
#endif
}

@end
