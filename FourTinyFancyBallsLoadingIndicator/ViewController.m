//
//  ViewController.m
//  FourTinyFancyBallsLoadingIndicator
//
//  Created by Luka on 2017/8/12.
//  Copyright © 2017年 Luka. All rights reserved.
//

#import "ViewController.h"
#import "LKAFTFBLoadingIndicatorView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet LKAFTFBLoadingIndicatorView *smallIndicator;
@property (weak, nonatomic) IBOutlet LKAFTFBLoadingIndicatorView *indicator;
@end

@implementation ViewController

- (IBAction)start:(UIButton *)sender {
    [self.smallIndicator startAnimating];
    [self.indicator startAnimating];
}

- (IBAction)stop:(UIButton *)sender {
    [self.smallIndicator stopAnimating];
    [self.indicator stopAnimating];
}

@end
