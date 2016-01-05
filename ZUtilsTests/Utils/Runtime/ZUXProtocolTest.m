//
//  ZUXProtocolTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/5.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@protocol ProtocolTestProtocol <NSObject>

@required
+ (void)classMethod1;
- (void)instanceMethod1;

@optional
+ (void)classMethod2;
- (void)instanceMethod2;

@end

@interface ProtocolTestBean : NSObject <ProtocolTestProtocol>
@end
@implementation ProtocolTestBean
+ (void)classMethod1 {}
- (void)instanceMethod1 {}
@end

@interface ZUXProtocolTest : XCTestCase

@end

@implementation ZUXProtocolTest

- (void)testZUXProtocol {
    ZUXProtocol *protocol = [ZUXProtocol protocolWithName:@"ProtocolTestProtocol"];
    XCTAssertEqualObjects([protocol name], @"ProtocolTestProtocol");
    
    NSArray *incorporatedProtocols = [protocol incorporatedProtocols];
    XCTAssertEqual(incorporatedProtocols.count, 1);
    XCTAssertEqualObjects(incorporatedProtocols[0], [ZUXProtocol protocolWithName:@"NSObject"]);
    
    NSArray *requiredInstance = [protocol methodsRequired:YES instance:YES];
    XCTAssertEqual(requiredInstance.count, 1);
    XCTAssertEqualObjects([requiredInstance[0] selectorName], @"instanceMethod1");
    
    NSArray *requiredClass = [protocol methodsRequired:YES instance:NO];
    XCTAssertEqual(requiredClass.count, 1);
    XCTAssertEqualObjects([requiredClass[0] selectorName], @"classMethod1");
    
    NSArray *optionalInstance = [protocol methodsRequired:NO instance:YES];
    XCTAssertEqual(optionalInstance.count, 1);
    XCTAssertEqualObjects([optionalInstance[0] selectorName], @"instanceMethod2");
    
    NSArray *optionalClass = [protocol methodsRequired:NO instance:NO];
    XCTAssertEqual(optionalClass.count, 1);
    XCTAssertEqualObjects([optionalClass[0] selectorName], @"classMethod2");
}

@end
