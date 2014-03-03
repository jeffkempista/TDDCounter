//
//  TDDCounterTests.m
//  TDDCounterTests
//
//  Created by Jeff Kempista on 3/3/14.
//  Copyright (c) 2014 Jeff Kempista. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import "JKCounterViewController.h"

SPEC_BEGIN(JKCounterViewControllerSpec)

describe(@"JKCounterViewController", ^{
    
    __block JKCounterViewController *sut;
    
    beforeEach(^{
        sut = [[JKCounterViewController alloc] init];
        [sut view];
    });
    
    afterEach(^{
        sut = nil;
    });
    
    context(@"count label outlet", ^{
        it(@"should be connected", ^{
            [[sut.countLabel shouldNot] equal:nil];
        });
        
        it(@"initial text should equal zero", ^{
            [[sut.countLabel.text should] equal:@"0"];
        });
    });
    
    context(@"plus button outlet", ^{
        it(@"should be connected", ^{
            [[sut.plusButton shouldNot] equal:nil];
        });
        
        it(@"initial title should equal +1", ^{
            [[sut.plusButton.titleLabel.text should] equal:@"+1"];
        });
        
        it(@"should trigger only the correct action", ^{
            [[[sut.plusButton actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside] should] equal:@[@"incrementCount:"]];
        });
    });
    
    context(@"incrementCount once", ^{
        it(@"should add one to count label", ^{
            // when
            [sut incrementCount:nil];
            
            // then
            [[sut.countLabel.text should] equal:@"1"];
        });
    });
    
    context(@"incrementCount twice", ^{
        it(@"should add two to count label", ^{
            // when
            [sut incrementCount:nil];
            [sut incrementCount:nil];
            
            // then
            [[sut.countLabel.text should] equal:@"2"];
        });
    });
    
    context(@"minus button outlet", ^{
        it(@"should be connected", ^{
            [[sut.minusButton shouldNot] equal:nil];
        });
        
        it(@"initial title should equal -1", ^{
            [[sut.minusButton.titleLabel.text should] equal:@"-1"];
        });
        
        it(@"should trigger only the correct action", ^{
            [[[sut.minusButton actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside] should] equal:@[@"decrementCount:"]];
        });
    });
    
    context(@"decrementCount once", ^{
        it(@"should subtract one to count label", ^{
            // when
            [sut decrementCount:nil];
            
            // then
            [[sut.countLabel.text should] equal:@"-1"];
        });
    });
    
    context(@"decrementCount twice", ^{
        
        it(@"should subtract two to count label", ^{
            // when
            [sut decrementCount:nil];
            [sut decrementCount:nil];
            
            // then
            [[sut.countLabel.text should] equal:@"-2"];
        });
    });
    
});

SPEC_END