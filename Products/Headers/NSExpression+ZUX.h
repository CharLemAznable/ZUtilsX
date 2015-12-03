//
//  NSExpression+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUXCategory.h"

#ifndef ZUtilsX_NSExpression_ZUX_h
#define ZUtilsX_NSExpression_ZUX_h

ZUX_CATEGORY_H(ZUX_NSExpression)

@interface NSExpression (ZUX)

/*
 * NSExpression keywords Array. Use in ExpressionFormat with prefix: # .
 */
+ (NSArray *)keywordsArrayInExpressionFormat;

/*
 * Expression that format parametric keyPath with %K.
 * For example:
 * parametricFormat - @"...${keyPath}..."
 * result           - [NSExpression expressionWithFormat:@"...%K...", @"keyPath"]
 */
+ (NSExpression *)expressionWithParametricFormat:(NSString *)parametricFormat;

@end

#endif /* ZUtilsX_NSExpression_ZUX_h */
