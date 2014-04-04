//
//  RKGHGistManager.m
//  RESTkitGithub
//
//  Created by Andreas Eichner on 30/03/14.
//
//

#import <RestKit/RestKit.h>

#import "RKGHGistManager.h"
#import "Gist.h"
#import "User.h"
#import "File.h"


@interface RKGHGistManager ()

@property (nonatomic, strong, readwrite) RKObjectManager *objectManager;

@end



@implementation RKGHGistManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static id sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}


- (void)setup
{
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    
    // TODO: 1) Create the baseUrl from the following string: @"https://api.github.com"
    
    NSURL *baseURL = [[NSURL alloc] initWithString:@"https://api.github.com"];

    
    // TODO: 2) Instanciate a RKObjectManager with the baseUrl above and then assign it to the property objectManager
    
    _objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    // In order to fetch all the Gists from Github we need to map the attributes in the receiving JSON to the properties of our Model. (3, 4 and 5)
    // TODO: 3) Create a RKObjectMapping instance for the class Gist
    
    RKObjectMapping *gistsMapping = [RKObjectMapping mappingForClass:[Gist class]];
    
    
    // TODO: 4) Create a NSDictionary which maps the keys of the JSON Object to the ones in our Model (the class Gist in the Models-Group in the Navigationsidebar)
    //          The JSON object can be observed here: https://api.github.com/gists/public
    
    
    NSDictionary *gistsDict = @{@"id" : @"gistID",
                                @"public" : @"publicAccessable",
                                @"url" : @"jsonURL",
                                @"description" : @"descriptionText",
                                @"created_at" : @"createdAt"};
    
    
    // TODO: 5) Now add a new attribute mapping by using the NSDictionary to the RKObjectMapping
    
    [gistsMapping addAttributeMappingsFromDictionary:gistsDict];
    
    // TODO: 6) Create a RKResponseDescriptor for GETting data
    //          As arguments use RKObjectMapping, @"/gists/public" and the the statuscode RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:gistsMapping method:RKRequestMethodGET pathPattern:@"/gists/public" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    
    
    // TODO: 7) Finally add the RKResponseDescriptor to the objectManager
    
    
    [self.objectManager addResponseDescriptor:responseDescriptor];
}

// Fyi this method always will be called if the TableView will be refreshed. (For example by pulling down the TableView)
- (void)fetchGistsWithCompletionHandler:(void (^)(NSArray *gists, NSError* fetchGistsError))completionHandler
{
    // TODO: 8) Fetch the Gistlist by calling -getObjectsAtPath:parameters:success:failure: on the objectManager with the path @"gists/public"
    //          In the completionHandlers of the getObjects method we need to call the appropriate completionHandler of the fetchGistsMethod:
    //          For the success case we want to do this with the recieved mappingResult as array and no error.
    //          For the failure case we want to do this with no array and the given error.
    
    [self.objectManager getObjectsAtPath:@"gists/public" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        completionHandler(mappingResult.array, nil);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        completionHandler(nil, error);
    }];
    
    
    
    
}

@end
