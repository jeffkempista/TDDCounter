//
//  JKCounterViewController.m
//  TDDCounter
//
//  Created by Jeff Kempista on 3/3/14.
//  Copyright (c) 2014 Jeff Kempista. All rights reserved.
//

#import "JKCounterViewController.h"

#import "Counter.h"

@interface JKCounterViewController ()

@property (strong, nonatomic) Counter *counter;

@end

@implementation JKCounterViewController

- (instancetype)initWithCounter:(Counter *)counter
{
    self = [super init];
    if (self) {
        _counter = counter;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modelChanged:) name:CounterModelChanged object:counter];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self modelChanged:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)incrementCount:(id)sender
{
    [self.counter increment];
}

- (IBAction)decrementCount:(id)sender
{
    [self.counter decrement];
}

- (void)modelChanged:(NSNotification *)notification
{
    self.countLabel.text = [NSString stringWithFormat:@"%d", self.counter.count];
}

@end
