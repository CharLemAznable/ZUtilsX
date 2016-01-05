//
//  ZUXPropertyTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/5.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface PropertyDetailBean : NSObject
@end
@implementation PropertyDetailBean
@end

@interface PropertyTestBean : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, strong) PropertyDetailBean *detail;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, strong) id others;
@end
@implementation PropertyTestBean
@end

@interface ZUXPropertyTest : XCTestCase

@end

@implementation ZUXPropertyTest

- (void)testZUXProperty {
    ZUXProperty *property = [ZUXProperty propertyWithName:@"name" inClass:[PropertyTestBean class]];
    XCTAssertFalse([property isReadOnly]);
    XCTAssertTrue([property isNonAtomic]);
    XCTAssertFalse([property isWeakReference]);
    XCTAssertFalse([property isEligibleForGarbageCollection]);
    XCTAssertFalse([property isDynamic]);
    XCTAssertEqual([property memoryManagementPolicy], ZUXPropertyMemoryManagementPolicyRetain);
    XCTAssertEqualObjects(NSStringFromSelector([property getter]), @"name");
    XCTAssertEqualObjects(NSStringFromSelector([property setter]), @"setName:");
    XCTAssertEqualObjects([property ivarName], @"_name");
    XCTAssertEqualObjects([property typeName], @"NSString");
    XCTAssertEqualObjects([property typeEncoding], @"@\"NSString\"");
    XCTAssertEqualObjects([property objectClass], [NSString class]);
    
    property = [ZUXProperty propertyWithName:@"age" inClass:[PropertyTestBean class]];
    XCTAssertFalse([property isReadOnly]);
    XCTAssertTrue([property isNonAtomic]);
    XCTAssertFalse([property isWeakReference]);
    XCTAssertFalse([property isEligibleForGarbageCollection]);
    XCTAssertFalse([property isDynamic]);
    XCTAssertEqual([property memoryManagementPolicy], ZUXPropertyMemoryManagementPolicyAssign);
    XCTAssertEqualObjects(NSStringFromSelector([property getter]), @"age");
    XCTAssertEqualObjects(NSStringFromSelector([property setter]), @"setAge:");
    XCTAssertEqualObjects([property ivarName], @"_age");
    XCTAssertEqualObjects([property typeName], @"i");
    XCTAssertEqualObjects([property typeEncoding], @"i");
    XCTAssertNil([property objectClass]);
    
    property = [ZUXProperty propertyWithName:@"detail" inClass:[PropertyTestBean class]];
    XCTAssertFalse([property isReadOnly]);
    XCTAssertTrue([property isNonAtomic]);
    XCTAssertFalse([property isWeakReference]);
    XCTAssertFalse([property isEligibleForGarbageCollection]);
    XCTAssertFalse([property isDynamic]);
    XCTAssertEqual([property memoryManagementPolicy], ZUXPropertyMemoryManagementPolicyRetain);
    XCTAssertEqualObjects(NSStringFromSelector([property getter]), @"detail");
    XCTAssertEqualObjects(NSStringFromSelector([property setter]), @"setDetail:");
    XCTAssertEqualObjects([property ivarName], @"_detail");
    XCTAssertEqualObjects([property typeName], @"PropertyDetailBean");
    XCTAssertEqualObjects([property typeEncoding], @"@\"PropertyDetailBean\"");
    XCTAssertEqualObjects([property objectClass], [PropertyDetailBean class]);
    
    property = [ZUXProperty propertyWithName:@"point" inClass:[PropertyTestBean class]];
    XCTAssertFalse([property isReadOnly]);
    XCTAssertTrue([property isNonAtomic]);
    XCTAssertFalse([property isWeakReference]);
    XCTAssertFalse([property isEligibleForGarbageCollection]);
    XCTAssertFalse([property isDynamic]);
    XCTAssertEqual([property memoryManagementPolicy], ZUXPropertyMemoryManagementPolicyAssign);
    XCTAssertEqualObjects(NSStringFromSelector([property getter]), @"point");
    XCTAssertEqualObjects(NSStringFromSelector([property setter]), @"setPoint:");
    XCTAssertEqualObjects([property ivarName], @"_point");
    XCTAssertEqualObjects([property typeName], @"{CGPoint=dd}");
    XCTAssertEqualObjects([property typeEncoding], @"{CGPoint=dd}");
    XCTAssertEqualObjects([property objectClass], [NSValue class]);
    
    property = [ZUXProperty propertyWithName:@"others" inClass:[PropertyTestBean class]];
    XCTAssertFalse([property isReadOnly]);
    XCTAssertTrue([property isNonAtomic]);
    XCTAssertFalse([property isWeakReference]);
    XCTAssertFalse([property isEligibleForGarbageCollection]);
    XCTAssertFalse([property isDynamic]);
    XCTAssertEqual([property memoryManagementPolicy], ZUXPropertyMemoryManagementPolicyRetain);
    XCTAssertEqualObjects(NSStringFromSelector([property getter]), @"others");
    XCTAssertEqualObjects(NSStringFromSelector([property setter]), @"setOthers:");
    XCTAssertEqualObjects([property ivarName], @"_others");
    XCTAssertEqualObjects([property typeName], @"");
    XCTAssertEqualObjects([property typeEncoding], @"@");
    XCTAssertNil([property objectClass]);
}

@end
