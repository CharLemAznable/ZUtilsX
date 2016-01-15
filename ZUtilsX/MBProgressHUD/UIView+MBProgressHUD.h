//
//  UIView+MBProgressHUD.h
//  msgo
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "MBProgressHUD.h"
#import "ZUXCategory.h"

#ifndef ZUtilsX_UIView_MBProgressHUD_h
#define ZUtilsX_UIView_MBProgressHUD_h

/**
 * MBProgressHUD for CURRENT view.
 */
@category_interface(UIView, MBProgressHUD)

@property (MB_STRONG) UIFont *hudLabelFont;
@property (MB_STRONG) UIFont *hudDetailsLabelFont;

/**
 * Finds the top-most HUD subview and returns it.
 * If there is no HUD subview, add one and returns it.
 * Created invisible HUD with:
 *   square:YES
 *   animationType:MBProgressHUDAnimationFade
 *   removeFromSuperViewOnHide:YES
 */
- (MBProgressHUD *)mbProgressHUD;

- (void)showIndeterminateHUDWithText:(NSString *)text;
- (void)showTextHUDWithText:(NSString *)text hideAfterDelay:(NSTimeInterval)delay;
- (void)showTextHUDWithText:(NSString *)text detailText:(NSString *)detailText hideAfterDelay:(NSTimeInterval)delay;
- (void)hideHUD:(BOOL)animated;

@end // UIView (MBProgressHUD)

/**
 * MBProgressHUD RECURSIVE in current view and its subviews.
 */
@category_interface(UIView, RecursiveMBProgressHUD)

@property (MB_STRONG) UIFont *recursiveHudLabelFont;
@property (MB_STRONG) UIFont *recursiveHudDetailsLabelFont;

/**
 * Finds the top-most HUD subview RECURSIVE in subviews and returns it.
 * If there is no HUD subview, return nil.
 */
- (MBProgressHUD *)recursiveMBProgressHUD;

- (void)showIndeterminateRecursiveHUDWithText:(NSString *)text;
- (void)showTextRecursiveHUDWithText:(NSString *)text hideAfterDelay:(NSTimeInterval)delay;
- (void)showTextRecursiveHUDWithText:(NSString *)text detailText:(NSString *)detailText hideAfterDelay:(NSTimeInterval)delay;
- (void)hideRecursiveHUD:(BOOL)animated;

@end // UIView (RecursiveMBProgressHUD)

#endif /* ZUtilsX_UIView_MBProgressHUD_h */
