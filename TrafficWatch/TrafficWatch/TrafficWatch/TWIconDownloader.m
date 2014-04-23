//
//  TWIconDownloader.m
//  TrafficWatch
//
//  Created by Liubou Yudasina on 2014-04-11.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import "TWIconDownloader.h"
#import "TWIncident.h"

#define kAppIconSize 48

@interface TWIconDownloader ()
@property (nonatomic, strong) NSMutableData *activeDownload;
@property (nonatomic, strong) NSURLConnection *imageConnection;
@end


@implementation TWIconDownloader

- (void)startDownload
{
    self.activeDownload = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.incident.imageURLString]];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    self.imageConnection = conn;
}

- (void)cancelDownload
{
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.activeDownload = nil;
    self.imageConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
    
    self.incident.incidentIcon = image;
    
    self.activeDownload = nil;
    self.imageConnection = nil;
    if (self.completionHandler)
        self.completionHandler();
}

@end