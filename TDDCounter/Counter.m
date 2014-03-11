//
//  Counter.m
//  TDDCounter
//
//  Created by Jeff Kempista on 3/3/14.
//  Copyright (c) 2014 Jeff Kempista. All rights reserved.
//

#import "Counter.h"

@implementation Counter

- (void)increment
{
    ++self.count;
}

- (void)decrement
{
    --self.count;
}

@end
