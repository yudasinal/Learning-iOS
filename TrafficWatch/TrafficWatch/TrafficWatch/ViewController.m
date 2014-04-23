    //
//  ViewController.m
//  TrafficWatch
//
//  Created by Liubou Yudasina on 2014-04-04.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import "ViewController.h"
#import "TWIncident.h"
#import "TWIncidentParseOperation.h"
#import <objc/runtime.h>
#import "TWIconDownloader.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *incidents;
@property (strong, nonatomic) NSOperationQueue *operationQueue;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *myLocation;

@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end

@implementation ViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];

    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    self.locationManager.delegate = self;
    
    [self.locationManager startUpdatingLocation];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor colorWithRed:200/255.0 green:88/255.0 blue:200/255.0 alpha:1.0];
    self.refreshControl = refreshControl;
    
    [refreshControl addTarget:self action:@selector(userPulledRefresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    _tableView.delegate = self;
    [self.tableView addSubview:refreshControl];
    
    [self loadIncidentsData];
    
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation *aLocation = [locations lastObject];
    self.myLocation = aLocation;
    
}

-(void)incidentsParser:(TWIncidentParseOperation *)parser loadIncident:(TWIncident *)newIncident {
    [self.incidents addObject:newIncident];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.incidents count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"incidentCell";
    
   
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    TWIncident *incident = self.incidents[indexPath.row];
    cell.textLabel.text = incident.title;
    cell.detailTextLabel.text = incident.summary;
    cell.imageView.contentMode = UIViewContentModeCenter;
    
    if (!incident.incidentIcon)
    {
        if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
        {
            [self startIconDownload:incident forIndexPath:indexPath];
        }
        cell.imageView.image = [UIImage imageNamed:@"placeholder.png"];
    }
    else
    {
        cell.imageView.image = incident.incidentIcon;
    }

    return cell;
    
}

- (void)startIconDownload:(TWIncident *)incident forIndexPath:(NSIndexPath *)indexPath
{
    TWIconDownloader *iconDownloader = [self.imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[TWIconDownloader alloc] init];
        iconDownloader.incident = incident;
        [iconDownloader setCompletionHandler:^{
            
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            
            cell.imageView.image = incident.incidentIcon;
            
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        [self.imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
    }
}

- (void)loadImagesForOnscreenRows
{
    if ([self.incidents count] > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            TWIncident *incident = [self.incidents objectAtIndex:indexPath.row];
            
            if (!incident.incidentIcon)
            {
                [self startIconDownload:incident forIndexPath:indexPath];
            }
        }
    }
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self loadImagesForOnscreenRows];
}



- (void)loadIncidentsData {
    
    if(self.operationQueue) {
        
        //download in progress
        return;
    }
    NSString *incidentURLString = @"http://www.freiefahrt.info/lmst.de_DE.xml";
    NSURL *feedURL = [NSURL URLWithString:incidentURLString];
    self.incidents = [NSMutableArray array];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    TWIncidentParseOperation *parseOperation = [[TWIncidentParseOperation alloc] initWithFeedURL:feedURL delegate:self];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.operationQueue addOperation:parseOperation];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
    
}

-(void) userPulledRefresh {
    
    if(    self.operationQueue == nil)
    {
        self.operationQueue = [[NSOperationQueue alloc] init];
    }

        
        [self.operationQueue cancelAllOperations];
        NSString *incidentURLString = @"http://www.freiefahrt.info/lmst.de_DE.xml";
        NSURL *feedURL = [NSURL URLWithString:incidentURLString];
        TWIncidentParseOperation *parseOperation = [[TWIncidentParseOperation alloc] initWithFeedURL:feedURL delegate:self];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [self.operationQueue addOperation:parseOperation];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TWIncident *incident = self.incidents[indexPath.row];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[incident weblink]]];
}

- (void)handledLoadedIncidents: (NSArray *)loadedIncidents {
    self.incidents = [NSMutableArray array];
    if([loadedIncidents count] > 0) {
        [self.incidents addObjectsFromArray:loadedIncidents];
    }
    
    if(self.myLocation)
    {
        for (TWIncident *incident in self.incidents)
        {
            CLLocationDistance distance = [incident.location distanceFromLocation:self.myLocation];
            incident.distanceFromUser = distance;
        }

        [self.incidents sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            TWIncident *a = obj1;
            TWIncident *b = obj2;
            if(a.distanceFromUser < b.distanceFromUser)
            {
                return NSOrderedAscending;
            }
            else
            {
                return NSOrderedDescending;
            }
        }];
        
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

-(void)incidentsParseOperation:(TWIncidentParseOperation *)parseOperation
                      finished:(NSArray *)parsedIncidents {
    [self performSelectorOnMainThread:@selector(handledLoadedIncidents:) withObject:parsedIncidents waitUntilDone:NO];
    self.operationQueue = nil;
}

@end
