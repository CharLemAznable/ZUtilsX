//
//  ZUXKeychainTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/12/14.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@interface ZUXKeychainTest : XCTestCase

@end

@implementation ZUXKeychainTest

- (void)testExample {
    NSError *error = nil;
    NSString *password = [ZUXKeychain passwordForUsername:@"admin" andService:@"ZUXKeychainTest" error:&error];
    XCTAssertNil(password);
    XCTAssertNil(error);
    
    error = nil;
    XCTAssertTrue([ZUXKeychain storePassword:@"passwd" forUsername:@"admin" andService:@"ZUXKeychainTest" updateExisting:YES error:&error]);
    XCTAssertEqualObjects([ZUXKeychain passwordForUsername:@"admin" andService:@"ZUXKeychainTest" error:&error], @"passwd");
    XCTAssertNil(error);
    
    error = nil;
    XCTAssertTrue([ZUXKeychain deletePasswordForUsername:@"admin" andService:@"ZUXKeychainTest" error:&error]);
    XCTAssertNil(error);
    
    error = nil;
    password = [ZUXKeychain passwordForUsername:@"admin" andService:@"ZUXKeychainTest" error:&error];
    XCTAssertNil(password);
    XCTAssertNil(error);
}

@end
