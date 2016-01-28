//
//  UIImageView+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/28.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import "UIImageView+ZUX.h"
#import "zarc.h"

@category_implementation(UIImageView, ZUX)

+ (UIImageView *)imageViewWithImage:(UIImage *)image {
    return ZUX_AUTORELEASE([[self alloc] initWithImage:image]);
}

@end
