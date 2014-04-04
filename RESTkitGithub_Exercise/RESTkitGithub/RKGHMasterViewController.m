//
//  RKGHMasterViewController.m
//  RESTkitGithub
//
//  Created by Andreas Eichner on 21/03/14.
//
//

#import <RestKit/RestKit.h>

#import "RKGHMasterViewController.h"
#import "RKGHDetailViewController.h"
#import "Gist.h"
#import "RKGHGistManager.h"


@interface RKGHMasterViewController ()
@property (nonatomic, strong, readwrite) NSArray *gists;
@property (nonatomic, strong, readwrite) RKGHGistManager *gistManager;
@end

@implementation RKGHMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIRefreshControl *refreshControll = [[UIRefreshControl alloc] init];
    [refreshControll addTarget:self action:@selector(refresh)
              forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refreshControll;
    
    self.gistManager = [RKGHGistManager sharedManager];
    
    [self refresh];
}

- (void)refresh
{
    [self.refreshControl beginRefreshing];
    [self.gistManager fetchGistsWithCompletionHandler:^(NSArray *gists, NSError *fetchGistsError) {
        if(fetchGistsError == nil)
        {
            self.gists = gists;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
        else
        {
            [self.refreshControl endRefreshing];
            NSLog(@"%@",fetchGistsError);
        }
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.gists count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                            forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    
    Gist *selectedGist = self.gists[indexPath.row];
    cell.textLabel.text = selectedGist.descriptionText;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Gist* selectedGist = self.gists[indexPath.row];
        RKGHDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.detailItem = selectedGist;
    }
}

@end
