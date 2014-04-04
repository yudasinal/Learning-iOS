//
//  DetailViewController.m
//  AlbumApp
//
//  Created by Liubou Yudasina on 2014-04-03.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import "DetailViewController.h"
#import "Album.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *yearField;
@property (weak, nonatomic) IBOutlet UITextField *genreField;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *artistField;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        Album *album = (Album *)_detailItem;
        self.artistField.text = [album artist];
        self.genreField.text = [album genre];
        self.yearField.text = [album year];
        self.titleField.text = [album title];
        
        self.detailDescriptionLabel.text = [self.detailItem description];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
