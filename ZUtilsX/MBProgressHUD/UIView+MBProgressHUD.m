//
//  UIView+MBProgressHUD.m
//  msgo
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UIView+MBProgressHUD.h"
#import "zarc.h"

@category_implementation(UIView, MBProgressHUD)

- (MBProgressHUD *)mbProgressHUD {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    if (!hud) {
        hud = ZUX_AUTORELEASE([[MBProgressHUD alloc] initWithView:self]);
        hud.square = YES;
        hud.animationType = MBProgressHUDAnimationFade;
        hud.removeFromSuperViewOnHide = YES;
        [self addSubview:hud];
    }
    return hud;
}

- (void)showIndeterminateHUDWithText:(NSString *)text {
    MBProgressHUD *hud = [self mbProgressHUD];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    hud.detailsLabelText = nil;
    [hud show:YES];
}

- (void)showTextHUDWithText:(NSString *)text
             hideAfterDelay:(NSTimeInterval)delay {
    
    [self showTextHUDWithText:text detailText:nil hideAfterDelay:delay];
}

- (void)showTextHUDWithText:(NSString *)text
                 detailText:(NSString *)detailText
             hideAfterDelay:(NSTimeInterval)delay {
    
    MBProgressHUD *hud = [self mbProgressHUD];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.detailsLabelText = detailText;
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
}

- (void)hideHUD:(BOOL)animated {
    [[self mbProgressHUD] hide:animated];
}

- (UIFont *)hudLabelFont {
    return [self mbProgressHUD].labelFont;
}

- (void)setHudLabelFont:(UIFont *)hudLabelFont {
    [self mbProgressHUD].labelFont = hudLabelFont;
}

- (UIFont *)hudDetailsLabelFont {
    return [self mbProgressHUD].detailsLabelFont;
}

- (void)setHudDetailsLabelFont:(UIFont *)hudDetailsLabelFont {
    [self mbProgressHUD].detailsLabelFont = hudDetailsLabelFont;
}

@end

@category_implementation(UIView, RecursiveMBProgressHUD)

- (MBProgressHUD *)recursiveMBProgressHUD {
    NSEnumerator *subviewsEnum = [self.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            return (MBProgressHUD *)subview;
        } else {
            MBProgressHUD *hud = [subview recursiveMBProgressHUD];
            if (hud) return hud;
        }
    }
    return nil;
}

- (void)showIndeterminateRecursiveHUDWithText:(NSString *)text {
    MBProgressHUD *hud = [self recursiveMBProgressHUD] ?: [self mbProgressHUD];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    hud.detailsLabelText = nil;
    [hud show:YES];
}

- (void)showTextRecursiveHUDWithText:(NSString *)text
                      hideAfterDelay:(NSTimeInterval)delay {
    
    [self showTextHUDWithText:text detailText:nil hideAfterDelay:delay];
}

- (void)showTextRecursiveHUDWithText:(NSString *)text
                          detailText:(NSString *)detailText
                      hideAfterDelay:(NSTimeInterval)delay {
    
    MBProgressHUD *hud = [self recursiveMBProgressHUD] ?: [self mbProgressHUD];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.detailsLabelText = detailText;
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
}

- (void)hideRecursiveHUD:(BOOL)animated {
    [[self recursiveMBProgressHUD] ?: [self mbProgressHUD] hide:animated];
}

- (UIFont *)recursiveHudLabelFont {
    return ([self recursiveMBProgressHUD] ?: [self mbProgressHUD]).labelFont;
}

- (void)setRecursiveHudLabelFont:(UIFont *)recursiveHudLabelFont {
    ([self recursiveMBProgressHUD] ?: [self mbProgressHUD]).labelFont = recursiveHudLabelFont;
}

- (UIFont *)recursiveHudDetailsLabelFont {
    return ([self recursiveMBProgressHUD] ?: [self mbProgressHUD]).detailsLabelFont;
}

- (void)setRecursiveHudDetailsLabelFont:(UIFont *)recursiveHudDetailsLabelFont {
    ([self recursiveMBProgressHUD] ?: [self mbProgressHUD]).detailsLabelFont = recursiveHudDetailsLabelFont;
}

@end
