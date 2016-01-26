//
//  NSObject+ZUXJson.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/20.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_NSObject_ZUXJson_h
#define ZUtilsX_NSObject_ZUXJson_h

#import <Foundation/Foundation.h>
#import "ZUXCategory.h"
#import "zobjc.h"

#if NS_BLOCKS_AVAILABLE

ZUX_EXTERN NSString *const ZUXJSON_CLASS;

@protocol ZUXJsonable <NSObject>

@optional
- (id)zuxJsonObject;
- (NSData *)zuxJsonData;
- (NSString *)zuxJsonString;
- (ZUX_INSTANCETYPE)initWithJsonObject:(id)jsonObject;
- (void)setPropertiesWithJsonObject:(id)jsonObject;

@end // ZUXJsonable

@category_interface(NSObject, ZUXJson) <ZUXJsonable>
@end // NSObject (ZUXJson)

@category_interface(NSNull, ZUXJson)
@end // NSNull (ZUXJson)

ZUX_EXTERN NSString *const ZUXJSON_STRUCT;

@category_interface(NSValue, ZUXJson)
+ (void)addSupportedObjCType:(const char *)objCType withName:(NSString *)typeName;
+ (NSValue *)valueWithJsonObject:(id)jsonObject;
@end // NSValue (ZUXJson)

#define struct_jsonable_interface(structType)                   \
category_interface(NSValue, structType##JsonableDummy)          \
@end                                                            \
ZUX_CONSTRUCTOR void add_##structType##_jsonable_support()      \
{ [NSValue addSupportedObjCType:@encode(structType)             \
                       withName:@#structType]; }                \
@interface NSValue (structType##Jsonable)                       \
- (id)zuxJsonObjectFor##structType;                             \
+ (NSValue *)valueWithJsonObjectFor##structType:(id)jsonObject; \
@end

#define struct_jsonable_implementation(structType)              \
category_implementation(NSValue, structType##JsonableDummy)     \
@end                                                            \
@implementation NSValue (structType##Jsonable)

@category_interface(NSNumber, ZUXJson)
@end // NSNumber (ZUXJson)

@category_interface(NSString, ZUXJson)
@end // NSString (ZUXJson)

@category_interface(NSArray, ZUXJson)
@end // NSArray (ZUXJson)

@category_interface(NSDictionary, ZUXJson)
@end // NSDictionary (ZUXJson)

#endif // NS_BLOCKS_AVAILABLE

#endif /* ZUtilsX_NSObject_ZUXJson_h */
