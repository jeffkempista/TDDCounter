//
//  TDDCounterTests.m
//  TDDCounterTests
//
//  Created by Jeff Kempista on 3/3/14.
//  Copyright (c) 2014 Jeff Kempista. All rights reserved.
//

#import "Counter.h"
#import "JKCounterViewController.h"

#import <Kiwi/Kiwi.h>

SPEC_BEGIN(JKCounterViewControllerSpec)

describe(@"JKCounterViewController", ^{
    
    __block JKCounterViewController *sut;
    __block Counter *mockCounter;
    
    beforeEach(^{
        mockCounter = [Counter mock];
        [[mockCounter stubAndReturn:@5] valueForKeyPath:@"count"];
        
        sut = [[JKCounterViewController alloc] initWithCounter:mockCounter];
        [sut view];
    });
    
    afterEach(^{
        sut = nil;
    });
    
    context(@"outlets", ^{
        
        context(@"count label outlet", ^{
            it(@"should be connected", ^{
                [[sut.countLabel shouldNot] equal:nil];
            });
            
            it(@"initial text should match counter count value", ^{
                // then
                [[sut.countLabel.text should] equal:@"5"];
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
                // then
                [[mockCounter should] receive:@selector(increment)];
                
                // when
                [sut.plusButton sendActionsForControlEvents:UIControlEventTouchUpInside];
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
                // then
                [[mockCounter should] receive:@selector(decrement)];
                
                // when
                [sut.minusButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            });
        });

    });
    
});

SPEC_END