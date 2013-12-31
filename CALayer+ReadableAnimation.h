//
//  CALayer+ReadableAnimation.h
//
//  Created by Masahiro Katsumata on 2013/09/02.
//  Copyright (c) 2013 +Beans. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

typedef NS_OPTIONS(NSUInteger, CAActionKey) {
    CAActionNon             = 0,
    CAActionOnOrderIn       = 1 << 0,
    CAActionOnOrderOut      = 1 << 1,
    CAActionSublayers       = 1 << 2,
    CAActionContents        = 1 << 3,
    CAActionPosition        = 1 << 4,
    CAActionBounds          = 1 << 5,
    CAActionTransform       = 1 << 6,
    CAActionStrokeStart     = 1 << 7,   // use CAShapeLayer.
    CAActionStrokeEnd       = 1 << 8,   // use CAShapeLayer.
    CAActionAll             = CAActionOnOrderIn | CAActionOnOrderOut | CAActionSublayers | CAActionContents | CAActionPosition | CAActionBounds | CAActionTransform | CAActionStrokeStart | CAActionStrokeEnd
};

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

@property (nonatomic, assign) CAActionKey disabledActionKey;    // Set non animate action keys.

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

