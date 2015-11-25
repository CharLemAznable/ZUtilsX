//
//  ZUXControl.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zarc.h"

extern float ZUXMinOperationInterval;

@interface ZUXControl : UIControl

@property (nonatomic, ZUX_STRONG) UIImage *backgroundImage;

- (void)zuxInitial;

@end