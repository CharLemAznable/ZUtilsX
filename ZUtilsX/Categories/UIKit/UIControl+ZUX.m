//
//  UIControl+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "UIControl+ZUX.h"
#import "NSObject+ZUX.h"
#import "NSNumber+ZUX.h"
#import "NSDictionary+ZUX.h"
#import "UIView+ZUX.h"
#import "zarc.h"
#import "zappearance.h"
#import <objc/runtime.h>

@category_implementation(UIControl, ZUX)

#pragma mark - Border Width With UIControlState Methods -

- (CGFloat)borderWidthForState:(UIControlState)state {
    return [[[self zBorderWidths] objectForKey:[self keyForState:state]
                                  defaultValue:[[self zBorderWidths] valueForKey:
                                                [self keyForState:UIControlStateNormal]]]
            cgfloatValue];
}

- (void)setBorderWidth:(CGFloat)width forState:(UIControlState)state {
    if(state == UIControlStateNormal) self.borderWidth = width;
    [self zBorderWidths][[self keyForState:state]] = [NSNumber numberWithCGFloat:width];
}

#pragma mark - Border Color With UIControlState Methods -

- (UIColor *)borderColorForState:(UIControlState)state {
    return [[self zBorderColors] objectForKey:[self keyForState:state]
                                 defaultValue:[[self zBorderColors] valueForKey:
                                               [self keyForState:UIControlStateNormal]]];
}

- (void)setBorderColor:(UIColor *)color forState:(UIControlState)state {
    if(state == UIControlStateNormal) self.borderColor = color;
    [self zBorderColors][[self keyForState:state]] = color;
}

#pragma mark - Shadow Color With UIControlState Methods -

- (UIColor *)shadowColorForState:(UIControlState)state {
    return [[self zShadowColors] objectForKey:[self keyForState:state]
                                 defaultValue:[[self zShadowColors] valueForKey:
                                               [self keyForState:UIControlStateNormal]]];
}

- (void)setShadowColor:(UIColor *)color forState:(UIControlState)state {
    if(state == UIControlStateNormal) self.shadowColor = color;
    [self zShadowColors][[self keyForState:state]] = color;
}

#pragma mark - Shadow Opacity With UIControlState Methods -

- (float)shadowOpacityForState:(UIControlState)state {
    return [[[self zShadowOpacities] objectForKey:[self keyForState:state]
                                     defaultValue:[[self zShadowOpacities] valueForKey:
                                                   [self keyForState:UIControlStateNormal]]]
            floatValue];
}

- (void)setShadowOpacity:(float)opacity forState:(UIControlState)state {
    if(state == UIControlStateNormal) self.shadowOpacity = opacity;
    [self zShadowOpacities][[self keyForState:state]] = [NSNumber numberWithFloat:opacity];
}

#pragma mark - Shadow Offset With UIControlState Methods -

- (CGSize)shadowOffsetForState:(UIControlState)state {
    return [[[self zShadowOffsets] objectForKey:[self keyForState:state]
                                   defaultValue:[[self zShadowOffsets] valueForKey:
                                                 [self keyForState:UIControlStateNormal]]]
            CGSizeValue];
}

- (void)setShadowOffset:(CGSize)offset forState:(UIControlState)state {
    if(state == UIControlStateNormal) self.shadowOffset = offset;
    [self zShadowOffsets][[self keyForState:state]] = [NSValue valueWithCGSize:offset];
}

#pragma mark - Shadow Size With UIControlState Methods -

- (CGFloat)shadowSizeForState:(UIControlState)state {
    return [[[self zShadowSizes] objectForKey:[self keyForState:state]
                                defaultValue:[[self zShadowSizes] valueForKey:
                                              [self keyForState:UIControlStateNormal]]]
            cgfloatValue];
}

- (void)setShadowSize:(CGFloat)size forState:(UIControlState)state {
    if(state == UIControlStateNormal) self.shadowSize = size;
    [self zShadowSizes][[self keyForState:state]] = [NSNumber numberWithCGFloat:size];
}

#pragma mark - Swizzle Methods -
   
+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        // init
        [self swizzleInstanceOriSelector:@selector(init)
                         withNewSelector:@selector(zuxInit)];
#if !IS_ARC
        // dealloc
        [self swizzleInstanceOriSelector:@selector(dealloc)
                         withNewSelector:@selector(zuxDealloc)];
#endif
        // state
        [self swizzleInstanceOriSelector:@selector(setHighlighted:)
                         withNewSelector:@selector(zuxSetHighlighted:)];
        [self swizzleInstanceOriSelector:@selector(setSelected:)
                         withNewSelector:@selector(zuxSetSelected:)];
        [self swizzleInstanceOriSelector:@selector(setEnabled:)
                         withNewSelector:@selector(zuxSetEnabled:)];
    });
}

- (ZUX_INSTANCETYPE)zuxInit {
    [self setProperty:[NSMutableDictionary dictionary] forAssociateKey:zBorderWidthsKey];
    [self setProperty:[NSMutableDictionary dictionary] forAssociateKey:zBorderColorsKey];
    
    [self setProperty:[NSMutableDictionary dictionary] forAssociateKey:zShadowColorsKey];
    [self setProperty:[NSMutableDictionary dictionary] forAssociateKey:zShadowOpacitiesKey];
    [self setProperty:[NSMutableDictionary dictionary] forAssociateKey:zShadowOffsetsKey];
    [self setProperty:[NSMutableDictionary dictionary] forAssociateKey:zShadowSizesKey];
    
    return [self zuxInit];
}

