//
//  ZUXRefreshView.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXView.h"
#import "zarc.h"

#ifndef ZUtilsX_ZUXRefreshView_h
#define ZUtilsX_ZUXRefreshView_h

typedef NS_ENUM(NSInteger, ZUXRefreshState) {
    ZUXRefreshNormal,
    ZUXRefreshPulling,
    ZUXRefreshLoading,
};

typedef NS_ENUM(NSInteger, ZUXRefreshPullDirection) {
    ZUXRefreshPullDown,
    ZUXRefreshPullUp,
    ZUXRefreshPullRight,
    ZUXRefreshPullLeft,
};

@protocol ZUXRefreshViewDelegate;

@interface ZUXRefreshView : ZUXView

@property (nonatomic, ZUX_WEAK) id<ZUXRefreshViewDelegate> delegate;
@property (nonatomic, assign) ZUXRefreshState state;
@property (nonatomic, assign) ZUXRefreshPullDirection direction;
@property (nonatomic, assign) CGFloat defaultPadding;
@property (nonatomic, assign) CGFloat pullingMargin;
@property (nonatomic, assign) CGFloat loadingMargin;

- (void)didScrollView:(UIScrollView *)scrollView;
- (void)didEndDragging:(UIScrollView *)scrollView;
- (void)didFinishedLoading:(UIScrollView *)scrollView;
- (void)setRefreshState:(ZUXRefreshState)state;

@end // ZUXRefreshView

@protocol ZUXRefreshViewDelegate <NSObject>

@optional
- (BOOL)refreshViewIsLoading:(ZUXRefreshView *)view;
- (void)refreshViewStartLoad:(ZUXRefreshView *)view;

@end // ZUXRefreshViewDelegate

#endif /* ZUtilsX_ZUXRefreshView_h */
