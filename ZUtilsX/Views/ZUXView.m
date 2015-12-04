//
//  ZUXView.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXView.h"
#import "zobjc.h"

@implementation ZUXView

- (ZUX_INSTANCETYPE)init {
    if (ZUX_EXPECT_T(self = [super init])) [self zuxInitial];
    return self;
}

- (ZUX_INSTANCETYPE)initWithCoder:(NSCoder *)aDecoder {
    if (ZUX_EXPECT_T(self = [super initWithCoder:aDecoder])) {
        _backgroundImage = ZUX_RETAIN([aDecoder decodeObjectOfClass:[UIImage class] forKey:@"backgroundImage"]);
    }
    return self;
}

- (ZUX_INSTANCETYPE)initWithFrame:(CGRect)frame {
    if (ZUX_EXPECT_T(self = [super initWithFrame:frame])) [self zuxInitial];
    return self;
}

- (void)zuxInitial {
    self.backgroundColor = [UIColor clearColor];
}

- (void)dealloc {
    ZUX_RELEASE(_backgroundImage);
    ZUX_SUPER_DEALLOC;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_backgroundImage forKey:@"backgroundImage"];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_backgroundImage) [_backgroundImage drawInRect:rect];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    if (ZUX_EXPECT_F([_backgroundImage isEqual:backgroundImage])) return;
    
    ZUX_RELEASE(_backgroundImage);
    _backgroundImage = ZUX_RETAIN(backgroundImage);
    [self setNeedsDisplay];
}

@end
