//
//  NSData+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_NSData_ZUX_h
#define ZUtilsX_NSData_ZUX_h

#import <Foundation/Foundation.h>
#import "ZUXCategory.h"

@category_interface(NSData, ZUX)

- (NSString *)base64EncodedString;
+ (NSData *)dataWithBase64String:(NSString *)base64String;

@end

#endif /* ZUtilsX_NSData_ZUX_h */
