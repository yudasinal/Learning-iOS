//
//  File.h
//  RESTkitGithub
//
//  Created by Andreas Eichner on 31/03/14.
//
//

#import <Foundation/Foundation.h>

@class Gist;

@interface File : NSObject

@property (nonatomic, strong, readwrite) NSNumber *size;

@property (nonatomic, copy, readwrite) NSString *fileName;
@property (nonatomic, copy, readwrite) NSString *rawURL;

@property (nonatomic, strong, readwrite) Gist *gist;

@end
