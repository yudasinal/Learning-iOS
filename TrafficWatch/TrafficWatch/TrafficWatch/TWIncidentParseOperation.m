//
//  TWIncidentParser.m
//  TrafficWatch
//
//  Created by Liubou Yudasina on 2014-04-04.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import "TWIncident.h"
#import "TWIncidentParseOperation.h"
#import "NSURL+QSParameters.h"

@interface TWIncidentParseOperation()

@property (strong, nonatomic) TWIncident *currentIncidentObject;
@property (strong, nonatomic) NSMutableString *currentOfCurrentIncidentProperty;
@property (strong, nonatomic) NSURL *feedURL;
@property (strong, nonatomic) NSMutableArray *parsedIncidentObjects;
@end

@implementation TWIncidentParseOperation

- (id)initWithFeedURL:(NSURL *)url delegate:(id<TWIncidentsParserDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.feedURL = url;
        self.parsedIncidentObjects = [NSMutableArray array];
        self.delegate = delegate;
    }
    return self;
}


- (void)main {
    
    self.parsedIncidentObjects = [NSMutableArray array];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:self.feedURL];
    
    if(parser) {
    
        parser.delegate = self;
        parser.shouldProcessNamespaces = NO;
        parser.shouldReportNamespacePrefixes = NO;
        parser.shouldResolveExternalEntities = NO;
    
        [parser parse];
    }
    else
    {
        NSLog(@"asd");
    }
    
    if(![self isCancelled]) {
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(incidentsParseOperation:finished:)]) {
            
            [self.delegate incidentsParseOperation:self finished:self.parsedIncidentObjects];
            
        }
    }
}

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict
{
    
    if(qName) {
        elementName = qName;
    }
    
    if([elementName isEqualToString:@"entry"]) {
        self.currentIncidentObject = [[TWIncident alloc] init];
        
        return;
    }
    
    if([elementName isEqualToString:@"id"]) {
        NSString *relAtt = attributeDict[@"rel"];
        
        if([relAtt isEqualToString:@"alternate"]) {
            
            NSString *link = attributeDict[@"href"];
            self.currentIncidentObject.weblink = link;
            
            NSURL *linkURL = [NSURL URLWithString:link];
            NSDictionary *dict = [linkURL parameterDictionary];
            
            CLLocationCoordinate2D location;
            NSString *lat = dict[@"lat"];
            NSString *lon = dict[@"lon"];
            if([lon isEqual:[NSNull null]] == NO)
            {
                location.longitude = [lon doubleValue];
                location.latitude = [lat doubleValue];
                
                self.currentIncidentObject.location = [[CLLocation alloc] initWithLatitude:location.latitude
                                                                                 longitude:location.longitude];

            }
            else{
                NSLog(@"hree");
            }
            

            
            
        }
    }
    
    else if([elementName isEqualToString:@"summary"]) {
        self.currentOfCurrentIncidentProperty = [NSMutableString string];
        
    }
    
    else if ([elementName isEqualToString:@"title"]) {
        self.currentOfCurrentIncidentProperty = [NSMutableString string];
    }
    
    else{
        self.currentOfCurrentIncidentProperty = nil;
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(self.currentOfCurrentIncidentProperty) {
        [self.currentOfCurrentIncidentProperty appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if(qName) {
        elementName = qName;
    }
    
    if([elementName isEqualToString:@"entry"]) {
        
        [self.parsedIncidentObjects addObject:self.currentIncidentObject];
        self.currentIncidentObject = nil;
    }
    
    if([elementName isEqualToString:@"title"]) {
        self.currentIncidentObject.title = self.currentOfCurrentIncidentProperty;
    }
    
    else if([elementName isEqualToString:@"summary"]) {
        self.currentIncidentObject.summary = self.currentOfCurrentIncidentProperty;
    }
}

@end
