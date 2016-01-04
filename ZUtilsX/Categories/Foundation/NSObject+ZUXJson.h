//
//  NSObject+ZUXJson.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/20.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUXCategory.h"
#import "zobjc.h"

#ifndef ZUtilsX_NSObject_ZUXJson_h
#define ZUtilsX_NSObject_ZUXJson_h

ZUX_CATEGORY_H(ZUXJson_NSObject)

#if NS_BLOCKS_AVAILABLE

@protocol ZUXJsonable <NSObject>

@optional
- (id)zuxJsonObject;
- (NSData *)zuxJsonData;
- (NSString *)zuxJsonString;
- (ZUX_INSTANCETYPE)initWithJsonObject:(id)jsonObject;

@end // ZUXJsonable

@interface NSObject (ZUXJson) <ZUXJsonable>
@end // NSObject (ZUXJson)

@interface NSNull (ZUXJson)
@end // NSNull (ZUXJson)

@interface NSValue (ZUXJson)

+ (NSValue *)valueWithJsonObject:(id)jsonObject;

@end // NSValue (ZUXJson)

@interface NSNumber (ZUXJson)
@end // NSNumber (ZUXJson)

@interface NSString (ZUXJson)
@end // NSString (ZUXJson)

@interface NSArray (ZUXJson)
@end // NSArray (ZUXJson)

@interface NSDictionary (ZUXJson)
@end // NSDictionary (ZUXJson)

#endif // NS_BLOCKS_AVAILABLE

#endif /* ZUtilsX_NSObject_ZUXJson_h */
