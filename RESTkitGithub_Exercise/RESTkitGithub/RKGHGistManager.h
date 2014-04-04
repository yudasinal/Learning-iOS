//
//  RKGHGistManager.h
//  RESTkitGithub
//
//  Created by Michael Conrads on 30/03/14.
//
//

#import <Foundation/Foundation.h>

@interface RKGHGistManager : NSObject

+ (instancetype)sharedManager;

- (void)fetchGistsWithCompletionHandler:(void (^)(NSArray *gists, NSError* fetchGistsError))completionHandler;

@end
