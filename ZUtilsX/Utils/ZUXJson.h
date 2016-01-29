//
//  ZUXJson.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/18.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXJson_h
#define ZUtilsX_ZUXJson_h

#import <Foundation/Foundation.h>
#import "ZUXCategory.h"
#import "zobjc.h"

typedef NS_OPTIONS(NSUInteger, ZUXJsonableOptions) {
    ZUXJsonableNone             = 0,
    ZUXJsonableWriteClassName   = 1 << 0
};

ZUX_EXTERN NSString *const ZUXJSONABLE_CLASS_NAME;
ZUX_EXTERN NSString *const ZUXJSONABLE_STRUCT_NAME; // ZUXJsonable
// You can set ZUX_USE_JSONKIT value TRUE/YES to use JSONKit, ZUX_USE_JSONKIT default FALSE/NO.
ZUX_EXTERN BOOL ZUX_USE_JSONKIT;

@interface ZUXJson : NSObject

+ (id)objectFromJsonData:(NSData *)jsonData;
+ (id)objectFromJsonData:(NSData *)jsonData asClass:(Class)clazz;

+ (id)objectFromJsonString:(NSString *)jsonString;
+ (id)objectFromJsonString:(NSString *)jsonString asClass:(Class)clazz;

+ (NSData *)jsonDataFromObject:(id)object;
+ (NSData *)jsonDataFromObject:(id)object withOptions:(ZUXJsonableOptions)options;

+ (NSString *)jsonStringFromObject:(id)object;
+ (NSString *)jsonStringFromObject:(id)object withOptions:(ZUXJsonableOptions)options;

@end // ZUXJson

@category_interface(NSData, ZUXJson)

- (id)zuxJsonObject;
- (id)zuxJsonObjectAsClass:(Class)clazz;

@end // NSData (ZUXJson)

@category_interface(NSString, ZUXJson)

- (id)zuxJsonObject;
- (id)zuxJsonObjectAsClass:(Class)clazz;

@end // NSString (ZUXJson)

@category_interface(NSObject, ZUXJson)

- (NSData *)zuxJsonData;
- (NSData *)zuxJsonDataWithOptions:(ZUXJsonableOptions)options;

- (NSString *)zuxJsonString;
- (NSString *)zuxJsonStringWithOptions:(ZUXJsonableOptions)options;

@end // NSObject (ZUXJson)

@category_interface(NSObject, ZUXJsonable)

- (id)validJsonObject;
- (id)validJsonObjectWithOptions:(ZUXJsonableOptions)options;
- (ZUX_INSTANCETYPE)initWithValidJsonObject:(id)jsonObject;
- (void)setPropertiesWithValidJsonObject:(id)jsonObject;

@end // NSObject (ZUXJsonable)

@category_interface(NSValue, ZUXJsonable)

+ (void)addJsonableObjCType:(const char *)objCType withName:(NSString *)typeName;
+ (NSValue *)valueWithValidJsonObject:(id)jsonObject;

@end // NSValue (ZUXJsonable)

// struct_jsonable_interface
#define struct_jsonable_interface(structType)                           \
category_interface(NSValue, structType##JsonableDummy)                  \
@end                                                                    \
ZUX_CONSTRUCTOR void add_##structType##_jsonable_support()              \
{ [NSValue addJsonableObjCType:@encode(structType)                      \
                      withName:@#structType]; }                         \
@interface NSValue (structType##Jsonable)                               \
- (id)validJsonObjectFor##structType;                                   \
+ (NSValue *)valueWithValidJsonObjectFor##structType:(id)jsonObject;    \
@end

// struct_jsonable_implementation
#define struct_jsonable_implementation(structType)                      \
category_implementation(NSValue, structType##JsonableDummy)             \
@end                                                                    \
@implementation NSValue (structType##Jsonable)

@category_interface(NSArray, ZUXJsonable)
+ (NSArray *)arrayWithValidJsonObject:(id)jsonObject;
@end // NSArray (ZUXJsonable)

@category_interface(NSMutableArray, ZUXJsonable)
+ (NSMutableArray *)arrayWithValidJsonObject:(id)jsonObject;
@end // NSMutableArray (ZUXJsonable)

@category_interface(NSDictionary, ZUXJsonable)
+ (NSDictionary *)dictionaryWithValidJsonObject:(id)jsonObject;
@end // NSDictionary (ZUXJsonable)

@category_interface(NSMutableDictionary, ZUXJsonable)
+ (NSMutableDictionary *)dictionaryWithValidJsonObject:(id)jsonObject;
@end // NSMutableDictionary (ZUXJsonable)

#endif /* ZUtilsX_ZUXJson_h */
