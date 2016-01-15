//
//  ZUXImageView.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXImageView_h
#define ZUtilsX_ZUXImageView_h

#import <UIKit/UIKit.h>
#import "zarc.h"

@protocol ZUXImageViewDataSource;

@protocol ZUXImageViewDelegate;

@interface ZUXImageView : UIImageView

@property (nonatomic, ZUX_WEAK) id<ZUXImageViewDataSource> dataSource;
@property (nonatomic, ZUX_WEAK) id<ZUXImageViewDelegate> delegate;
@property (nonatomic, assign, getter=canCopy) BOOL canCopy;
@property (nonatomic, assign, getter=canSave) BOOL canSave;

- (void)zuxInitial;

@end // ZUXImageView

@protocol ZUXImageViewDataSource <NSObject>

@optional
- (NSString *)menuTitleOfCopyInImageView:(ZUXImageView *)view;
- (NSString *)menuTitleOfSaveInImageView:(ZUXImageView *)view;
- (CGPoint)menuLocationInImageView:(ZUXImageView *)view;

@end // ZUXImageViewDataSource

@protocol ZUXImageViewDelegate <NSObject>

@optional
- (void)saveImageSuccessInImageView:(ZUXImageView *)view;
- (void)saveImageFailedInImageView:(ZUXImageView *)view withError:(NSError *)error;

@end // ZUXImageViewDelegate

#endif /* ZUtilsX_ZUXImageView_h */
