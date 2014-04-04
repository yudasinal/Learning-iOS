//
//  User.h
//  RESTkitGithub
//
//  Created by Andreas Eichner on 30/03/14.
//
//

#import <Foundation/Foundation.h>

@class Gist;

@interface User : NSObject

@property (nonatomic, strong, readwrite) NSNumber * userID;

@property (nonatomic, copy, readwrite) NSString *avatarURL;
@property (nonatomic, copy, readwrite) NSString *jsonURL;
@property (nonatomic, copy, readwrite) NSString * gravatarID;
@property (nonatomic, copy, readwrite) NSString * login;

@property (nonatomic, copy, readwrite) NSSet *gists;
@end