//
//  ViewController.h
//  TrafficWatch
//
//  Created by Liubou Yudasina on 2014-04-04.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWIncidentsParserDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TWIncidentsParserDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@end
