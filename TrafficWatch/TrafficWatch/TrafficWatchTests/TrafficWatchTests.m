//
//  TrafficWatchTests.m
//  TrafficWatchTests
//
//  Created by Liubou Yudasina on 2014-04-04.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TWIncident.h"

@interface TrafficWatchTests : XCTestCase

@end

@implementation TrafficWatchTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIncidentInit
{
    NSString *title = @"incident";
    NSString *weblink = @"http://test";
    NSString *summary = @"summary";
    
    TWIncident *incident = [[TWIncident alloc] initWithTitle:title withSummary:summary withWeblink:weblink];
   
    XCTAssertTrue([incident.title isEqualToString:title], @"title is not correctly initialized");
    XCTAssertTrue([incident.weblink isEqualToString:weblink], @"weblink is not correctly initialized");
    XCTAssertTrue([incident.summary isEqualToString:summary], @"summary is not correctly initialized");
}

- (void)testIncidentDescription
{
    TWIncident *incident = [[TWIncident alloc] init];
    NSString *description = [incident description];
    
    XCTAssertTrue([description compare:@"< %@: title = %@, weblink = %@, summary = %@ >"], @"class is not correct");
    
}

@end
