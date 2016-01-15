//
//  ZUXPageControl.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXPageControl.h"
#import "UIImage+ZUX.h"
#import "zobjc.h"

@interface ZUXPageControl () {
    UIImage *_pageIndicatorImage;
    UIImage *_currentPageIndicatorImage;
}

@end

@implementation ZUXPageControl

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (int i = 0; i < [self.subviews count]; i++) {
        UIImageView *dot = [self.subviews objectAtIndex:i];
        if ([dot isKindOfClass:[UIImageView class]]) {
            if (i == self.currentPage && _currentPageIndicatorColor) {
                dot.image = _currentPageIndicatorImage;
            } else if (_pageIndicatorColor) {
                dot.image = _pageIndicatorImage;
            }
        } else {
            if (i == self.currentPage && _currentPageIndicatorColor) {
                dot.backgroundColor = _currentPageIndicatorColor;
            } else if (_pageIndicatorColor) {
                dot.backgroundColor = _pageIndicatorColor;
            }
        }
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    [super setCurrentPage:currentPage];
    [self setNeedsLayout];
}

- (void)dealloc {
    ZUX_RELEASE(_pageIndicatorColor);
    ZUX_RELEASE(_currentPageIndicatorColor);
    ZUX_RELEASE(_pageIndicatorImage);
    ZUX_RELEASE(_currentPageIndicatorImage);
    ZUX_SUPER_DEALLOC;
}

- (void)setPageIndicatorColor:(UIColor *)pageIndicatorColor {
    if (ZUX_EXPECT_F([_pageIndicatorColor isEqual:pageIndicatorColor])) return;
    
    ZUX_RELEASE(_pageIndicatorColor);
    _pageIndicatorColor = ZUX_RETAIN(pageIndicatorColor);
    
    ZUX_RELEASE(_pageIndicatorImage);
    _pageIndicatorImage = ZUX_RETAIN([UIImage imageEllipseWithColor:_pageIndicatorColor
                                                               size:CGSizeMake(20, 20)]);
}

- (void)setCurrentPageIndicatorColor:(UIColor *)currentPageIndicatorColor {
    if (ZUX_EXPECT_F([_currentPageIndicatorColor isEqual:currentPageIndicatorColor])) return;
    
    ZUX_RELEASE(_currentPageIndicatorColor);
    _currentPageIndicatorColor = ZUX_RETAIN(currentPageIndicatorColor);
    
    ZUX_RELEASE(_currentPageIndicatorImage);
    _currentPageIndicatorImage = ZUX_RETAIN([UIImage imageEllipseWithColor:_currentPageIndicatorColor
                                                                      size:CGSizeMake(20, 20)]);
}

@end
