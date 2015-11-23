//
//  ZUXJsonTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/23.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface People : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int age;
@end
@implementation People
+ (NSArray *)zuxJsonPropertyNames {
    return @[@"name", @"age"];
}
- (BOOL)isEqual:(id)object {
    if (object == self) return YES;
    if (!object || ![object isKindOfClass:[self class]]) return NO;
    return [self isEqualToPeople:object];
}
- (BOOL)isEqualToPeople:(People *)people {
    if (self == people) return YES;
    if (_age != people.age) return NO;
    if (_name == nil && people.name == nil) return YES;
    if (_name == nil || people.name == nil) return NO;
    return [_name isEqualToString:people.name];
}
@end

@interface ZUXJsonTest : XCTestCase

@end

@implementation ZUXJsonTest

- (void)testZUXJson {
    NSDictionary *dict = @{@"key" : @"KEY", @"value" : @"VALUE"};
    NSString *dictJson = @"{\"key\":\"KEY\",\"value\":\"VALUE\"}";
    XCTAssertEqualObjects([ZUXJson jsonStringFromObject:dict], dictJson);
    XCTAssertEqualObjects([ZUXJson objectFromJsonString:dictJson], dict);
    
    ZUX_ENABLE_ALL_CATEGORIES;
    People *people = [[People alloc] init];
    people.name = @"John";
    people.age = 10;
    NSString *peopleJson = @"{\"name\":\"John\",\"age\":10}";
    XCTAssertEqualObjects([ZUXJson jsonStringFromObject:people], peopleJson);
    XCTAssertEqualObjects([ZUXJson objectFromJsonString:peopleJson asClass:[People class]], people);
}

@end