- (void)zuxDealloc {
    [self setProperty:nil forAssociateKey:zBorderWidthsKey];
    [self setProperty:nil forAssociateKey:zBorderColorsKey];
    
    [self setProperty:nil forAssociateKey:zShadowColorsKey];
    [self setProperty:nil forAssociateKey:zShadowOpacitiesKey];
    [self setProperty:nil forAssociateKey:zShadowOffsetsKey];
    [self setProperty:nil forAssociateKey:zShadowSizesKey];
    
    [self zuxDealloc];
}

- (void)zuxSetHighlighted:(BOOL)highlighted {
    [self zuxSetHighlighted:highlighted];
    UIControlState state = highlighted ? UIControlStateHighlighted : [self isSelected] ? UIControlStateSelected : UIControlStateNormal;
    
    self.borderWidth    = [self borderWidthForState:state];
    self.borderColor    = [self borderColorForState:state];
    
    self.shadowColor    = [self shadowColorForState:state];
    self.shadowOpacity  = [self shadowOpacityForState:state];
    self.shadowOffset   = [self shadowOffsetForState:state];
    self.shadowSize     = [self shadowSizeForState:state];
}

- (void)zuxSetSelected:(BOOL)selected {
    [self zuxSetSelected:selected];
    UIControlState state = selected ? UIControlStateSelected : UIControlStateNormal;
    
    self.borderWidth    = [self borderWidthForState:state];
    self.borderColor    = [self borderColorForState:state];
    
    self.shadowColor    = [self shadowColorForState:state];
    self.shadowOpacity  = [self shadowOpacityForState:state];
    self.shadowOffset   = [self shadowOffsetForState:state];
    self.shadowSize     = [self shadowSizeForState:state];
}

- (void)zuxSetEnabled:(BOOL)enabled {
    [self zuxSetEnabled:enabled];
    UIControlState state = enabled ? UIControlStateNormal : UIControlStateDisabled;
    
    self.borderWidth    = [self borderWidthForState:state];
    self.borderColor    = [self borderColorForState:state];
    
    self.shadowColor    = [self shadowColorForState:state];
    self.shadowOpacity  = [self shadowOpacityForState:state];
    self.shadowOffset   = [self shadowOffsetForState:state];
    self.shadowSize     = [self shadowSizeForState:state];
}

#pragma mark - Associated Value Methods -

NSString *const zBorderWidthsKey    = @"zBorderWidths";
NSString *const zBorderColorsKey    = @"zBorderColors";

NSString *const zShadowColorsKey    = @"zShadowColors";
NSString *const zShadowOpacitiesKey = @"zShadowOpacities";
NSString *const zShadowOffsetsKey   = @"zShadowOffsets";
NSString *const zShadowSizesKey     = @"zShadowSizes";

#define ZUXAttribute_implement(attribute)                   \
- (NSMutableDictionary *)attribute {                        \
    return [self propertyForAssociateKey:attribute##Key];   \
}

ZUXAttribute_implement(zBorderWidths)
ZUXAttribute_implement(zBorderColors)
ZUXAttribute_implement(zShadowColors)
ZUXAttribute_implement(zShadowOpacities)
ZUXAttribute_implement(zShadowOffsets)
ZUXAttribute_implement(zShadowSizes)

#pragma mark - Private Methods -

- (NSString *)keyForState:(UIControlState)state {
    return [NSString stringWithFormat:@"%d", (unsigned int)state];
}

@end

@category_implementation(UIControl, ZUXAppearance)

+ (CGFloat)borderWidthForState:(UIControlState)state {
    return [APPEARANCE borderWidthForState:state];
}

+ (void)setBorderWidth:(CGFloat)width forState:(UIControlState)state {
    [APPEARANCE setBorderWidth:width forState:state];
}

+ (UIColor *)borderColorForState:(UIControlState)state {
    return [APPEARANCE borderColorForState:state];
}

+ (void)setBorderColor:(UIColor *)color forState:(UIControlState)state {
    [APPEARANCE setBorderColor:color forState:state];
}

+ (UIColor *)shadowColorForState:(UIControlState)state {
    return [APPEARANCE shadowColorForState:state];
}

+ (void)setShadowColor:(UIColor *)color forState:(UIControlState)state {
    [APPEARANCE setShadowColor:color forState:state];
}

+ (float)shadowOpacityForState:(UIControlState)state {
    return [APPEARANCE shadowOpacityForState:state];
}

+ (void)setShadowOpacity:(float)opacity forState:(UIControlState)state {
    [APPEARANCE setShadowOpacity:opacity forState:state];
}

+ (CGSize)shadowOffsetForState:(UIControlState)state {
    return [APPEARANCE shadowOffsetForState:state];
}

+ (void)setShadowOffset:(CGSize)offset forState:(UIControlState)state {
    [APPEARANCE setShadowOffset:offset forState:state];
}

+ (CGFloat)shadowSizeForState:(UIControlState)state {
    return [APPEARANCE shadowSizeForState:state];
}

+ (void)setShadowSize:(CGFloat)size forState:(UIControlState)state {
    [APPEARANCE setShadowSize:size forState:state];
}

@end
