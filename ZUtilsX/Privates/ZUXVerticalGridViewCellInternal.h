//
//  ZUXVerticalGridViewCellInternal.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#ifndef ZUtilsX_ZUXVerticalGridViewCellInternal_h
#define ZUtilsX_ZUXVerticalGridViewCellInternal_h

#import "zarc.h"

@class ZUXVerticalGridView;

@interface ZUXVerticalGridViewCell ()

@property (nonatomic, ZUX_WEAK) NSUInteger index;
@property (nonatomic, ZUX_WEAK) ZUXVerticalGridView *gridView;

@end

#endif /* ZUtilsX_ZUXVerticalGridViewCellInternal_h */
