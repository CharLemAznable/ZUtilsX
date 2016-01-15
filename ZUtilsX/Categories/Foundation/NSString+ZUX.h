//
//  NSString+ZUX.h
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zobjc.h"
#import "ZUXCategory.h"

#ifndef ZUtilsX_NSString_ZUX_h
#define ZUtilsX_NSString_ZUX_h

@category_interface(NSString, ZUX)

- (BOOL)isEmpty;
- (BOOL)isNotEmpty;

- (NSString *)trim;
- (NSString *)trimToNil;

- (BOOL)isCaseInsensitiveEqual:(id)object;
- (BOOL)isCaseInsensitiveEqualToString:(NSString *)aString;

- (NSComparisonResult)compareToVersionString:(NSString *)version;

- (NSUInteger)indexOfString:(NSString *)aString;
- (NSUInteger)indexCaseInsensitiveOfString:(NSString *)aString;
- (NSUInteger)indexOfString:(NSString *)aString fromIndex:(NSUInteger)startPos;
- (NSUInteger)indexCaseInsensitiveOfString:(NSString *)aString fromIndex:(NSUInteger)startPos;

- (BOOL)containsString:(NSString *)aString;
- (BOOL)containsCaseInsensitiveString:(NSString *)aString;

- (BOOL)containsAnyOfStringInArray:(NSArray *)array;
- (BOOL)containsAnyOfCaseInsensitiveStringInArray:(NSArray *)array;

- (BOOL)containsAllOfStringInArray:(NSArray *)array;
- (BOOL)containsAllOfCaseInsensitiveStringInArray:(NSArray *)array;

- (NSArray *)arraySplitedByString:(NSString *)separator;
- (NSArray *)arraySplitedByCharactersInSet:(NSCharacterSet *)separator;

- (NSArray *)arraySplitedByString:(NSString *)separator filterEmptyItem:(BOOL)filterEmptyItem;
- (NSArray *)arraySplitedByCharactersInSet:(NSCharacterSet *)separator filterEmptyItem:(BOOL)filterEmptyItem;

+ (ZUX_INSTANCETYPE)stringWithArray:(NSArray *)array;
+ (ZUX_INSTANCETYPE)stringWithArray:(NSArray *)array separator:(NSString *)separatorString;
- (NSString *)appendWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;

- (NSString *)stringByReplacingString:(NSString *)searchString withString:(NSString *)replacement;
- (NSString *)stringByCaseInsensitiveReplacingString:(NSString *)searchString withString:(NSString *)replacement;

- (NSString *)stringByEscapingForURLQuery;
- (NSString *)stringByUnescapingFromURLQuery;

- (NSString *)MD5Sum;
- (NSString *)SHA1Sum;

- (NSString *)base64EncodedString;
+ (NSString *)stringWithBase64String:(NSString *)base64String;

+ (NSString *)replaceUnicodeToUTF8:(NSString *)aUnicodeString;
+ (NSString *)replaceUTF8ToUnicode:(NSString *)aUTF8String;

- (NSString *)parametricStringWithObject:(id)object;

- (CGSize)zuxSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end

#endif /* ZUtilsX_NSString_ZUX_h */
