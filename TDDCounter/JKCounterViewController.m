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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup RAC Bindings
    
    RAC(self.countLabel, text) = [RACSignal combineLatest:@[RACObserve(self.counter, count)]
                                                   reduce:^(NSNumber *number) {
                                                       return [number stringValue];
                                                   }];

    @weakify(self);
    [[self.plusButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
        @strongify(self);
        [self.counter increment];
    }];

    [[self.minusButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
        @strongify(self);
        [self.counter decrement];
    }];
}

@end
