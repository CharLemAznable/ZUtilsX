//
//  UILabel+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

ZUX_CATEGORY_H(ZUX_UILabel)

@interface UILabel (ZUX)

- (CGSize)sizeThatConstraintToSize:(CGSize)size;

@end