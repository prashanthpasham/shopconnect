//
//  VCateogryModel.h
//  Vendor
//
//  Created by ranjit on 05/09/15.
//  Copyright © 2015 ranjit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCateogryModel : NSObject


/*!
 Initializes with Server dictionary
 */
- (id)initWithServerDictionary:(NSDictionary*)dictionary;

/*!
 Returns dictionary that can be safely updated to Server.
 This dictionary contains server keys.
 */
- (NSDictionary*)dictionary;

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *categoryType;
@property (nonatomic) BOOL availability;

// need to use CLLocation
@property (nonatomic) NSString *vendorLocation;

@property (nonatomic) NSString *objectId;
@property (nonatomic) NSString *vendorObjectId;


@end
