//
//  ZUXDataBox.h
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/15.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXDataBox_h
#define ZUtilsX_ZUXDataBox_h

#import "ZUXSingleton.h"

#define databoxface(CLASS_NAME, SUPER_CLASS_NAME) \
singleton_interface(CLASS_NAME, SUPER_CLASS_NAME) \
extern NSString *const zuxAppEverLaunchedKey; \
extern NSString *const zuxAppFirstLaunchKey;

#define databoxation(CLASS_NAME) \
singleton_implementation(CLASS_NAME)

#endif
