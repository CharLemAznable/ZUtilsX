//
//  ZUXRuntime.m
//  ZUtilsX
//
//  Created by Char Aznable on 15/11/18.
//  Copyright © 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXRuntime.h"
#import "zobjc.h"
#import "zarc.h"

@interface ZUXPropertyAttribute ()

@property (nonatomic, readwrite) BOOL readonly;
@property (nonatomic, readwrite) BOOL nonatomic;
@property (nonatomic, readwrite) BOOL weak;
@property (nonatomic, readwrite) BOOL canBeCollected;
@property (nonatomic, readwrite) BOOL dynamic;
@property (nonatomic, readwrite) ZUXPropertyMemoryManagementPolicy memoryManagementPolicy;
@property (nonatomic, readwrite) SEL getter;
@property (nonatomic, readwrite) SEL setter;
@property (nonatomic, readwrite, ZUX_STRONG) NSString *name;
@property (nonatomic, readwrite, ZUX_STRONG) NSString *ivar;
@property (nonatomic, readwrite, ZUX_STRONG) NSString *type;
@property (nonatomic, readwrite) Class objectClass;

@end
@implementation ZUXPropertyAttribute
@end

ZUX_EXTERN ZUXPropertyAttribute *ZUX_GetPropertyAttributeByName(Class cls, NSString *propertyName) {
    objc_property_t property = class_getProperty(cls, propertyName.UTF8String);
    if (ZUX_EXPECT_F(!property)) return nil;
    return ZUX_GetPropertyAttribute(property);
}

ZUX_EXTERN ZUXPropertyAttribute *ZUX_GetPropertyAttribute(objc_property_t property) {
    const char * const attributes = property_getAttributes(property);
    if (ZUX_EXPECT_F(!attributes || attributes[0] != 'T')) return nil;
    
    const char *type = attributes + 1;
    const char *next = NSGetSizeAndAlignment(type, NULL, NULL);
    if (ZUX_EXPECT_F(!next)) return nil;
    
    size_t typeLength = next - type;
    if (ZUX_EXPECT_F(!typeLength)) return nil;
    
    char *temp = NULL;
    ZUXPropertyAttribute *attribute = ZUX_AUTORELEASE([ZUXPropertyAttribute new]);
    if ((temp = calloc(1, typeLength + 1)) != NULL) {
        strncpy(temp, type, typeLength); temp[typeLength] = '\0';
        attribute.type = [NSString stringWithUTF8String:temp];
        free(temp);
    }
    
    if (type[0] == *(@encode(id)) && type[1] == '"') { // object type
        const char *className = type + 2;
        next = strchr(className, '"');
        if (ZUX_EXPECT_F(!next)) return nil;
        
        if (ZUX_EXPECT_T(className != next)) {
            size_t classNameLength = next - className;
            char trimmedName[classNameLength + 1];
            strncpy(trimmedName, className, classNameLength);
            trimmedName[classNameLength] = '\0';
            
            attribute.objectClass = objc_getClass(trimmedName);
        }
    } else if (type[0] == '{') { // struct type
        attribute.objectClass = [NSValue class];
    }
    
    if (ZUX_EXPECT_T(*next != '\0')) next = strchr(next, ',');
    while (next && *next == ',') {
        char flag = next[1];
        next += 2;
        
        switch (flag) {
            case '\0'   : break;
            case 'R'    : attribute.readonly = YES; break;
            case 'C'    : attribute.memoryManagementPolicy = ZUXPropertyMemoryManagementPolicyCopy; break;
            case '&'    : attribute.memoryManagementPolicy = ZUXPropertyMemoryManagementPolicyRetain; break;
            case 'N'    : attribute.nonatomic = YES; break;
            case 'G'    :
            case 'S'    : {
                const char *nextFlag = strchr(next, ',');
                SEL name = NULL;
                
                if (!nextFlag) {
                    // assume that the rest of the string is the selector
                    const char *selectorString = next;
                    next = "";
                    name = sel_registerName(selectorString);
                } else {
                    size_t selectorLength = nextFlag - next;
                    if (ZUX_EXPECT_F(!selectorLength)) return nil;
                    
                    char selectorString[selectorLength + 1];
                    strncpy(selectorString, next, selectorLength);
                    selectorString[selectorLength] = '\0';
                    
                    name = sel_registerName(selectorString);
                    next = nextFlag;
                }
                
                if (flag == 'G') attribute.getter = name;
                else attribute.setter = name;
            } break;
            case 'D'    : attribute.dynamic = YES; break;
            case 'V'    :
                if (*next != '\0') {
                    attribute.ivar = [NSString stringWithUTF8String:next];
                    next = "";
                }
                break;
            case 'W'    : attribute.weak = YES; break;
            case 'P'    : attribute.canBeCollected = YES; break;
            // Old-style type, skip over this type encoding
            case 't'    : while (*next != ',' && *next != '\0') ++next; break;
            default     : ;
        }
    }
    if (attribute.memoryManagementPolicy == ZUXPropertyMemoryManagementPolicyAssign
        && type[0] == *(@encode(id))) attribute.weak = YES;
    
    attribute.name = @(property_getName(property));
    if (!attribute.getter) attribute.getter = sel_registerName(attribute.name.UTF8String);
    if (!attribute.readonly && !attribute.setter) {
        const char *propertyName = attribute.name.UTF8String;
        size_t propertyNameLength = strlen(propertyName);
        size_t setterLength = propertyNameLength + 4;
        
        char setterName[setterLength + 1];
        strncpy(setterName, "set", 3);
        strncpy(setterName + 3, propertyName, propertyNameLength);
        
        // capitalize property name for the setter
        setterName[3] = (char)toupper(setterName[3]);
        
        setterName[setterLength - 1] = ':';
        setterName[setterLength] = '\0';
        
        attribute.setter = sel_registerName(setterName);
    }
    
    return attribute;
}

ZUX_INLINE void enumerateObjectProperties(id object, ZUXObjectPropertyProcessor processor) {
    if (ZUX_EXPECT_F(!object || !processor)) return;
    
    enumerateClassProperties([object class], ^(objc_property_t property) {
        processor(object, property);
    });
}

ZUX_EXTERN void enumerateClassProperties(Class cls, ZUXPropertyProcessor processor) {
    if (ZUX_EXPECT_F(!cls || !processor)) return;
    
    unsigned int propertiesCount;
    objc_property_t *properties = class_copyPropertyList(cls, &propertiesCount);
    if (ZUX_EXPECT_F(propertiesCount == 0)) return;
    
    for (int i = 0; i < propertiesCount; i++) processor(properties[i]);
}
