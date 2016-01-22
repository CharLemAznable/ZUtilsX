//
//  NSValue+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_NSValue_ZUX_h
#define ZUtilsX_NSValue_ZUX_h

#import <UIKit/UIKit.h>
#import "ZUXCategory.h"

@category_interface(NSValue, ZUX)

- (id)valueForKey:(NSString *)key;
- (id)valueForKeyPath:(NSString *)keyPath;

@end

#define struct_boxed_interface(structType)              \
category_interface(NSValue, structType##Boxed)          \
+ (NSValue *)valueWith##structType:(structType)value;   \
- (structType)structType##Value;                        \
@end

#define struct_boxed_implementation(structType)         \
category_implementation(NSValue, structType##Boxed)     \
+ (NSValue *)valueWith##structType:(structType)value {  \
    return [NSValue valueWithBytes:&value               \
            objCType:@encode(structType)];              \
}                                                       \
- (structType)structType##Value {                       \
    structType result;                                  \
    [self getValue:&result];                            \
    return result;                                      \
}                                                       \
@end


#endif /* ZUtilsX_NSValue_ZUX_h */
