//
//  NSData+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUXCategory.h"

ZUX_CATEGORY_H(ZUX_NSData)

@interface NSData (ZUX)

- (NSString *)base64EncodedString;
+ (NSData *)dataWithBase64String:(NSString *)base64String;

@end
