//
//  CDisplayViewController.h
//  Contacts
//
//  Created by ranjit on 27/08/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CContact.h"
#import "CVendorModel.h"

@interface CDisplayViewController : UIViewController

//@property (nonatomic) CContact *contact;

@property (nonatomic)CVendorModel *vendorModel;

@property (nonatomic)BOOL itsFromFiltered;

@end
