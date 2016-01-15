//
//  UILabel+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UILabel+ZUX.h"
#import "zadapt.h"

@category_implementation(UILabel, ZUX)

- (CGSize)sizeThatConstraintToSize:(CGSize)size {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    !IOS7_OR_LATER ? [self.text sizeWithFont:self.font
                           constrainedToSize:size
                               lineBreakMode:self.lineBreakMode] :
#endif
    [self.text boundingRectWithSize:size
                            options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                         attributes:@{ NSFontAttributeName:self.font }
                            context:NULL].size;
}

@end
