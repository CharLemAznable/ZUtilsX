//
//  ZUXImageView.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXImageView.h"
#import "ZUXGeometry.h"
#import "zobjc.h"

@implementation ZUXImageView

- (ZUX_INSTANCETYPE)init {
    if (ZUX_EXPECT_T(self = [super init])) [self zuxInitial];
    return self;
}

- (ZUX_INSTANCETYPE)initWithCoder:(NSCoder *)aDecoder {
    if (ZUX_EXPECT_T(self = [super initWithCoder:aDecoder])) {
        _canCopy = [aDecoder decodeBoolForKey:@"canCopy"];
        _canSave = [aDecoder decodeBoolForKey:@"canSave"];
    }
    return self;
}

- (ZUX_INSTANCETYPE)initWithFrame:(CGRect)frame {
    if (ZUX_EXPECT_T(self = [super initWithFrame:frame])) [self zuxInitial];
    return self;
}

- (ZUX_INSTANCETYPE)initWithImage:(UIImage *)image {
    if (ZUX_EXPECT_T(self = [super initWithImage:image])) [self zuxInitial];
    return self;
}

- (ZUX_INSTANCETYPE)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    if (ZUX_EXPECT_T(self = [super initWithImage:image highlightedImage:highlightedImage])) [self zuxInitial];
    return self;
}

- (void)zuxInitial {
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:ZUX_AUTORELEASE([[UILongPressGestureRecognizer alloc]
                                                initWithTarget:self action:@selector(longPress:)])];
}

- (void)dealloc {
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    _dataSource = nil;
    _delegate = nil;
    ZUX_SUPER_DEALLOC;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeBool:_canCopy forKey:@"canCopy"];
    [aCoder encodeBool:_canSave forKey:@"canSave"];
}

- (void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer  {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [gestureRecognizer.view becomeFirstResponder];
        
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        NSString *copyTitle = [_dataSource respondsToSelector:@selector(menuTitleOfCopyInImageView:)]
        ? [_dataSource menuTitleOfCopyInImageView:self] : @"复制";
        NSString *saveTitle = [_dataSource respondsToSelector:@selector(menuTitleOfSaveInImageView:)]
        ? [_dataSource menuTitleOfSaveInImageView:self] : @"保存";
        menuController.menuItems = @[ZUX_AUTORELEASE([[UIMenuItem alloc] initWithTitle:copyTitle
                                                                                action:@selector(zuxCopy:)]),
                                     ZUX_AUTORELEASE([[UIMenuItem alloc] initWithTitle:saveTitle
                                                                                action:@selector(zuxSave:)])];
        
        if ([_dataSource respondsToSelector:@selector(menuLocationInImageView:)]) {
            [menuController setTargetRect:ZUX_CGRectMake([_dataSource menuLocationInImageView:self], CGSizeZero)
                                   inView:gestureRecognizer.view];
        } else {
            [menuController setTargetRect:ZUX_CGRectMake([gestureRecognizer locationInView:gestureRecognizer.view], CGSizeZero)
                                   inView:gestureRecognizer.view];
        }
        [menuController setMenuVisible:YES animated:YES];
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return ((_canCopy && action == @selector(zuxCopy:)) ||
            (_canSave && action == @selector(zuxSave:)));
}

- (void)zuxCopy:(id)sender {
    if (!self.image) return;
    [UIPasteboard generalPasteboard].image = self.image;
}

- (void)zuxSave:(id)sender {
    if (!self.image) return;
    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error && [_delegate respondsToSelector:@selector(saveImageFailedInImageView:withError:)]) {
        [_delegate saveImageFailedInImageView:self withError:error];
    } else if ([_delegate respondsToSelector:@selector(saveImageSuccessInImageView:)]) {
        [_delegate saveImageSuccessInImageView:self];
    }
}

@end
