//
//  UITextView+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/25.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

#ifndef ZUtilsX_UITextView_ZUX_h
#define ZUtilsX_UITextView_ZUX_h

ZUX_CATEGORY_H(ZUX_UITextView)

@interface UITextView (ZUX)

- (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string limitWithLength:(NSUInteger)length;

@end

#endif /* ZUtilsX_UITextView_ZUX_h */
