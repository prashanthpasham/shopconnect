//
//  VProductModel.h
//  Vendor
//
//  Created by ranjit on 05/09/15.
//  Copyright © 2015 ranjit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VProductModel : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *price;
@property (nonatomic) BOOL availablity;
@property (nonatomic) NSString *offer;
@property (nonatomic) NSString *audience;

@property (nonatomic) NSString *categoryId;
@property (nonatomic) NSString *objectId;

@end
