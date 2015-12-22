//
//  UIApplication+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UIApplication+ZUX.h"
#import "zobjc.h"

ZUX_CATEGORY_M(ZUX_UIApplication)

@implementation UIApplication (ZUX)

+ (void)registerUserNotificationTypes:(ZUXUserNotificationType)types {
    [[self sharedApplication] registerUserNotificationTypes:types];
}

- (void)registerUserNotificationTypes:(ZUXUserNotificationType)types {
    [self registerUserNotificationTypes:types categories:nil];
}

+ (void)registerUserNotificationTypes:(ZUXUserNotificationType)types
                           categories:(NSSet<UIUserNotificationCategory *> *)categories {
    [[self sharedApplication] registerUserNotificationTypes:types categories:categories];
}

- (void)registerUserNotificationTypes:(ZUXUserNotificationType)types
                           categories:(NSSet<UIUserNotificationCategory *> *)categories {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
    !IOS8_OR_LATER ? [self registerForRemoteNotificationTypes:types] :
#endif
    [self registerUserNotificationSettings:
     [UIUserNotificationSettings settingsForTypes:userNotificationType(types)
                                       categories:categories]];
}

+ (BOOL)notificationTypeRegisted:(ZUXUserNotificationType)type {
    return [[self sharedApplication] notificationTypeRegisted:type];
}

- (BOOL)notificationTypeRegisted:(ZUXUserNotificationType)type {
    return type != ZUXUserNotificationTypeNone &&
    (
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
     !IOS8_OR_LATER ? type == ([self enabledRemoteNotificationTypes] & type) :
#endif
     userNotificationType(type) == ([self currentUserNotificationSettings].types & userNotificationType(type)));
}

+ (BOOL)noneNotificationTypeRegisted {
    return [[self sharedApplication] noneNotificationTypeRegisted];
}

- (BOOL)noneNotificationTypeRegisted {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
    !IOS8_OR_LATER ? UIRemoteNotificationTypeNone == [self enabledRemoteNotificationTypes] :
#endif
    UIUserNotificationTypeNone == [self currentUserNotificationSettings].types;
}

ZUX_STATIC_INLINE UIUserNotificationType userNotificationType(ZUXUserNotificationType type) {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
    UIUserNotificationType result = UIUserNotificationTypeNone;
    if (type & ZUXUserNotificationTypeBadge) result |= UIUserNotificationTypeBadge;
    if (type & ZUXUserNotificationTypeSound) result |= UIUserNotificationTypeSound;
    if (type & ZUXUserNotificationTypeAlert) result |= UIUserNotificationTypeAlert;
    return result;
#else
    return type;
#endif
}

@end
