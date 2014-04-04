//
//  Album.h
//  AlbumApp
//
//  Created by Liubou Yudasina on 2014-04-03.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* artist;
@property (strong, nonatomic) NSString* year;
@property (strong, nonatomic) NSString* genre;

-(instancetype)initWithTitle:(NSString *) title
                  withArtist:(NSString *) artist
                    withYear:(NSString *) year
                   withGenre:(NSString *) genre;

@end
