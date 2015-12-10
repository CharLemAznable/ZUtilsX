//
//  ZUXGeometry.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXGeometry_h
#define ZUtilsX_ZUXGeometry_h

#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIGeometry.h>
#import "zobjc.h"

ZUX_EXTERN CGRect ZUX_CGRectMake(CGPoint origin, CGSize size);
ZUX_EXTERN CGSize ZUX_CGSizeFromUIOffset(UIOffset offset);
ZUX_EXTERN UIOffset ZUX_UIOffsetFromCGSize(CGSize size);

#endif /* ZUtilsX_ZUXGeometry_h */
