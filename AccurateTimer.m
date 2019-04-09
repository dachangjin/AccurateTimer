//
//  AccurateTimer.m
//  Accurate Timer
//
//  Created by wangwei on 2018/3/9.
//  Copyright © 2018 WW. All rights reserved.
//

#import "AccurateTimer.h"

@interface AccurateTimer ()
@property(nonatomic ,strong)dispatch_source_t timer;
@end

@implementation AccurateTimer

- (id)initWithBlock:(void (^)(void))block delay:(uint64_t)delay timeInterval:(uint64_t)timeInterval repeat:(BOOL)repeat async:(BOOL)async
{
    if (self = [super init]) {
        dispatch_queue_t queue = async ? dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) : dispatch_get_main_queue();
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(timer, delay * NSEC_PER_SEC, timeInterval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            if(block){
                block();
            }
            if(!repeat){
                dispatch_source_cancel(timer);
            }
        });
        self.timer = timer;
    }
    return self;
}

+ (AccurateTimer *)taskWithBlock:(void (^)(void))block
                           delay:(uint64_t)delay
                    timeInterval:(uint64_t)timeInterval
                          repeat:(BOOL)repeat
                           async:(BOOL)async {
    
    AccurateTimer *accurateTimer = [[AccurateTimer alloc] initWithBlock:block
                                                                  delay:delay
                                                           timeInterval:timeInterval
                                                                 repeat:repeat
                                                                  async:async];
    dispatch_resume(accurateTimer.timer);
    return accurateTimer;
}

- (void)start
{
    if(!dispatch_source_testcancel(_timer)){
        dispatch_resume(_timer);
    }
}

- (void)cancel {
    dispatch_source_cancel(_timer);
}

- (void)dealloc
{
    dispatch_source_cancel(_timer);
}

@end
