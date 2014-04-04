//
//  TWIncidentParser.h
//  TrafficWatch
//
//  Created by Liubou Yudasina on 2014-04-04.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWIncidentsParserDelegate.h"

@interface TWIncidentParseOperation : NSOperation <NSXMLParserDelegate>

@property (nonatomic, weak) id<TWIncidentsParserDelegate> delegate;

- (id)initWithFeedURL:(NSURL *)url delegate:(id <TWIncidentsParserDelegate>)delegate;

@end
