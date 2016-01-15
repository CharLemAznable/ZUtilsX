//
//  ZUXLabel.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXLabel.h"
#import "NSCoder+ZUX.h"
#import "UILabel+ZUX.h"
#import "ZUXGeometry.h"
#import "zobjc.h"
#import "zadapt.h"
#import <CoreText/CoreText.h>

@implementation ZUXLabel

- (ZUX_INSTANCETYPE)init {
    if (ZUX_EXPECT_T(self = [super init])) [self zuxInitial];
    return self;
}

- (ZUX_INSTANCETYPE)initWithCoder:(NSCoder *)aDecoder {
    if (ZUX_EXPECT_T(self = [super initWithCoder:aDecoder])) {
        _canCopy = [aDecoder decodeBoolForKey:@"canCopy"];
        _backgroundImage = ZUX_RETAIN([aDecoder decodeObjectOfClass:[UIImage class] forKey:@"backgroundImage"]);
        _linesSpacing = [aDecoder decodeCGFloatForKey:@"linesSpacing"];
    }
    return self;
}

- (ZUX_INSTANCETYPE)initWithFrame:(CGRect)frame {
    if (ZUX_EXPECT_T(self = [super initWithFrame:frame])) [self zuxInitial];
    return self;
}

- (void)zuxInitial {
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:ZUX_AUTORELEASE([[UILongPressGestureRecognizer alloc]
                                                initWithTarget:self action:@selector(longPress:)])];
    self.backgroundColor = [UIColor clearColor];
    _linesSpacing = 0;
}

- (void)dealloc {
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    _dataSource = nil;
    ZUX_RELEASE(_backgroundImage);
    ZUX_SUPER_DEALLOC;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeBool:_canCopy forKey:@"canCopy"];
    [aCoder encodeObject:_backgroundImage forKey:@"backgroundImage"];
    [aCoder encodeCGFloat:_linesSpacing forKey:@"linesSpacing"];
}

- (void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer  {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [gestureRecognizer.view becomeFirstResponder];
        
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        NSString *copyTitle = [_dataSource respondsToSelector:@selector(menuTitleOfCopyInLabel:)]
        ? [_dataSource menuTitleOfCopyInLabel:self] : @"复制";
        menuController.menuItems = @[ZUX_AUTORELEASE([[UIMenuItem alloc] initWithTitle:copyTitle
                                                                                action:@selector(zuxCopy:)])];
        
        if ([_dataSource respondsToSelector:@selector(menuLocationInLabel:)]) {
            [menuController setTargetRect:ZUX_CGRectMake([_dataSource menuLocationInLabel:self], CGSizeZero)
                                   inView:gestureRecognizer.view];
        } else {
            [menuController setTargetRect:ZUX_CGRectMake([gestureRecognizer locationInView:gestureRecognizer.view], CGSizeZero)
                                   inView:gestureRecognizer.view];
        }
        [menuController setMenuVisible:YES animated:YES];
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return _canCopy && action == @selector(zuxCopy:);
}

- (void)zuxCopy:(id)sender {
    [UIPasteboard generalPasteboard].string = self.text;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_backgroundImage) [_backgroundImage drawInRect:rect];
}

- (void)drawTextInRect:(CGRect)rect {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]
                                                initWithString:self.text?:@""
                                                attributes:NSAttributedStringAttributesFromZUXLinesSpacingLabel(self)];
    CTFramesetterRef fsRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    CTFrameRef frame = CTFramesetterCreateFrame(fsRef, CFRangeMake(0, 0), path, NULL);
    //翻转坐标系统（文本原来是倒的要翻转下）
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    //画出文本
    CTFrameDraw(frame, context);
    UIGraphicsPushContext(context);
    //释放
    CFRelease(frame);
    CFRelease(path);
    CFRelease(fsRef);
    
    ZUX_RELEASE(attributedStr);
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    if (ZUX_EXPECT_F([_backgroundImage isEqual:backgroundImage])) return;
    
    ZUX_RELEASE(_backgroundImage);
    _backgroundImage = ZUX_RETAIN(backgroundImage);
    [self setNeedsDisplay];
}

- (void)setLinesSpacing:(CGFloat)linesSpacing {
    _linesSpacing = linesSpacing;
    [self setNeedsDisplay];
}

- (CGSize)sizeThatConstraintToSize:(CGSize)size {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]
                                                initWithString:self.text?:@""
                                                attributes:NSAttributedStringAttributesFromZUXLinesSpacingLabel(self)];
    CTFramesetterRef fsRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
    CTFrameRef frame = CTFramesetterCreateFrame(fsRef, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    CFRelease(fsRef);
    ZUX_RELEASE(attributedStr);
    
    NSUInteger lineCount = [(NSArray *)CTFrameGetLines(frame) count];
    CFRelease(frame);
    CGSize originalSize = [super sizeThatConstraintToSize:size];
    originalSize.height += (MAX(1, lineCount) - 1) * _linesSpacing;
    return originalSize;
}

#pragma mark - inline functions -

ZUX_STATIC_INLINE CTTextAlignment CTTextAlignmentFromZUXLinesSpacingLabel(ZUXLabel *label) {
    if (label.textAlignment == ZUXTextAlignmentLeft) return zkCTTextAlignmentLeft;
    else if (label.textAlignment == ZUXTextAlignmentCenter) return zkCTTextAlignmentCenter;
    else if (label.textAlignment == ZUXTextAlignmentRight) return zkCTTextAlignmentRight;
    else return zkCTTextAlignmentNatural;
}

ZUX_STATIC_INLINE NSDictionary *NSAttributedStringAttributesFromZUXLinesSpacingLabel(ZUXLabel *label) {
    NSMutableDictionary *mutableAttributes = [NSMutableDictionary dictionary];
    
    if ([NSMutableParagraphStyle class]) {
        mutableAttributes[(NSString *)kCTFontAttributeName] = label.font;
        mutableAttributes[(NSString *)kCTForegroundColorAttributeName] = label.textColor;
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = label.textAlignment;
        paragraphStyle.lineSpacing = label.linesSpacing;
        
        mutableAttributes[(NSString *)kCTParagraphStyleAttributeName] = paragraphStyle;
        ZUX_RELEASE(paragraphStyle);
    } else {
        CTFontRef font = CTFontCreateWithName((ZUX_BRIDGE CFStringRef)label.font.fontName, label.font.pointSize, NULL);
        mutableAttributes[(NSString *)kCTFontAttributeName] = (ZUX_BRIDGE id)font;
        CFRelease(font);
        
        mutableAttributes[(NSString *)kCTForegroundColorAttributeName] = (id)label.textColor.CGColor;
        
        CTTextAlignment alignment = CTTextAlignmentFromZUXLinesSpacingLabel(label);
        CGFloat lineSpacing = label.linesSpacing;
        
        CTParagraphStyleSetting paragraphStyles[] = {
            {.spec = kCTParagraphStyleSpecifierAlignment,
                .valueSize = sizeof(CTTextAlignment),
                .value = (const void *)&alignment},
            {.spec = kCTParagraphStyleSpecifierLineSpacing,
                .valueSize = sizeof(CGFloat),
                .value = (const void *)&lineSpacing}
        };
        CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(paragraphStyles, 2);
        mutableAttributes[(NSString *)kCTParagraphStyleAttributeName] = (ZUX_BRIDGE id)paragraphStyle;
        CFRelease(paragraphStyle);
    }
    return [NSDictionary dictionaryWithDictionary:mutableAttributes];
}

@end
