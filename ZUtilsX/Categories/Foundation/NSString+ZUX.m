//
//  NSString+ZUX.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/13.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "NSString+ZUX.h"
#import "NSObject+ZUX.h"
#import "NSData+ZUX.h"
#import "zarc.h"
#import "zadapt.h"
#include <CommonCrypto/CommonDigest.h>

@category_interface(NSString, ZUXSafe)
@end
@category_implementation(NSString, ZUXSafe)

+ (ZUX_INSTANCETYPE)zux_stringWithUTF8String:(const char *)nullTerminatedCString {
    if (!nullTerminatedCString) return nil;
    return [self zux_stringWithUTF8String:nullTerminatedCString];
}

- (ZUX_INSTANCETYPE)zux_initWithUTF8String:(const char *)nullTerminatedCString {
    if (!nullTerminatedCString) return nil;
    return [self zux_initWithUTF8String:nullTerminatedCString];
}

+ (ZUX_INSTANCETYPE)zux_stringWithCString:(const char *)cString encoding:(NSStringEncoding)enc {
    if (!cString) return nil;
    return [self zux_stringWithCString:cString encoding:enc];
}

- (ZUX_INSTANCETYPE)zux_initWithCString:(const char *)nullTerminatedCString encoding:(NSStringEncoding)encoding {
    if (!nullTerminatedCString) return nil;
    return [self zux_initWithCString:nullTerminatedCString encoding:encoding];
}

+ (void)load {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        [self swizzleClassOriSelector:@selector(stringWithUTF8String:)
                      withNewSelector:@selector(zux_stringWithUTF8String:)];
        [self swizzleInstanceOriSelector:@selector(initWithUTF8String:)
                         withNewSelector:@selector(zux_initWithUTF8String:)];
        [self swizzleClassOriSelector:@selector(stringWithCString:encoding:)
                      withNewSelector:@selector(zux_stringWithCString:encoding:)];
        [self swizzleInstanceOriSelector:@selector(initWithCString:encoding:)
                         withNewSelector:@selector(zux_initWithCString:encoding:)];
    });
}

@end // NSArray (ZUXSafe)

@category_implementation(NSString, ZUX)

#pragma mark - Empty Methods -

- (BOOL)isEmpty {
    return [self length] == 0;
}

- (BOOL)isNotEmpty {
    return [self length] != 0;
}

#pragma mark - Trim Methods -

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimToNil {
    NSString *str = [self trim];
    return [str isEmpty] ? nil : str;
}

#pragma mark - Case Methods -

- (NSString *)capitalized {
    if (self.length <= 1) return [self capitalizedString];
    return [NSString stringWithFormat:@"%@%@",
            [[self substringToIndex:1] uppercaseString],
            [self substringFromIndex:1]];
}

#pragma mark - Compare Methods -

- (BOOL)isCaseInsensitiveEqual:(id)object {
    if (object == self) return YES;
    if (!object || ![object isKindOfClass:[self class]]) return NO;
    return [self isCaseInsensitiveEqualToString:object];
}

- (BOOL)isCaseInsensitiveEqualToString:(NSString *)aString {
    if (aString == self) return YES;
    return NSOrderedSame == [self compare:aString options:NSCaseInsensitiveSearch];
}

- (NSComparisonResult)compareToVersionString:(NSString *)version {
    // Break version into fields (separated by '.')
    NSMutableArray *leftFields  = [NSMutableArray arrayWithArray:[self    componentsSeparatedByString:@"."]];
    NSMutableArray *rightFields = [NSMutableArray arrayWithArray:[version componentsSeparatedByString:@"."]];
    
    // Implict ".0" in case version doesn't have the same number of '.'
    if ([leftFields count] < [rightFields count]) {
        while ([leftFields count] != [rightFields count]) {
            [leftFields addObject:@"0"];
        }
    } else if ([leftFields count] > [rightFields count]) {
        while ([leftFields count] != [rightFields count]) {
            [rightFields addObject:@"0"];
        }
    }
    
    // Do a numeric comparison on each field
    for (NSUInteger i = 0; i < [leftFields count]; i++) {
        NSComparisonResult result = [[leftFields objectAtIndex:i] compare:[rightFields objectAtIndex:i] options:NSNumericSearch];
        if (result != NSOrderedSame) {
            return result;
        }
    }
    
    return NSOrderedSame;
}

#pragma mark - Index Methods -

- (NSUInteger)indexOfString:(NSString *)aString {
    return [self rangeOfString:aString].location;
}

