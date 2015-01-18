//
//  NSObject+Description.m
//  cli
//
//  Created by tailec on 18/01/2015.
//  Copyright (c) 2015 tailec. All rights reserved.
//

#import "NSObject+Description.h"
#import "objc/runtime.h"

@implementation NSObject (Description)

- (NSString*)PRDdescription {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        const char *property = property_getName(properties[i]);
        NSString *propertyString = [NSString stringWithCString:property encoding:[NSString defaultCStringEncoding]];
        id obj = [self valueForKey:propertyString];
        [dict setValue:obj forKey:propertyString];
    }
    
    free(properties);
    return [NSString stringWithFormat:@"<%@ %p %@>",
            [self class],
            self,
            dict];
}

@end
