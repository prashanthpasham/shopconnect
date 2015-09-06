//
//  PFObject+Additions.m
//  ParseUser
//
//  Created by Ranjith on 05/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "PFObject+Additions.h"
#import "CConstants.h"

@implementation PFObject (Additions)

- (CContact *)contact {
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    NSArray* ignoreKeys = [self ignoreKeys];
    for (NSString* key in self.allKeys) {
        if([ignoreKeys indexOfObject:key] == NSNotFound) {
            dict[key] = [self valueForKey:key];
        }
        dict[kServerObjectIdAttribute] = self.objectId;
    }
    CContact *contact = [[CContact alloc]initWithServerDictionary:dict];
    return contact;
}

- (CVendorModel *)vendorModelwithdistance:(NSString *)distance {
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    NSArray* ignoreKeys = [self ignoreKeys];
    for (NSString* key in self.allKeys) {
        if([ignoreKeys indexOfObject:key] == NSNotFound) {
            dict[key] = [self valueForKey:key];
        }
        dict[kServerObjectIdAttribute] = self.objectId;
    }
    dict[kServerDistance] = distance;
    CVendorModel *vendorModel = [[CVendorModel alloc]initWithServerDictionary:dict];
    return vendorModel;
}


- (void)c_safeAddKey:(NSString *)key value:(id)value {
    if (key && value) {
        [self setValue:value forKey:key];
    }
}


/*!
 Keys that should not be updated to Parse.
 **/
- (NSArray*)ignoreKeys {
    return @[@"__type",
             @"className",
             @"createdAt",
             @"updatedAt",
             @"ACL",
             @"user"];
}
@end