- (NSUInteger)indexCaseInsensitiveOfString:(NSString *)aString {
    return [self rangeOfString:aString options:NSCaseInsensitiveSearch].location;
}

- (NSUInteger)indexOfString:(NSString *)aString fromIndex:(NSUInteger)startPos {
    return [[self substringFromIndex:startPos] rangeOfString:aString].location;
}

- (NSUInteger)indexCaseInsensitiveOfString:(NSString *)aString fromIndex:(NSUInteger)startPos {
    return [[self substringFromIndex:startPos] rangeOfString:aString options:NSCaseInsensitiveSearch].location;
}

#pragma mark - Contain Methods -

- (BOOL)containsString:(NSString *)aString {
    return [self indexOfString:aString] != NSNotFound;
}

- (BOOL)containsCaseInsensitiveString:(NSString *)aString {
    return [self indexCaseInsensitiveOfString:aString] != NSNotFound;
}

- (BOOL)containsAnyOfStringInArray:(NSArray *)array {
    for (id item in array) if ([self containsString:[item description]]) return YES;
    return NO;
}

- (BOOL)containsAnyOfCaseInsensitiveStringInArray:(NSArray *)array {
    for (id item in array) if ([self containsCaseInsensitiveString:[item description]]) return YES;
    return NO;
}

- (BOOL)containsAllOfStringInArray:(NSArray *)array {
    for (id item in array) if (![self containsString:[item description]]) return NO;
    return YES;
}

- (BOOL)containsAllOfCaseInsensitiveStringInArray:(NSArray *)array {
    for (id item in array) if (![self containsCaseInsensitiveString:[item description]]) return NO;
    return YES;
}

#pragma mark - Split Methods -

- (NSArray *)arraySplitedByString:(NSString *)separator {
    return [self arraySplitedByString:separator filterEmptyItem:YES];
}

- (NSArray *)arraySplitedByCharactersInSet:(NSCharacterSet *)separator {
    return [self arraySplitedByCharactersInSet:separator filterEmptyItem:YES];
}

- (NSArray *)arraySplitedByString:(NSString *)separator filterEmptyItem:(BOOL)filterEmptyItem {
    if (ZUX_EXPECT_F([self isEmpty])) return filterEmptyItem ? @[] : @[@""];
    NSArray *components = [self componentsSeparatedByString:separator];
    return filterEmptyItem ? [components filteredArrayUsingPredicate:
                              [NSPredicate predicateWithFormat:@"SELF.length > 0"]] : components;
}

- (NSArray *)arraySplitedByCharactersInSet:(NSCharacterSet *)separator filterEmptyItem:(BOOL)filterEmptyItem {
    if (ZUX_EXPECT_F([self isEmpty])) return filterEmptyItem ? @[] : @[@""];
    NSArray *components = [self componentsSeparatedByCharactersInSet:separator];
    return filterEmptyItem ? [components filteredArrayUsingPredicate:
                              [NSPredicate predicateWithFormat:@"SELF.length > 0"]] : components;
}

#pragma mark - Append Methods -

+ (ZUX_INSTANCETYPE)stringWithArray:(NSArray *)array {
    return [self stringWithArray:array separator:@""];
}

+ (ZUX_INSTANCETYPE)stringWithArray:(NSArray *)array separator:(NSString *)separatorString {
    if (ZUX_EXPECT_F(!array)) return @"";
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < [array count]; i++) {
        [result appendString:[[array objectAtIndex:i] description]];
        if (i + 1 < [array count]) [result appendString:separatorString];
    }
    return ZUX_AUTORELEASE([result copy]);
}

- (NSString *)appendWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION {
    NSMutableArray *temp = [NSMutableArray arrayWithObjects:self, nil];
    
    if (firstObj) {
        id arg = firstObj;
        va_list argvs;
        
        va_start(argvs, firstObj);
        do {
            [temp addObject:arg];
        } while ((arg = va_arg(argvs, id)));
        va_end(argvs);
    }
    
    return [NSString stringWithArray:temp];
}

#pragma mark - Replace Methods -

- (NSString *)stringByReplacingString:(NSString *)searchString withString:(NSString *)replacement {
    return [self stringByReplacingOccurrencesOfString:searchString withString:replacement
                                              options:0 range:NSMakeRange(0, self.length)];
}

- (NSString *)stringByCaseInsensitiveReplacingString:(NSString *)searchString withString:(NSString *)replacement {
    return [self stringByReplacingOccurrencesOfString:searchString withString:replacement
                                              options:NSCaseInsensitiveSearch range:NSMakeRange(0, self.length)];
}

