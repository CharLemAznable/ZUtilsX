//
//  ZUXGeometry.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/18.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXGeometry.h"

ZUX_INLINE CGRect ZUX_CGRectMake(CGPoint origin, CGSize size) {
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}

ZUX_INLINE CGSize ZUX_CGSizeFromUIOffset(UIOffset offset) {
    return CGSizeMake(offset.horizontal, offset.vertical);
}

ZUX_INLINE UIOffset ZUX_UIOffsetFromCGSize(CGSize size) {
    return UIOffsetMake(size.width, size.height);
}
