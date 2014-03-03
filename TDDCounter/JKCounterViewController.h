//
//  JKCounterViewController.h
//  TDDCounter
//
//  Created by Jeff Kempista on 3/3/14.
//  Copyright (c) 2014 Jeff Kempista. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKCounterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;

- (IBAction)incrementCount:(id)sender;
- (IBAction)decrementCount:(id)sender;

@end
