//
//  CounterTests.m
//  TDDCounter
//
//  Created by Jeff Kempista on 3/3/14.
//  Copyright (c) 2014 Jeff Kempista. All rights reserved.
//

#import "Counter.h"

#import <Kiwi/Kiwi.h>

@interface KVOObserver : NSObject

@property (strong, nonatomic) NSString *changedKeyPath;

@end

@implementation KVOObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setChangedKeyPath:keyPath];
}

@end

SPEC_BEGIN(CounterSpec)

describe(@"Counter", ^{
    __block Counter *sut;
    __block KVOObserver *fakeObserver;
    
    beforeEach(^{
        sut = [[Counter alloc] init];
        sut.count = 1;
        
        fakeObserver = [[KVOObserver alloc] init];
        [sut addObserver:fakeObserver forKeyPath:@"count" options:NSKeyValueObservingOptionNew context:nil];
    });
    
    afterEach(^{
        [sut removeObserver:fakeObserver forKeyPath:@"count"];
        fakeObserver = nil;
        
        sut = nil;
    });
    
    context(@"increment", ^{
        
        it(@"should trigger KVO observer", ^{
            // when
            [sut increment];
            
            // then
            [[[fakeObserver changedKeyPath] should] equal:@"count"];
        });
        
        context(@"once", ^{
            it(@"should yeld two", ^{
                // when
                [sut increment];
                
                // then
                [[@(sut.count) should] equal:@2];
            });
        });

        context(@"twice", ^{
            it(@"should yeld three", ^{
                // when
                [sut increment];
                [sut increment];
                
                // then
                [[@(sut.count) should] equal:@3];
            });
        });
    });
    
    context(@"decrement", ^{
        
        it(@"should trigger KVO observer", ^{
            // when
            [sut decrement];
            
            // then
            [[[fakeObserver changedKeyPath] should] equal:@"count"];
        });
        
        context(@"once", ^{
            it(@"should yeld zero", ^{
                // when
                [sut decrement];
                
                // then
                [[@(sut.count) should] equal:@0];
            });
        });
        
        context(@"twice", ^{
            it(@"should yeld negative one", ^{
                // when
                [sut decrement];
                [sut decrement];
                
                // then
                [[@(sut.count) should] equal:@-1];
            });
        });
    });
    
});

SPEC_END