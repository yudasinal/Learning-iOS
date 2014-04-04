//
//  RKGHDetailViewController.m
//  RESTkitGithub
//
//  Created by Andreas Eichner on 21/03/14.
//
//

#import "RKGHDetailViewController.h"

@interface RKGHDetailViewController ()
- (void)configureView;
@end

@implementation RKGHDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
        
        [self configureView];
    }
}

- (void)configureView
{
    if (self.detailItem)
    {
        self.descriptionTextLabel.text = self.detailItem.descriptionText;
        self.gistIDLabel.text = [self.detailItem.gistID stringValue];

        self.createdAtLabel.text = [[self.detailItem valueForKey:@"createdAt"] description];
        self.JSONUrlLabel.text = [[self.detailItem valueForKey:@"jsonURL"] description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
