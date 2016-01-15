//
//  UIDevice+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/23.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

#ifndef ZUtilsX_UIDevice_ZUX_h
#define ZUtilsX_UIDevice_ZUX_h

@category_interface(UIDevice, ZUX)

- (NSString *)fullModel;
- (NSString *)purifiedFullModel;

@end

#endif /* ZUtilsX_UIDevice_ZUX_h */
