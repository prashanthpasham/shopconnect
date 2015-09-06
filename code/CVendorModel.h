//
//  CVendorModel.h
//  Contacts
//
//  Created by Abid MAC-Mini on 06/09/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CVendorModel : NSObject


/*!
 Initializes with Server dictionary
 */
- (id)initWithServerDictionary:(NSDictionary*)dictionary;

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *phone;

@property (nonatomic, retain) NSString *distance;

@property (nonatomic)NSArray *products;

- (NSDictionary*)dictionary;


@end
