//
//  UITextField+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/25.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UITextField+ZUX.h"

ZUX_CATEGORY_M(ZUX_UITextField)

@implementation UITextField (ZUX)

- (BOOL)shouldChangeCharactersInRange:(NSRange)range
                    replacementString:(NSString *)string
                      limitWithLength:(NSUInteger)length {
    
    NSString *toBeString = [self.text stringByReplacingCharactersInRange:range withString:string];
    if (self.markedTextRange != nil || toBeString.length <= length || range.length == 1) return YES;
    self.text = [toBeString substringToIndex:length];
    return NO;
}

@end
