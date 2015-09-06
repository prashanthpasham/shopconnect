//
//  VProductModel.m
//  Vendor
//
//  Created by ranjit on 05/09/15.
//  Copyright © 2015 ranjit. All rights reserved.
//

#import "VProductModel.h"

@interface VProductModel()
// The backing dictionary
@property (strong, readwrite, nonatomic) NSMutableDictionary* serverDictionary;
@end


@implementation VProductModel

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
    [self.serverDictionary setValue:name forKey:@"name"];
}

- (NSString *)name {
    return self.serverDictionary[@"name"];
}


//@property (nonatomic) NSString *name;
//@property (nonatomic) NSString *price;
//@property (nonatomic) BOOL *availablity;
//@property (nonatomic) NSString *offer;
//@property (nonatomic) NSString *audience;
//
//@property (nonatomic) NSString *categoryId;
//@property (nonatomic) NSString *objectId;

- (void)setPrice:(NSString *)price {
    [self.serverDictionary setValue:price forKey:@"price"];
}

- (NSString *)price {
    return self.serverDictionary[@"price"];
}

- (void)setAvailablity:(BOOL)availablity {
    [self.serverDictionary setValue:@(availablity) forKey:@"availablity"];
}

- (BOOL)availablity {
    return [self.serverDictionary[@"availablity"]boolValue];
}

- (void)setOffer:(NSString *)offer {
    [self.serverDictionary setValue:offer forKey:@"offer"];
}

- (NSString *)offer {
    return self.serverDictionary[@"offer"];
}

- (void)setAudience:(NSString *)audience {
    [self.serverDictionary setValue:audience forKey:@"audience"];
}

- (NSString *)audience {
    return self.serverDictionary[@"audience"];
}

- (void)setCategoryId:(NSString *)categoryId {
    [self.serverDictionary setValue:categoryId forKey:@"categoryid"];
}

- (NSString *)categoryId {
    return self.serverDictionary[@"categoryid"];
}

- (void)setObjectId:(NSString *)objectId {
    [self.serverDictionary setValue:objectId forKey:@"objecid"];
}

- (NSString *)objectId {
    return self.serverDictionary[@"objectid"];
}


@end
