//
//  RKGHDetailViewController.h
//  RESTkitGithub
//
//  Created by Andreas Eichner on 21/03/14.
//
//

#import <UIKit/UIKit.h>
#import "Gist.h"

@interface RKGHDetailViewController : UIViewController

@property (nonatomic, strong, readwrite) Gist *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *descriptionTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *gistIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *JSONUrlLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
