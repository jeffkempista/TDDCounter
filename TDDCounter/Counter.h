//
//  Counter.h
//  TDDCounter
//
//  Created by Jeff Kempista on 3/3/14.
//  Copyright (c) 2014 Jeff Kempista. All rights reserved.
//

@interface Counter : NSObject

@property (assign, nonatomic) NSInteger count;

- (void)increment;
- (void)decrement;

@end
