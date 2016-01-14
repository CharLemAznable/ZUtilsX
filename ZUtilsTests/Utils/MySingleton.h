//
//  MySingleton.h
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/14.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUtilsX.h"

@interface MySingleton : NSObject
ZUX_SINGLETON_H(sharedInstance)
@end
