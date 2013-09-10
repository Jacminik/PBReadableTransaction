//
//  CALayer+ReadableAnimation.h
//
//  Created by Masahiro Katsumata on 2013/09/02.
//  Copyright (c) 2013 +Beans. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>


@interface CALayer (ReadableAnimation)

@property (nonatomic, assign) CGFloat fade;     // Opacity.
@property (nonatomic, assign) CGFloat rotate;   // Degrees.(CGAffineTransformRotation)
@property (nonatomic, assign) CGFloat scale;    // Scale.(CGAffineTransformScale)
@property (nonatomic, assign) UIOffset move;    // Move.(CGAffineTransformTranslate)

// ex.
// layer.basicAnims = @{kFade: @0.0f, kRotate: @90.0f, kScale: @1.2f};
// layer.basicAnims = @{kFade: @0.4f, kMove: moveOffset(10.0f, -15.0f)};
@property (strong, nonatomic) NSDictionary *basicAnims;

- (void)resetBasicAnims;

@end

// Basic Animation Keys
static NSString * const kFade   = @"fade";
static NSString * const kRotate = @"rotate";
static NSString * const kScale  = @"scale";
static NSString * const kMove   = @"move";

NSValue *moveOffset(CGFloat x, CGFloat y);



@interface CAShapeLayer (ReadableAnimation)

@property (nonatomic, assign) CGFloat drawOutline;  // StrokeEnd.

@end

static NSString * const kDrawOutline  = @"drawOutline";

