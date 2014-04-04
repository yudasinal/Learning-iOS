//
//  TWIncident.h
//  TrafficWatch
//
//  Created by Liubou Yudasina on 2014-04-04.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface TWIncident : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *weblink;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) CLLocation *location;
@property (assign, nonatomic) CLLocationDistance distanceFromUser;

-(instancetype)initWithTitle:(NSString *)title
                 summary:(NSString *)summary
                 weblink:(NSString *)weblink;


@end
