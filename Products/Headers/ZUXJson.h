//
//  ZUXJson.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/18.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef ZUtilsX_ZUXJson_h
#define ZUtilsX_ZUXJson_h

// You can define ZUX_USE_JSONKIT to use JSONKit.
//#define ZUX_USE_JSONKIT

@interface ZUXJson : NSObject

+ (id)objectFromJsonData:(NSData *)jsonData;
+ (id)objectFromJsonString:(NSString *)jsonString;
+ (id)objectFromJsonData:(NSData *)jsonData asClass:(Class)clazz;
+ (id)objectFromJsonString:(NSString *)jsonString asClass:(Class)clazz;

+ (NSData *)jsonDataFromObject:(id)object;
+ (NSString *)jsonStringFromObject:(id)object;

@end

#endif /* ZUtilsX_ZUXJson_h */
