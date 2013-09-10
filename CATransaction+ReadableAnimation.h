//
//  CATransaction+ReadableAnimationn.h
//  DrawAnim
//
//  Created by Masahiro Katsumata on 2013/09/03.
//  Copyright (c) 2013年 Masahiro Katsumata. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef enum PBAnimationCurveType : NSUInteger {
    PBCurveTypeDefault,
    PBCurveTypeLiner,
    PBCurveTypeEaseIn,
    PBCurveTypeEaseOut,
    PBCurveTypeEaseInOut,
} PBAnimationCurveType;

@interface CATransaction (ReadableAnimation)


+ (void)animateWithDuration:(CFTimeInterval)duration
         animationCurveType:(PBAnimationCurveType)type
                 animations:(void (^)(void))animations
                 completion:(void (^)(void))completion;

+ (void)nonAnimateBlock:(void (^)(void))actions;

@end
