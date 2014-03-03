//
//  Counter.m
//  TDDCounter
//
//  Created by Jeff Kempista on 3/3/14.
//  Copyright (c) 2014 Jeff Kempista. All rights reserved.
//

#import "Counter.h"

NSString * const CounterModelChanged = @"CounterModelChanged";

@implementation Counter

- (void)increment
{
    self.count += 1;
    [self postModelChangedNotification];
}

- (void)decrement
{
    self.count -= 1;
    [self postModelChangedNotification];
}

- (void)postModelChangedNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CounterModelChanged object:self];
}

@end
