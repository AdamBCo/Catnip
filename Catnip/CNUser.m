//
//  CNUser.m
//  Catnip
//
//  Created by Adam Cooper on 8/8/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "CNUser.h"

@implementation CNUser

@dynamic profileImage;
@dynamic username;
@dynamic firstname;
@dynamic lastname;
@dynamic birthdate;
@dynamic isMale;
@dynamic city;
@dynamic state;
@dynamic zipcode;
@dynamic age;

+ (NSString *)parseClassName {
    return @"CNUser";
}

+ (instancetype)currentUser {
    CNUser *user = [[PFUser currentUser] objectForKey:@"userInfo"];
    return user;
}

- (void)executeProfileImageWithCompletionBlock:(void (^)(UIImage *))completion {

    if (self.profileImage) {
        completion(self.profileImage);
        return;
    }
    
    [self fetchIfNeeded];
    
    PFFile *currentUserPhoto = (PFFile *)[self objectForKey:@"profileImage"];
    [currentUserPhoto getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (data == nil) {
            completion(nil);
            return;
        }
        
        self.profileImage = [[UIImage imageWithData:data] copy];
        completion(self.profileImage);
    }];
}

-(NSString *)firstname {
    return [self objectForKey:@"firstName"];
}

-(NSString *)lastname {
    return [self objectForKey:@"lastName"];
}

-(BOOL)isMale {
    return [self relationForKey:@"isMale"];
}

-(NSDate *)birthdate {
    return [self objectForKey:@"DOB"];
}

-(NSString *)city {
    return [self objectForKey:@"city"];
}

-(NSString *)state {
    return [self objectForKey:@"state"];
}

-(NSString *)zipcode {
    return [self objectForKey:@"zipcode"];
}



@end
