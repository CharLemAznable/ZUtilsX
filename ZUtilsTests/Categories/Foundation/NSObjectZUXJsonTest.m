//
//  NSObjectZUXJsonTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/24.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface JsonBean : NSObject
@property (nonatomic, strong) id field1;
@property (nonatomic, strong) NSString *field2;
@property (nonatomic, assign) int field3;
@end
@implementation JsonBean
- (BOOL)isEqual:(id)object {
    if (object == self) return YES;
    if (!object || ![object isKindOfClass:[self class]]) return NO;
    return [self isEqualToJsonBean:object];
}
- (BOOL)isEqualToJsonBean:(JsonBean *)jsonBean {
    if (self == jsonBean) return YES;
    if (_field3 != jsonBean.field3) return NO;
    if (_field1 == nil && jsonBean.field1 == nil &&
        _field2 == nil && jsonBean.field2 == nil) return YES;
    if (_field1 == nil || jsonBean.field1 == nil ||
        _field2 == nil || jsonBean.field2 == nil) return NO;
    return [_field1 isEqual:jsonBean.field1] && [_field2 isEqualToString:jsonBean.field2];
}
@end

typedef struct ZUXTestStructBool {
    bool a;
    bool b;
} ZUXTestStructBool;
@struct_boxed_interface(ZUXTestStructBool)
@struct_boxed_implementation(ZUXTestStructBool)

@struct_jsonable_interface(ZUXTestStructBool)
@struct_jsonable_implementation(ZUXTestStructBool)
- (id)validJsonObjectForZUXTestStructBool {
    ZUXTestStructBool v = [self ZUXTestStructBoolValue];
    return @{@"a": @(v.a), @"b": @(v.b)};
}
+ (NSValue *)valueWithValidJsonObjectForZUXTestStructBool:(id)jsonObject {
    BOOL a = [[jsonObject objectForKey:@"a"] boolValue];
    BOOL b = [[jsonObject objectForKey:@"b"] boolValue];
    ZUXTestStructBool v = {.a = a, .b = b};
    return [NSValue valueWithZUXTestStructBool:v];
}
@end

@interface JsonBean2 : NSObject
@property (nonatomic, strong) NSArray *array;
@end
@implementation JsonBean2
@end

@interface NSObjectZUXJsonTest : XCTestCase

@end

@implementation NSObjectZUXJsonTest

- (void)testNSObjectZUXJson {
    ZUX_USE_JSONKIT = YES;
    XCTAssertEqualObjects([@"JSON" zuxJsonString], @"\"JSON\"");
    ZUX_USE_JSONKIT = NO;
    XCTAssertEqualObjects([@"JSON" zuxJsonString], @"JSON");
    
    JsonBean *jsonBean = [[JsonBean alloc] initWithValidJsonObject:@{@"field1":@[]}];
    XCTAssertEqualObjects([jsonBean zuxJsonStringWithOptions:ZUXJsonableWriteClassName],
                          @"{\"field3\":0,\"ZUXClassName\":\"JsonBean\",\"field1\":[]}");
    
    jsonBean.field1 = [NSNull null];
    XCTAssertEqualObjects([jsonBean zuxJsonStringWithOptions:ZUXJsonableWriteClassName],
                          @"{\"field3\":0,\"ZUXClassName\":\"JsonBean\"}");
    
    jsonBean.field2 = @"JSON";
    XCTAssertEqualObjects([jsonBean zuxJsonStringWithOptions:ZUXJsonableWriteClassName],
                          @"{\"field3\":0,\"field2\":\"JSON\",\"ZUXClassName\":\"JsonBean\"}");
    
    jsonBean.field1 = [NSArray array];
    XCTAssertEqualObjects([jsonBean zuxJsonStringWithOptions:ZUXJsonableWriteClassName],
                          @"{\"field1\":[],\"field2\":\"JSON\",\"ZUXClassName\":\"JsonBean\",\"field3\":0}");
    
    NSDictionary *dict = @{@"json":jsonBean};
    XCTAssertEqualObjects([dict zuxJsonStringWithOptions:ZUXJsonableWriteClassName],
                          @"{\"json\":{\"field1\":[],\"field2\":\"JSON\",\"ZUXClassName\":\"JsonBean\",\"field3\":0}}");
    
    NSArray *array = @[dict];
    XCTAssertEqualObjects([array zuxJsonStringWithOptions:ZUXJsonableWriteClassName],
                          @"[{\"json\":{\"field1\":[],\"field2\":\"JSON\",\"ZUXClassName\":\"JsonBean\",\"field3\":0}}]");
    
    NSValue *pointValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    id pointJson = [pointValue validJsonObject];
    NSDictionary *expectDict = @{@"ZUXStructName":@"{CGPoint=dd}", @"x":@1, @"y":@1};
    XCTAssertEqualObjects(pointJson, expectDict);
    NSValue *pointValue2 = [NSValue valueWithValidJsonObject:pointJson];
    XCTAssertEqual([pointValue2 CGPointValue].x, 1);
    XCTAssertEqual([pointValue2 CGPointValue].y, 1);
    
    ZUXTestStructBool b = {.a = YES, .b = NO};
    NSValue *boolValue = [NSValue valueWithZUXTestStructBool:b];
    id boolJson = [boolValue validJsonObject];
    expectDict = @{@"ZUXStructName":@(@encode(ZUXTestStructBool)), @"a":@1, @"b":@0};
    XCTAssertEqualObjects(boolJson, expectDict);
    NSValue *boolValue2 = [NSValue valueWithValidJsonObject:boolJson];
    XCTAssertEqual([boolValue2 ZUXTestStructBoolValue].a, YES);
    XCTAssertEqual([boolValue2 ZUXTestStructBoolValue].b, NO);
    
    JsonBean2 *j2 = [[JsonBean2 alloc] initWithValidJsonObject:
  @{@"array":@[@{@"ZUXStructName":@(@encode(ZUXTestStructBool)), @"a":@1, @"b":@0}]}];
    XCTAssertEqual([j2.array[0] ZUXTestStructBoolValue].a, YES);
    XCTAssertEqual([j2.array[0] ZUXTestStructBoolValue].b, NO);
    
    NSDictionary *d1 = [[NSDictionary alloc] initWithValidJsonObject:
  @{@"array":@[@{@"ZUXStructName":@(@encode(ZUXTestStructBool)), @"a":@1, @"b":@0}]}];
    XCTAssertEqual([d1[@"array"][0] ZUXTestStructBoolValue].a, YES);
    XCTAssertEqual([d1[@"array"][0] ZUXTestStructBoolValue].b, NO);
}

@end
