//
//  TDDCounterTests.m
//  TDDCounterTests
//
//  Created by Jeff Kempista on 3/3/14.
//  Copyright (c) 2014 Jeff Kempista. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import "Counter.h"
#import "JKCounterViewController.h"

SPEC_BEGIN(JKCounterViewControllerSpec)

describe(@"JKCounterViewController", ^{
    
    __block JKCounterViewController *sut;
    __block Counter *mockCounter;
    
    beforeEach(^{
        mockCounter = [Counter mock];
        sut = [[JKCounterViewController alloc] initWithCounter:mockCounter];
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
            // given
            [[mockCounter should] receive:@selector(count) andReturn:theValue(42)];
            
            // when
            [sut viewWillAppear:NO];
            
            // then
            [[sut.countLabel.text should] equal:@"42"];
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
    
    context(@"modelChangeNotification", ^{
        it(@"should update count label", ^{
            // given
            [[mockCounter should] receive:@selector(count) andReturn:theValue(2)];
            
            // when
            [[NSNotificationCenter defaultCenter] postNotificationName:CounterModelChanged object:mockCounter];
            
            // then
            [[sut.countLabel.text should] equal:@"2"];
        });
    });
    
    context(@"modelChangeNotification from different model", ^{
        it(@"should not update count label", ^{
            // given
            Counter *differentCounter = [[Counter alloc] init];
            differentCounter.count = 2;
            
            // when
            [[NSNotificationCenter defaultCenter] postNotificationName:CounterModelChanged object:differentCounter];
            
            // then
            [[sut.countLabel.text should] equal:@"0"];
        });
    });
    
    context(@"incrementCount", ^{
        it(@"should ask counter to increment", ^{
            [[mockCounter should] receive:@selector(increment)];
            
            // when
            [sut incrementCount:nil];
        });
    });
    
    context(@"decrementCount", ^{
        it(@"should ask counter to decrement", ^{
            [[mockCounter should] receive:@selector(decrement)];
            
            // when
            [sut decrementCount:nil];
        });
    });
    
});

SPEC_END