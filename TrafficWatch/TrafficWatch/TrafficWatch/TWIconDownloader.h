//
//  TWIconDownloader.h
//  TrafficWatch
//
//  Created by Liubou Yudasina on 2014-04-11.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TWIncident;

@interface TWIconDownloader : NSObject

@property (nonatomic, strong) TWIncident *incident;
@property (nonatomic, copy) void (^completionHandler)(void);

- (void)startDownload;
- (void)cancelDownload;

@end
