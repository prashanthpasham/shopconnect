//
//  CVendorModel.m
//  Contacts
//
//  Created by Abid MAC-Mini on 06/09/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import "CVendorModel.h"
#import "CConstants.h"
#import "NSMutableDictionary+Additions.h"

@interface CVendorModel ()

// The backing Dictionary!
@property (nonatomic,strong)NSMutableDictionary *serverDictionary;

@end

@implementation CVendorModel

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
- (NSDictionary*)dictionary {
    return self.serverDictionary;
}

- (NSString*)username {
    return self.serverDictionary[kServerUserName];
}

- (void)setUsername:(NSString *)username {
    [self.serverDictionary safeAddForKey:kServerUserName value:username];
}

- (void)setDistance:(NSString *)distance {
    [self.serverDictionary safeAddForKey:kServerDistance value:distance];
}

- (NSString *)distance {
    return self.serverDictionary[kServerDistance];
}

- (void)setPhone:(NSString *)phone {
    [self.serverDictionary safeAddForKey:kServerPhoneAttribute value:phone];
}

- (NSString *)phone {
    return self.serverDictionary[kServerPhoneAttribute];
}

- (void)setProducts:(NSArray *)products {
    [self.serverDictionary safeAddForKey:@"products" value:products];
}

- (NSArray *)products {
    return self.serverDictionary[@"products"];
}


@end
