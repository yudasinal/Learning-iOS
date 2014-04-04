//
//  MasterViewController.m
//  AlbumApp
//
//  Created by Liubou Yudasina on 2014-04-03.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "Album.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    Album* a1 = [[Album alloc] initWithTitle:@"Frozen" withArtist:@"Various Artists" withYear:@"2013" withGenre:@"Soundtrack"];
    Album* a2 = [[Album alloc] initWithTitle:@"Shakira" withArtist:@"Shakira" withYear:@"2009" withGenre:@"pop"];
    Album* a3 = [[Album alloc] initWithTitle:@"Bad" withArtist:@"Michael Jackson" withYear:@"1982" withGenre:@"pop"];
    Album* a4 = [[Album alloc] initWithTitle:@"Toxic" withArtist:@"Britney Spirs" withYear:@"2003" withGenre:@"pop"];
    Album* a5 = [[Album alloc] initWithTitle:@"Like a virgin" withArtist:@"Madonna" withYear:@"1998" withGenre:@"pop"];
    Album* a6 = [[Album alloc] initWithTitle:@"Lion King" withArtist:@"Various Artists" withYear:@"1998" withGenre:@"Soundtrack"];
    
    _objects = [NSMutableArray arrayWithObjects:a1, a2, a3, a4, a5, a6, nil];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Album *object = _objects[indexPath.row];
    cell.textLabel.text = [object title];
    cell.detailTextLabel.text = [object artist];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
