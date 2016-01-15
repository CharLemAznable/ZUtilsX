//
//  NSValue+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_NSValue_ZUX_h
#define ZUtilsX_NSValue_ZUX_h

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

@category_interface(NSValue, ZUX)

- (id)valueForKey:(NSString *)key;
- (id)valueForKeyPath:(NSString *)keyPath;

@end

#endif /* ZUtilsX_NSValue_ZUX_h */
