//
//  CServerUserManager.m
//  Contacts
//
//  Created by ranjit on 14/08/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CServerUserManager.h"
#import "CConstants.h"
#import "PFObject+Additions.h"

@implementation CServerUserManager

+ (CServerUserManager*)sharedInstance {
    static CServerUserManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[CServerUserManager alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    return self;
}

- (void)logInWithExistingUser:(NSString *)userName
                     password:(NSString *)password :(loginUserCompletionBlock)block {

[PFUser
      logInWithUsernameInBackground:userName
                           password:password
                              block:^(PFUser *pfUser, NSError *error) {
                                if (!error) {
                                  CUser *user = [[CUser alloc] init];
                                  [user
                                      setUsername:
                                          [pfUser valueForKey:kServerUserName]];
                                  [user
                                      setPassword:
                                          [pfUser valueForKey:kServerPassword]];
                                  [user
                                      setEmail:[pfUser
                                                   valueForKey:
                                                       kServerEmailAttribute]];
                                    [self startRollNumber];
                                  block(user,nil);
                                } else {
                                  block(nil,error);
                                }
                              }];
}

- (void)createNewUserWithEmail:(NSString *)email
                          name:(NSString *)name
                      password:(NSString *)password
                              :(createUserCompletionBlock)block {
    PFUser *user = [PFUser user];
    user.username = email;
    user.password = password;
    [user setValue:name forKey:@"name"];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self startRollNumber];
        block(succeeded,error);
    }];
}

- (void)createAnonymousUser:(anonymousUserCompletionBlock)block {
    [PFAnonymousUtils logInWithBlock:^(PFUser *user,NSError *error){
        if(!error && user){
            CUser *user = [CUser new];
            [user setUsername:[user valueForKey:kServerUserName]];
            [self startRollNumber];
            block(user,nil);
        }
        else{
            block(nil,error);
        }
    }];
}

- (void)logout:(logoutCompletionBlock)block {
    if([PFUser currentUser]) {
        [PFUser logOutInBackgroundWithBlock:block];
    }
}

- (void)isAnonymousUser:(isAnonymousUserCompletionBlock)block{
    block([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]);
}

- (BOOL)hasCurrentUser {
    return [PFUser currentUser]? YES : NO;
}

- (NSString *)userObjectId {
    return [[PFUser currentUser]objectId];
}

- (NSString *)userName {
    return [[PFUser currentUser] valueForKey:@"name"];
}

- (NSString *)email {
    return [[PFUser currentUser] username];
}

- (NSDate*)createdAt {
    return [[PFUser currentUser] createdAt];
}

- (void)forgotPassword:(NSString *)email :(forgotPasswordCompletioBlock)block {
    [PFUser requestPasswordResetForEmailInBackground:email block:block];
}

#pragma helper

// Here we will face an issue, While converting from anonymous user to New or Existing one
// for the RollNumber. ? will see

- (void)startRollNumber{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults objectForKey:@"rollNumber"]){
        [defaults setObject:[NSNumber numberWithInt:0] forKey:@"rollNumber"];
        [defaults synchronize];
    }
}

- (void)fetchNearByVendors:(NSDictionary *)currentLocation :(fetchNearyByVendorsCompletionBlock)block {
   PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:[currentLocation[kServerLatitude] doubleValue] longitude:[currentLocation[kServerLongtitude]doubleValue]];
    PFQuery *query = [PFQuery queryWithClassName:kServerVendorClassName];
    [query whereKey:kServerLocation nearGeoPoint:userGeoPoint withinMiles:10.0];
    NSError *error = nil;
    NSArray *arrayOfVendors = [query findObjects:&error];
    NSMutableArray *vendorModels = [NSMutableArray new];
    if(arrayOfVendors && arrayOfVendors.count) {
        double distance;
        for(PFObject *pfObject in arrayOfVendors) {
            PFGeoPoint *vendorPoint = pfObject[kServerLocation];
            distance = [userGeoPoint distanceInKilometersTo:vendorPoint];
            [vendorModels addObject:[pfObject vendorModelwithdistance:[NSString stringWithFormat:@"%f Kilometers away",distance]]];
        }
        block(vendorModels,nil);
    }
    else {
        block(nil,error);
    }
}


@end
