//
//  ZUXImageView.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zarc.h"

@protocol ZUXImageViewDataSource;

@protocol ZUXImageViewDelegate;

// ZUXImageView
@interface ZUXImageView : UIImageView

@property (nonatomic, ZUX_WEAK) id<ZUXImageViewDataSource> dataSource;
@property (nonatomic, ZUX_WEAK) id<ZUXImageViewDelegate> delegate;
@property (nonatomic, assign, getter=canCopy) BOOL canCopy;
@property (nonatomic, assign, getter=canSave) BOOL canSave;

- (void)zuxInitial;

@end

// ZUXImageViewDataSource

@protocol ZUXImageViewDataSource <NSObject>

@optional
- (CGPoint)menuLocationInImageView:(ZUXImageView *)view;

@end

// ZUXImageViewDelegate
@protocol ZUXImageViewDelegate <NSObject>

@optional
- (void)saveImageSuccessInImageView:(ZUXImageView *)view;
- (void)saveImageFailedInImageView:(ZUXImageView *)view withError:(NSError *)error;

@end
