//
//  ZUXSingletonTest.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/23.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZUtilsX.h"

@singleton_interface(MySingleton, NSObject)
@end
@singleton_implementation(MySingleton)
@end

@singleton_interface(MySubSingleton, MySingleton)
@end
@singleton_implementation(MySubSingleton)
@end

@interface ZUXSingletonTest : XCTestCase

@end

@implementation ZUXSingletonTest

- (void)testMySingleton {
    XCTAssertEqual([MySingleton new], [MySingleton shareMySingleton]);
    XCTAssertEqual([MySingleton shareMySingleton], [[MySingleton shareMySingleton] copy]);
    XCTAssertNil([MySingleton new]);
    XCTAssertEqual([MySubSingleton new], [MySubSingleton shareMySubSingleton]);
    XCTAssertEqual([MySubSingleton shareMySubSingleton], [[MySubSingleton shareMySubSingleton] copy]);
    XCTAssertNil([MySubSingleton new]);
    XCTAssertNotEqual([MySingleton shareMySingleton], [MySubSingleton shareMySubSingleton]);
}

@end
