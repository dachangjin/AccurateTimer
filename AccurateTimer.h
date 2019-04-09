//
//  AccurateTimer.h
//  Accurate Timer
//
//  Created by wangwei on 2018/3/9.
//  Copyright © 2018 WW. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AccurateTimer : NSObject

+ (AccurateTimer *)taskWithBlock:(void(^)(void))block
                           delay:(uint64_t)delay
                    timeInterval:(uint64_t)timeInterval
                          repeat:(BOOL)repeat
                           async:(BOOL)async;
- (id)initWithBlock:(void(^)(void))block
              delay:(uint64_t)delay
       timeInterval:(uint64_t)timeInterval
             repeat:(BOOL)repeat
              async:(BOOL)async;
- (void)start;
- (void)cancel;
@end

