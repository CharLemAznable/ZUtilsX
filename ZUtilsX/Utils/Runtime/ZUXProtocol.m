//
//  ZUXProtocol.m
//  ZUtilsX
//
//  Created by Char Aznable on 16/1/5.
//  Copyright © 2016年 org.cuc.n3. All rights reserved.
//

#import "ZUXProtocol.h"
#import "ZUXMethod.h"
#import "zarc.h"

@interface ZUXProtocolInternal : ZUXProtocol {
    Protocol *_protocol;
}
@end // ZUXProtocolInternal

#pragma mark - Implementation -

@implementation ZUXProtocol

+ (NSArray *)allProtocols {
    unsigned int count;
    Protocol * __unsafe_unretained *protocols = objc_copyProtocolList(&count);
    
    NSMutableArray *array = [NSMutableArray array];
    for (unsigned i = 0; i < count; i++)
        [array addObject:[self protocolWithObjCProtocol:protocols[i]]];
    
    free(protocols);
    return ZUX_AUTORELEASE([array copy]);
}

+ (ZUXProtocol *)protocolWithObjCProtocol:(Protocol *)protocol {
    return ZUX_AUTORELEASE([[self alloc] initWithObjCProtocol:protocol]);
}

+ (ZUXProtocol *)protocolWithName:(NSString *)name {
    return ZUX_AUTORELEASE([[self alloc] initWithName:name]);
}

- (ZUX_INSTANCETYPE)initWithObjCProtocol:(Protocol *)protocol {
    ZUX_RELEASE(self);
    return [[ZUXProtocolInternal alloc] initWithObjCProtocol:protocol];
}

- (instancetype)initWithName:(NSString *)name {
    return [self initWithObjCProtocol:objc_getProtocol(name.UTF8String)];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p: %@>",
            [self class], self, [self name]];
}

- (BOOL)isEqual:(id)other {
    return [other isKindOfClass:[self class]]
    && protocol_isEqual([self objCProtocol], [other objCProtocol]);
}

- (NSUInteger)hash {
    return [(id)[self objCProtocol] hash];
}

- (Protocol *)objCProtocol {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)name {
    return @(protocol_getName([self objCProtocol]));
}

- (NSArray *)incorporatedProtocols {
    unsigned int count;
    Protocol * __unsafe_unretained *protocols = protocol_copyProtocolList([self objCProtocol], &count);
    
    NSMutableArray *array = [NSMutableArray array];
    for (unsigned i = 0; i < count; i++)
        [array addObject:[ZUXProtocol protocolWithObjCProtocol:protocols[i]]];
    
    free(protocols);
    return ZUX_AUTORELEASE([array copy]);
}

- (NSArray *)methodsRequired:(BOOL)isRequiredMethod instance:(BOOL)isInstanceMethod {
    unsigned int count;
    struct objc_method_description *methods = protocol_copyMethodDescriptionList
    ([self objCProtocol], isRequiredMethod, isInstanceMethod, &count);
    
    NSMutableArray *array = [NSMutableArray array];
    for (unsigned i = 0; i < count; i++) {
        NSString *signature = [NSString stringWithCString:methods[i].types encoding:[NSString defaultCStringEncoding]];
        [array addObject:[ZUXMethod methodWithSelector:methods[i].name implementation:NULL signature:signature]];
    }
    
    free(methods);
    return ZUX_AUTORELEASE([array copy]);
}

@end

@implementation ZUXProtocolInternal

- (ZUX_INSTANCETYPE)initWithObjCProtocol:(Protocol *)protocol {
    if (ZUX_EXPECT_T(self = [self init])) _protocol = protocol;
    return self;
}

- (Protocol *)objCProtocol {
    return _protocol;
}

@end
