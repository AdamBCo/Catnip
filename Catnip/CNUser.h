//
//  CNUser.h
//  Catnip
//
//  Created by Adam Cooper on 8/8/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface CNUser : PFObject <PFSubclassing>

@property (nonatomic, copy) UIImage * profileImage;
- (void)executeProfileImageWithCompletionBlock:(void (^)(UIImage *))completion;

@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * firstname;
@property (nonatomic, strong) NSString * lastname;
@property (nonatomic, strong) NSDate * birthdate;
@property (nonatomic) NSInteger age;
@property (nonatomic) BOOL isMale;

@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * state;
@property (nonatomic, strong) NSString * zipcode;

//Parse
+ (NSString *)parseClassName;

+ (instancetype)currentUser;

@end
