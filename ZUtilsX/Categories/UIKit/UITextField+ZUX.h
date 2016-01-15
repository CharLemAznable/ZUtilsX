//
//  UITextField+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/25.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_UITextField_ZUX_h
#define ZUtilsX_UITextField_ZUX_h

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

@category_interface(UITextField, ZUX)

- (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string limitWithLength:(NSUInteger)length;

@end

#endif /* ZUtilsX_UITextField_ZUX_h */
