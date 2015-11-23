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

ZUX_CATEGORY_H(ZUXJson_NSObject)

#if NS_BLOCKS_AVAILABLE

@protocol ZUXJsonable <NSObject>

@optional
+ (NSArray *)zuxJsonPropertyNames;
- (id)zuxJsonObject;
- (NSData *)zuxJsonData;
- (NSString *)zuxJsonString;
- (ZUX_INSTANCETYPE)initWithJsonObject:(id)jsonObject;

@end

@interface NSObject (ZUXJson) <ZUXJsonable>
@end

@interface NSNull (ZUXJson)
@end

@interface NSNumber (ZUXJson)
@end

@interface NSString (ZUXJson)
@end

@interface NSArray (ZUXJson)
@end

@interface NSDictionary (ZUXJson)
@end

#endif
