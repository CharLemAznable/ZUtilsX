//
//  ZUXAppConfigTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/28.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@appconfig_interface(AppConfig, NSObject)
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *key1;
@end
@appconfig_implementation(AppConfig)
@appconfig(AppConfig, key)
@appconfig(AppConfig, key1)
@end

@appconfig_interface(BundleConfig, NSObject)
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *key2;
@end
@appconfig_implementation(BundleConfig)
appconfig_bundle(BundleConfig, ZUXAppConfig)
@appconfig(BundleConfig, key)
@appconfig(BundleConfig, key2)
@end

@interface ZUXAppConfigTest : XCTestCase

@end

@implementation ZUXAppConfigTest

- (void)testPerformanceExample {
    XCTAssertNil([AppConfig shareAppConfig].key);
    XCTAssertEqualObjects([AppConfig shareAppConfig].key1, @"value1");
    XCTAssertNil([BundleConfig shareBundleConfig].key);
    XCTAssertEqualObjects([BundleConfig shareBundleConfig].key2, @"value2");
}

@end
