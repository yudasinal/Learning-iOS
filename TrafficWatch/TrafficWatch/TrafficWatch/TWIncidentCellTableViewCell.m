//
//  TWIncidentCellTableViewCell.m
//  TrafficWatch
//
//  Created by Liubou Yudasina on 2014-04-04.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import "TWIncidentCellTableViewCell.h"

@implementation TWIncidentCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect contentRect = self.contentView.bounds;
    
    CGSize sizeOfString = [self.textLabel.text sizeWithFont:self.textLabel.font];
    CGFloat positionX = 8.0f;
    CGFloat positionY = 8.0f;
    CGFloat width = contentRect.size.width - 2.0f*8.0f;
    CGFloat height = sizeOfString.height;
    
    CGRect textLabelFrame = CGRectMake(positionX, positionY, width, height);
    self.textLabel.frame = textLabelFrame;
    
}

@end
