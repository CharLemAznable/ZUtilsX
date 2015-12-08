//
//  UILabel+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UILabel+ZUX.h"
#import "zadapt.h"

ZUX_CATEGORY_M(ZUX_UILabel)

@implementation UILabel (ZUX)

- (CGSize)sizeThatConstraintToSize:(CGSize)size {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
        return [self.text boundingRectWithSize:size
                                       options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                    attributes:@{ NSFontAttributeName:self.font }
                                       context:NULL].size;
#else
        return [self.text sizeWithFont:self.font
                     constrainedToSize:size
                         lineBreakMode:self.lineBreakMode];
#endif
}

@end
