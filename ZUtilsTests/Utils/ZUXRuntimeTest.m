//
//  ZUXRuntimeTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/23.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface Detail : NSObject
@end
@implementation Detail
@end

@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, strong) Detail *detail;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, strong) id others;
@end
@implementation Person
@end

@interface ZUXRuntimeTest : XCTestCase

@end

@implementation ZUXRuntimeTest

- (void)testRuntime {
    ZUXPropertyAttribute *attr = ZUX_GetPropertyAttributeByName([Person class], @"name");
    XCTAssertFalse(attr.readonly);
    XCTAssertTrue(attr.nonatomic);
    XCTAssertFalse(attr.weak);
    XCTAssertFalse(attr.canBeCollected);
    XCTAssertFalse(attr.dynamic);
    XCTAssertEqual(attr.memoryManagementPolicy, ZUXPropertyMemoryManagementPolicyRetain);
    XCTAssertEqualObjects(NSStringFromSelector(attr.getter), @"name");
    XCTAssertEqualObjects(NSStringFromSelector(attr.setter), @"setName:");
    XCTAssertEqualObjects(attr.ivar, @"_name");
    XCTAssertEqualObjects(attr.type, @"@\"NSString\"");
    XCTAssertEqualObjects(attr.objectClass, [NSString class]);
    
    attr = ZUX_GetPropertyAttributeByName([Person class], @"age");
    XCTAssertFalse(attr.readonly);
    XCTAssertTrue(attr.nonatomic);
    XCTAssertFalse(attr.weak);
    XCTAssertFalse(attr.canBeCollected);
    XCTAssertFalse(attr.dynamic);
    XCTAssertEqual(attr.memoryManagementPolicy, ZUXPropertyMemoryManagementPolicyAssign);
    XCTAssertEqualObjects(NSStringFromSelector(attr.getter), @"age");
    XCTAssertEqualObjects(NSStringFromSelector(attr.setter), @"setAge:");
    XCTAssertEqualObjects(attr.ivar, @"_age");
    XCTAssertEqualObjects(attr.type, @"i");
    XCTAssertNil(attr.objectClass);
    
    attr = ZUX_GetPropertyAttributeByName([Person class], @"detail");
    XCTAssertFalse(attr.readonly);
    XCTAssertTrue(attr.nonatomic);
    XCTAssertFalse(attr.weak);
    XCTAssertFalse(attr.canBeCollected);
    XCTAssertFalse(attr.dynamic);
    XCTAssertEqual(attr.memoryManagementPolicy, ZUXPropertyMemoryManagementPolicyRetain);
    XCTAssertEqualObjects(NSStringFromSelector(attr.getter), @"detail");
    XCTAssertEqualObjects(NSStringFromSelector(attr.setter), @"setDetail:");
    XCTAssertEqualObjects(attr.ivar, @"_detail");
    XCTAssertEqualObjects(attr.type, @"@\"Detail\"");
    XCTAssertEqualObjects(attr.objectClass, [Detail class]);
    
    attr = ZUX_GetPropertyAttributeByName([Person class], @"point");
    XCTAssertFalse(attr.readonly);
    XCTAssertTrue(attr.nonatomic);
    XCTAssertFalse(attr.weak);
    XCTAssertFalse(attr.canBeCollected);
    XCTAssertFalse(attr.dynamic);
    XCTAssertEqual(attr.memoryManagementPolicy, ZUXPropertyMemoryManagementPolicyAssign);
    XCTAssertEqualObjects(NSStringFromSelector(attr.getter), @"point");
    XCTAssertEqualObjects(NSStringFromSelector(attr.setter), @"setPoint:");
    XCTAssertEqualObjects(attr.ivar, @"_point");
    XCTAssertEqualObjects(attr.type, @"{CGPoint=dd}");
    XCTAssertEqualObjects(attr.objectClass, [NSValue class]);
    
    attr = ZUX_GetPropertyAttributeByName([Person class], @"others");
    XCTAssertFalse(attr.readonly);
    XCTAssertTrue(attr.nonatomic);
    XCTAssertFalse(attr.weak);
    XCTAssertFalse(attr.canBeCollected);
    XCTAssertFalse(attr.dynamic);
    XCTAssertEqual(attr.memoryManagementPolicy, ZUXPropertyMemoryManagementPolicyRetain);
    XCTAssertEqualObjects(NSStringFromSelector(attr.getter), @"others");
    XCTAssertEqualObjects(NSStringFromSelector(attr.setter), @"setOthers:");
    XCTAssertEqualObjects(attr.ivar, @"_others");
    XCTAssertEqualObjects(attr.type, @"@");
    XCTAssertNil(attr.objectClass);
}

@end
