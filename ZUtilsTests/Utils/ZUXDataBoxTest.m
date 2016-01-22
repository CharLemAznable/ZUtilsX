//
//  ZUXDataBoxTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/19.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@databox_interface(UserDefaults, NSObject)
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *version;
@end

@databox_implementation(UserDefaults)
@default_share(UserDefaults, userId)
@keychain_users(UserDefaults, name, userId)
@restrict_users(UserDefaults, version, userId)
@end

@interface ZUXDataBoxTest : XCTestCase

@end

@implementation ZUXDataBoxTest

- (void)testZUXDataBox {
    [UserDefaults shareUserDefaults].userId = @"111";
    [UserDefaults shareUserDefaults].name = @"aaa";
    [UserDefaults shareUserDefaults].version = @"0.0.1";
    XCTAssertEqualObjects([UserDefaults shareUserDefaults].userId, @"111");
    XCTAssertEqualObjects([UserDefaults shareUserDefaults].name, @"aaa");
    XCTAssertEqualObjects([UserDefaults shareUserDefaults].version, @"0.0.1");
    [[UserDefaults shareUserDefaults] synchronize];
    
    [UserDefaults shareUserDefaults].userId = @"222";
    [UserDefaults shareUserDefaults].name = @"bbb";
    [UserDefaults shareUserDefaults].version = @"0.0.2";
    XCTAssertEqualObjects([UserDefaults shareUserDefaults].userId, @"222");
    XCTAssertEqualObjects([UserDefaults shareUserDefaults].name, @"bbb");
    XCTAssertEqualObjects([UserDefaults shareUserDefaults].version, @"0.0.2");
    [[UserDefaults shareUserDefaults] synchronize];
    
    [UserDefaults shareUserDefaults].userId = @"111";
    XCTAssertEqualObjects([UserDefaults shareUserDefaults].userId, @"111");
    XCTAssertEqualObjects([UserDefaults shareUserDefaults].name, @"aaa");
    XCTAssertEqualObjects([UserDefaults shareUserDefaults].version, @"0.0.1");
    
    [UserDefaults shareUserDefaults].userId = @"222";
    XCTAssertEqualObjects([UserDefaults shareUserDefaults].userId, @"222");
    XCTAssertEqualObjects([UserDefaults shareUserDefaults].name, @"bbb");
    XCTAssertEqualObjects([UserDefaults shareUserDefaults].version, @"0.0.2");
}

@end
