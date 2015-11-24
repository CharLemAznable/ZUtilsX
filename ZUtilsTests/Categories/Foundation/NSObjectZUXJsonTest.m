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
+ (NSArray *)zuxJsonPropertyNames {
    return @[@"field1", @"field2", @"field3"];
}
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

@interface NSObjectZUXJsonTest : XCTestCase

@end

@implementation NSObjectZUXJsonTest

- (void)testNSObjectZUXJson {
    ZUX_ENABLE_CATEGORY(ZUXJson_NSObject);
    
    XCTAssertEqualObjects([@"JSON" zuxJsonString], @"JSON");
    
    JsonBean *jsonBean = [[JsonBean alloc] initWithJsonObject:@{@"field1":@[]}];
    XCTAssertEqualObjects([jsonBean zuxJsonString], @"{\"field3\":0,\"field1\":[]}");
    
    jsonBean.field1 = [NSNull null];
    XCTAssertEqualObjects([jsonBean zuxJsonString], @"{\"field3\":0}");
    
    jsonBean.field2 = @"JSON";
    XCTAssertEqualObjects([jsonBean zuxJsonString], @"{\"field3\":0,\"field2\":\"JSON\"}");
    
    jsonBean.field1 = [NSArray array];
    XCTAssertEqualObjects([jsonBean zuxJsonString], @"{\"field3\":0,\"field2\":\"JSON\",\"field1\":[]}");
    
    NSDictionary *dict = @{@"json":jsonBean};
    XCTAssertEqualObjects([dict zuxJsonString], @"{\"json\":{\"field3\":0,\"field2\":\"JSON\",\"field1\":[]}}");
    
    NSArray *array = @[dict];
    XCTAssertEqualObjects([array zuxJsonString], @"[{\"json\":{\"field3\":0,\"field2\":\"JSON\",\"field1\":[]}}]");
}

@end
