//
//  ZUXJson.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/18.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXJson_h
#define ZUtilsX_ZUXJson_h

#import <UIKit/UIKit.h>

// You can set ZUX_USE_JSONKIT value TRUE/YES to use JSONKit, ZUX_USE_JSONKIT default FALSE/NO.
extern BOOL ZUX_USE_JSONKIT;

@interface ZUXJson : NSObject

+ (id)objectFromJsonData:(NSData *)jsonData;
+ (id)objectFromJsonString:(NSString *)jsonString;
+ (id)objectFromJsonData:(NSData *)jsonData asClass:(Class)clazz;
+ (id)objectFromJsonString:(NSString *)jsonString asClass:(Class)clazz;

+ (NSData *)jsonDataFromObject:(id)object;
+ (NSString *)jsonStringFromObject:(id)object;

@end

#endif /* ZUtilsX_ZUXJson_h */
