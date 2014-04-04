//
//  DetailViewController.h
//  AlbumApp
//
//  Created by Liubou Yudasina on 2014-04-03.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
