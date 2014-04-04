//
//  ViewController.m
//  StopWatch
//
//  Created by Liubou Yudasina on 2014-04-02.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *inputTime;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _inputTime.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self startThread];

}


- (void) startThread {
    [self performSelector:@selector(count) withObject:nil afterDelay:1];
}

-(void)count {
    if(_timeUser <= 0) {
        return;
    }
    
    _timeUser--;
    [self performSelectorOnMainThread:@selector(updateTime) withObject:nil waitUntilDone:NO];
    [self startThread];
}

- (IBAction)stop:(id)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
}

- (void)updateTime {
    _time.text = [NSString stringWithFormat:@"%02d : %02d", _timeUser/60, _timeUser%60];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    _timeUser = [_inputTime.text integerValue];
    [_inputTime resignFirstResponder];
    
    [self updateTime];
    
    return YES;
}


@end
