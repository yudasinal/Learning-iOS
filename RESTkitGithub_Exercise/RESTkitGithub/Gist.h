//
//  Gist.h
//  RESTkitGithub
//
//  Created by Michael Conrads on 30/03/14.
//
//

#import <Foundation/Foundation.h>

@interface Gist : NSObject

// Use these first 5 properties for the Mappingpart in the TODOs
@property (nonatomic, strong, readwrite) NSNumber *gistID;

@property (nonatomic, strong, readwrite) NSDate *createdAt;

@property (nonatomic, copy, readwrite) NSString *jsonURL;
@property (nonatomic, copy, readwrite) NSString *descriptionText;

@property (nonatomic, assign, readwrite) BOOL publicAccessable;


// These properties are just to handle all the relevant attributes from the JSON-object, but they are not important for the exercise
@property (nonatomic, strong, readwrite) NSDate *updatedAt;
@property (nonatomic, copy, readwrite) NSString *htmlURL;

@property (nonatomic, copy, readwrite) NSSet *files;
@property (nonatomic, strong, readwrite) id user;

@end