- (NSString *)stringByReplacingCharactersInSet:(NSCharacterSet *)set withString:(NSString *)replacement {
    return [self stringByReplacingCharactersInSet:set withString:replacement mergeContinuous:NO];
}

- (NSString *)stringByReplacingCharactersInSet:(NSCharacterSet *)set withString:(NSString *)replacement mergeContinuous:(BOOL)mergeContinuous {
    return [NSString stringWithArray:[self arraySplitedByCharactersInSet:set filterEmptyItem:mergeContinuous]
                           separator:replacement];
}

#pragma mark - Escape/Unescape Methods -

- (NSString *)stringByEscapingForURLQuery {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if (BEFORE_IOS7) {
        static CFStringRef toEscape = CFSTR(":/=,!$&'()*+;[]@#?% ");
        return ZUX_AUTORELEASE((ZUX_BRIDGE_TRANSFER NSString *)
                               CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                       (ZUX_BRIDGE CFStringRef)self,
                                                                       NULL,
                                                                       toEscape,
                                                                       kCFStringEncodingUTF8));
    }
#endif
    return [self stringByAddingPercentEncodingWithAllowedCharacters:
            [NSCharacterSet characterSetWithCharactersInString:@":/=,!$&'()*+;[]@#?% "]];
}


- (NSString *)stringByUnescapingFromURLQuery {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    BEFORE_IOS7 ? [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] :
#endif
    [self stringByRemovingPercentEncoding];
}

#pragma mark - Encode/Decode Methods -

- (NSString *)MD5Sum {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5(cstr, (unsigned int)strlen(cstr), digest);
    NSMutableString *ms = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", digest[i]];
    }
    return ZUX_AUTORELEASE([ms copy]);
}

- (NSString *)SHA1Sum {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char digest[CC_SHA1_DIGEST_LENGTH], i;
    CC_SHA1(cstr, (unsigned int)strlen(cstr), digest);
    NSMutableString *ms = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", digest[i]];
    }
    return ZUX_AUTORELEASE([ms copy]);
}

- (NSString *)base64EncodedString  {
    if (ZUX_EXPECT_F([self length] == 0)) return nil;
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}

+ (NSString *)stringWithBase64String:(NSString *)base64String {
    return ZUX_AUTORELEASE([[NSString alloc] initWithData:[NSData dataWithBase64String:base64String]
                                                 encoding:NSUTF8StringEncoding]);
}

+ (NSString *)replaceUnicodeToUTF8:(NSString *)aUnicodeString {
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData
                                                                    options:NSPropertyListImmutable
                                                                     format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

+ (NSString *)replaceUTF8ToUnicode:(NSString *)aUTF8String {
    NSUInteger length = [aUTF8String length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0; i < length; i++) {
        unichar _char = [aUTF8String characterAtIndex:i];
        
        //判断是否为英文和数字
        if (_char <= '9' && _char >= '0') {
            [s appendFormat:@"%@",[aUTF8String substringWithRange:NSMakeRange(i, 1)]];
        } else if (_char >= 'a' && _char <= 'z') {
            [s appendFormat:@"%@",[aUTF8String substringWithRange:NSMakeRange(i, 1)]];
        } else if (_char >= 'A' && _char <= 'Z') {
            [s appendFormat:@"%@",[aUTF8String substringWithRange:NSMakeRange(i, 1)]];
        } else {
            [s appendFormat:@"\\u%x",[aUTF8String characterAtIndex:i]];
        }
    }
    return s;
}

#pragma mark - Parametric builder -

- (NSString *)parametricStringWithObject:(id)object {
    NSMutableString *result = [NSMutableString string];
    NSUInteger start = 0, end = [self indexOfString:@"${" fromIndex:start];
    while (end != NSNotFound) {
        [result appendString:[self substringWithRange:NSMakeRange(start, end)]];
        start += end + 2;
        end = [self indexOfString:@"}" fromIndex:start];
        if (end == NSNotFound) break;
        NSString *value = [object valueForKey:[self substringWithRange:NSMakeRange(start, end)]];
        [result appendString:value?:@""];
        start += end + 1;
        end = [self indexOfString:@"${" fromIndex:start];
    }
    if (start < [self length])
        [result appendString:[self substringFromIndex:start]];
    return ZUX_AUTORELEASE([result copy]);
}

#pragma mark - Size caculator -

- (CGSize)zuxSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    BEFORE_IOS7 ? [self sizeWithFont:font constrainedToSize:size] :
#endif
    [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                    attributes:@{ NSFontAttributeName:font } context:NULL].size;
}

@end
