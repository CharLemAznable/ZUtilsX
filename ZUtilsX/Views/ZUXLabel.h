//
//  ZUXLabel.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zarc.h"

#ifndef ZUtilsX_ZUXLabel_h
#define ZUtilsX_ZUXLabel_h

@protocol ZUXLabelDataSource;

@interface ZUXLabel : UILabel

@property (nonatomic, ZUX_WEAK) id<ZUXLabelDataSource> dataSource;
@property (nonatomic, assign, getter=canCopy) BOOL canCopy;
@property (nonatomic, ZUX_STRONG) UIImage *backgroundImage;
@property (nonatomic, assign) CGFloat linesSpacing;

- (void)zuxInitial;

@end // ZUXLabel

@protocol ZUXLabelDataSource <NSObject>

@optional
- (NSString *)menuTitleOfCopyInLabel:(ZUXLabel *)view;
- (CGPoint)menuLocationInLabel:(ZUXLabel *)view;

@end // ZUXLabelDataSource

#endif /* ZUtilsX_ZUXLabel_h */
