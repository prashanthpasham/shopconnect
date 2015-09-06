//
//  VCateogryModel.m
//  Vendor
//
//  Created by ranjit on 05/09/15.
//  Copyright © 2015 ranjit. All rights reserved.
//

#import "VCateogryModel.h"


@interface VCateogryModel()
// The backing dictionary
@property (strong, readwrite, nonatomic) NSMutableDictionary* serverDictionary;
@end

@implementation VCateogryModel

- (id)init {
    self = [super init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [self setServerDictionary:[NSMutableDictionary dictionaryWithDictionary:dict]];
    return self;
}

- (id)initWithServerDictionary:(NSDictionary*)dictionary {
    self = [super init];
    [self setServerDictionary:[NSMutableDictionary dictionaryWithDictionary:dictionary]];
    return self;
}

- (void)setName:(NSString *)name {
    [self.serverDictionary setValue:name forKey:@"name" ];
}

- (NSString *)name {
    return self.serverDictionary[@"name"];
}

- (void)setAvailability:(BOOL)availability {
    [self.serverDictionary setValue:@(availability) forKey:@"availability"];
}

- (BOOL)isAvailability {
    return [self.serverDictionary[@"availablity"]boolValue];
}

- (void)setObjectId:(NSString *)objectId {
    [self.serverDictionary setValue:objectId forKey:@"objectid"];
}

- (NSString *)objectId {
    return self.serverDictionary[@"objectid"];
}

- (void)setVendorObjectId:(NSString *)vendorObjectId {
    [self.serverDictionary setValue:vendorObjectId forKey:@"vendorobjectid"];
}

- (NSString *)vendorObjectId {
    return self.serverDictionary[@"vendorobjectid"];
}

@end
