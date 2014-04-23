//
//  TWIncident.m
//  TrafficWatch
//
//  Created by Liubou Yudasina on 2014-04-04.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import "TWIncident.h"

@implementation TWIncident

-(instancetype)initWithTitle:(NSString *)title
                 summary:(NSString *)summary
                 weblink:(NSString *)weblink
                 imageURLString:(NSString *)imageURLString

{
    
    self = [super init];
    if (self) {
        _title = title;
        _summary = summary;
        _weblink = weblink;
        _imageURLString = imageURLString;
        
    }
    return self;
    
}


-(id)init {
    return [self initWithTitle:@"Unknown incident" summary:@"Not available." weblink:@"Not available." imageURLString:nil];
}

-(NSString *)description {
    
    NSString *theDescription = [[NSString alloc] initWithFormat:@"< %@: title = %@, weblink = %@, summary = %@ >", NSStringFromClass([self class]), self.title, self.weblink, self.summary];
    
    return theDescription;
}



@end
