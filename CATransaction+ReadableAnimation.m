//
//  CATransaction+ReadableAnimation.m
//
//  Created by Masahiro Katsumata on 2013/09/03.
//  Copyright (c) 2013 Masahiro Katsumata. All rights reserved.
//

#import "CATransaction+ReadableAnimation.h"

@implementation CATransaction (ReadableAnimation)

+ (void)animateWithDuration:(CFTimeInterval)duration
         animationCurveType:(PBAnimationCurveType)type
                 animations:(void (^)(void))animations
                 completion:(void (^)(void))completion
{
    NSString *funcName = nil;
    switch (type) {
        case PBCurveTypeDefault:
            funcName = kCAMediaTimingFunctionDefault;
            break;
        case PBCurveTypeLiner:
            funcName = kCAMediaTimingFunctionLinear;
            break;
        case PBCurveTypeEaseIn:
            funcName = kCAMediaTimingFunctionEaseIn;
            break;
        case PBCurveTypeEaseOut:
            funcName = kCAMediaTimingFunctionEaseOut;
            break;
        case PBCurveTypeEaseInOut:
            funcName = kCAMediaTimingFunctionEaseInEaseOut;
            break;
        default:
            break;
    }

    [CATransaction begin];
    [CATransaction setAnimationDuration:duration];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:funcName]];
    if (completion) {
        [CATransaction setCompletionBlock:completion];
    }
    animations();
    [CATransaction commit];
}

+ (void)nonAnimateBlock:(void (^)(void))actions
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    actions();
    [CATransaction commit];
    [CATransaction flush];

}

@end
