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
#import <objc/runtime.h>

ZUX_CATEGORY_M(ZUX_UIControl)

@implementation UIControl (ZUX)

#pragma mark - Border Width With UIControlState Methods.

- (void)setBorderWidth:(CGFloat)width forState:(UIControlState)state {
    ZUX_ENABLE_CATEGORY(ZUX_UIView);
    if(state == UIControlStateNormal) self.borderWidth = width;
    ZUX_ENABLE_CATEGORY(ZUX_NSNumber);
    [self zBorderWidths][[self keyForState:state]] = [NSNumber numberWithCGFloat:width];
}

- (CGFloat)borderWidthForState:(UIControlState)state {
    ZUX_ENABLE_CATEGORY(ZUX_NSNumber);
    ZUX_ENABLE_CATEGORY(ZUX_NSDictionary);
    return [[[self zBorderWidths] objectForKey:[self keyForState:state]
                                  defaultValue:[[self zBorderWidths] valueForKey:
                                                [self keyForState:UIControlStateNormal]]]
            cgfloatValue];
}

#pragma mark - Border Color With UIControlState Methods.

- (void)setBorderColor:(UIColor *)color forState:(UIControlState)state {
    ZUX_ENABLE_CATEGORY(ZUX_UIView);
    if(state == UIControlStateNormal) self.borderColor = color;
    [self zBorderColors][[self keyForState:state]] = color;
}

- (UIColor *)borderColorForState:(UIControlState)state {
    ZUX_ENABLE_CATEGORY(ZUX_NSDictionary);
    return [[self zBorderColors] objectForKey:[self keyForState:state]
                                 defaultValue:[[self zBorderColors] valueForKey:
                                               [self keyForState:UIControlStateNormal]]];
}

#pragma mark - Shadow Color With UIControlState Methods.

- (void)setShadowColor:(UIColor *)color forState:(UIControlState)state {
    ZUX_ENABLE_CATEGORY(ZUX_UIView);
    if(state == UIControlStateNormal) self.shadowColor = color;
    [self zShadowColors][[self keyForState:state]] = color;
}

- (UIColor *)shadowColorForState:(UIControlState)state {
    ZUX_ENABLE_CATEGORY(ZUX_NSDictionary);
    return [[self zShadowColors] objectForKey:[self keyForState:state]
                                 defaultValue:[[self zShadowColors] valueForKey:
                                               [self keyForState:UIControlStateNormal]]];
}

#pragma mark - Shadow Opacity With UIControlState Methods.

- (void)setShadowOpacity:(float)opacity forState:(UIControlState)state {
    ZUX_ENABLE_CATEGORY(ZUX_UIView);
    if(state == UIControlStateNormal) self.shadowOpacity = opacity;
    [self zShadowOpacities][[self keyForState:state]] = [NSNumber numberWithFloat:opacity];
}

- (float)shadowOpacityForState:(UIControlState)state {
    ZUX_ENABLE_CATEGORY(ZUX_NSDictionary);
    return [[[self zShadowOpacities] objectForKey:[self keyForState:state]
                                     defaultValue:[[self zShadowOpacities] valueForKey:
                                                   [self keyForState:UIControlStateNormal]]]
            floatValue];
}

#pragma mark - Shadow Offset With UIControlState Methods.

- (void)setShadowOffset:(CGSize)offset forState:(UIControlState)state {
    ZUX_ENABLE_CATEGORY(ZUX_UIView);
    if(state == UIControlStateNormal) self.shadowOffset = offset;
    [self zShadowOffsets][[self keyForState:state]] = [NSValue valueWithCGSize:offset];
}

- (CGSize)shadowOffsetForState:(UIControlState)state {
    ZUX_ENABLE_CATEGORY(ZUX_NSDictionary);
    return [[[self zShadowOffsets] objectForKey:[self keyForState:state]
                                   defaultValue:[[self zShadowOffsets] valueForKey:
                                                 [self keyForState:UIControlStateNormal]]]
            CGSizeValue];
}

#pragma mark - Shadow Size With UIControlState Methods.

- (void)setShadowSize:(CGFloat)size forState:(UIControlState)state {
    ZUX_ENABLE_CATEGORY(ZUX_UIView);
    if(state == UIControlStateNormal) self.shadowSize = size;
    ZUX_ENABLE_CATEGORY(ZUX_NSNumber);
    [self zShadowSizes][[self keyForState:state]] = [NSNumber numberWithCGFloat:size];
}

- (CGFloat)shadowSizeForState:(UIControlState)state {
    ZUX_ENABLE_CATEGORY(ZUX_NSNumber);
    ZUX_ENABLE_CATEGORY(ZUX_NSDictionary);
    return [[[self zShadowSizes] objectForKey:[self keyForState:state]
                                defaultValue:[[self zShadowSizes] valueForKey:
                                              [self keyForState:UIControlStateNormal]]]
            cgfloatValue];
}

#pragma mark - Swizzle Methods.
   
+ (void)load {
    [super load];
    
    ZUX_ENABLE_CATEGORY(ZUX_NSObject);
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
}

- (ZUX_INSTANCETYPE)zuxInit {
    ZUX_ENABLE_CATEGORY(ZUX_NSObject);
    [self setProperty:[NSMutableDictionary dictionary] forAssociateKey:zBorderWidthsKey];
    [self setProperty:[NSMutableDictionary dictionary] forAssociateKey:zBorderColorsKey];
    
    [self setProperty:[NSMutableDictionary dictionary] forAssociateKey:zShadowColorsKey];
    [self setProperty:[NSMutableDictionary dictionary] forAssociateKey:zShadowOpacitiesKey];
    [self setProperty:[NSMutableDictionary dictionary] forAssociateKey:zShadowOffsetsKey];
    [self setProperty:[NSMutableDictionary dictionary] forAssociateKey:zShadowSizesKey];
    
    return [self zuxInit];
}

- (void)zuxDealloc {
    ZUX_ENABLE_CATEGORY(ZUX_NSObject);
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

#pragma mark - Associated Value Methods.

NSString *const zBorderWidthsKey    = @"zBorderWidths";
NSString *const zBorderColorsKey    = @"zBorderColors";

NSString *const zShadowColorsKey    = @"zShadowColors";
NSString *const zShadowOpacitiesKey = @"zShadowOpacities";
NSString *const zShadowOffsetsKey   = @"zShadowOffsets";
NSString *const zShadowSizesKey     = @"zShadowSizes";

#define ZUXAttribute_implement(attribute) \
- (NSMutableDictionary *)attribute { \
    ZUX_ENABLE_CATEGORY(ZUX_NSObject); \
    return [self propertyForAssociateKey:attribute##Key]; \
}

ZUXAttribute_implement(zBorderWidths)
ZUXAttribute_implement(zBorderColors)
ZUXAttribute_implement(zShadowColors)
ZUXAttribute_implement(zShadowOpacities)
ZUXAttribute_implement(zShadowOffsets)
ZUXAttribute_implement(zShadowSizes)

#pragma mark - Private Methods.

- (NSString *)keyForState:(UIControlState)state {
    return [NSString stringWithFormat:@"%d", (unsigned int)state];
}

@end
