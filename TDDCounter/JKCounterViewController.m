//
//  JKCounterViewController.m
//  TDDCounter
//
//  Created by Jeff Kempista on 3/3/14.
//  Copyright (c) 2014 Jeff Kempista. All rights reserved.
//

#import "JKCounterViewController.h"

@interface JKCounterViewController ()

@property (nonatomic) NSInteger count;

@end

@implementation JKCounterViewController

- (IBAction)incrementCount:(id)sender
{
    ++self.count;
    [self updateCountLabel];
}

- (IBAction)decrementCount:(id)sender
{
    --self.count;
    [self updateCountLabel];
}

- (void)updateCountLabel
{
    self.countLabel.text = [NSString stringWithFormat:@"%d", self.count];
}

@end
