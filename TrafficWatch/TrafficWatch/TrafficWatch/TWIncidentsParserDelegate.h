//
//  TWIncidentsParserDelegate.h
//  TrafficWatch
//
//  Created by Liubou Yudasina on 2014-04-04.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TWIncident, TWIncidentParseOperation;

@protocol TWIncidentsParserDelegate <NSObject>

@optional
- (void)incidentsParseOperation:(TWIncidentParseOperation *)parseOperation finished:(NSArray *)parsedIncidents;

@end
