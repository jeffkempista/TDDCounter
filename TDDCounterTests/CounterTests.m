//
//  CounterTests.m
//  TDDCounter
//
//  Created by Jeff Kempista on 3/3/14.
//  Copyright (c) 2014 Jeff Kempista. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import "Counter.h"

@interface CounterObserver : NSObject

@property (assign, nonatomic) NSInteger modelChangedCount;
@property (assign, nonatomic) NSInteger modelChangedValue;

@end

@implementation CounterObserver

- (void)counterModelChanged:(NSNotification *)notification
{
    ++self.modelChangedCount;
    Counter *counter = (Counter *)notification.object;
    self.modelChangedValue = counter.count;
}

@end

SPEC_BEGIN(CounterSpec)

describe(@"Counter", ^{
    __block Counter *sut;
    __block CounterObserver *counterObserver;
    
    beforeEach(^{
        sut = [[Counter alloc] init];
        counterObserver = [[CounterObserver alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:counterObserver selector:@selector(counterModelChanged:) name:CounterModelChanged object:sut];
    });
    
    afterEach(^{
        [[NSNotificationCenter defaultCenter] removeObserver:counterObserver];
        counterObserver = nil;
        sut = nil;
    });
    
    context(@"increment", ^{
        it(@"one should yeld two", ^{
            // given
            sut.count = 1;
            
            // when
            [sut increment];
            
            // then
            [[@(sut.count) should] equal:@2];
        });
        
        it(@"two should yeld three", ^{
            // given
            sut.count = 2;
            
            // when
            [sut increment];
            
            // then
            [[@(sut.count) should] equal:@3];
        });
        
        it(@"should post model changed notification", ^{
            [sut increment];
            
            [[@(counterObserver.modelChangedCount) should] equal:@1];
        });
        
        it(@"should post model changed notification with new count", ^{
            // given
            sut.count = 1;
            
            // when
            [sut increment];
            
            // then
            [[@(counterObserver.modelChangedValue) should] equal:@(2)];
        });
    });
    
    context(@"decrement", ^{
        it(@"one should yeld zero", ^{
            // given
            sut.count = 1;
            
            // when
            [sut decrement];
            
            // then
            [[@(sut.count) should] equal:@0];
        });
        
        it(@"two should yeld one", ^{
            // given
            sut.count = 2;
            
            // when
            [sut decrement];
            
            // then
            [[@(sut.count) should] equal:@1];
        });
        
        it(@"should post model changed notification", ^{
            [sut decrement];
            
            [[@(counterObserver.modelChangedCount) should] equal:@1];
        });
        
        it(@"should post model changed notification with new count", ^{
            // given
            sut.count = 2;
            
            // when
            [sut decrement];
            
            // then
            [[@(counterObserver.modelChangedValue) should] equal:@(1)];
        });
    });
    
});

SPEC_END