//
//  Album.m
//  AlbumApp
//
//  Created by Liubou Yudasina on 2014-04-03.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import "Album.h"

@implementation Album

- (instancetype)initWithTitle:(NSString *)title withArtist:(NSString *)artist withYear:(NSString *)year withGenre:(NSString *)genre
{
    self = [super init];
    if (self) {
        _title = title;
        _artist = artist;
        _year = year;
        _genre = genre;
    }
    return self;
}

@end
