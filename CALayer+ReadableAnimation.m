//
//  CALayer+ReadableAnimation.m
//  AnimCategory
//
//  Created by Masahiro Katsumata on 2013/09/02.
//  Copyright (c) 2013年 +Beans. All rights reserved.
//

#import "CALayer+ReadableAnimation.h"


CGFloat radians(CGFloat degrees) {
	return (degrees * M_PI) / 180;
}

@implementation CALayer (ReadableAnimation)

- (CGFloat)basicAnimValueForKey:(NSString *)key
{
    if (self.basicAnims && [[self.basicAnims allKeys] containsObject:key]) {
        return [[self.basicAnims valueForKey:key] floatValue];
    }
    return 0.0f;
}

- (CGFloat)fade
{
    return [self basicAnimValueForKey:kFade];
}

- (void)setFade:(CGFloat)fade
{
    self.basicAnims = @{kFade: @(fade)};
    
}

- (CGFloat)rotate
{
    return [self basicAnimValueForKey:kRotate];
}

- (void)setRotate:(CGFloat)rotate
{
    self.basicAnims = @{kRotate: @(rotate)};
}

- (CGFloat)scale
{
    return [self basicAnimValueForKey:kScale];
}

- (void)setScale:(CGFloat)scale
{
    self.basicAnims = @{kScale: @(scale)};
}

- (UIOffset)move
{
    NSString *key = kMove;
    if (self.basicAnims && [[self.basicAnims allKeys] containsObject:key]) {
        return [[self.basicAnims valueForKey:key] UIOffsetValue];
    }
    return UIOffsetZero;
}

- (void)setMove:(UIOffset)move
{
    self.basicAnims = @{kMove: moveOffset(move.horizontal, move.vertical)};
}

- (NSDictionary *)basicAnims {
    return objc_getAssociatedObject(self, @selector(basicAnims));
}

- (void)setBasicAnims:(NSDictionary *)basicAnims
{
    objc_setAssociatedObject(self, @selector(basicAnims), basicAnims, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setAnimPropertys:basicAnims];
}

- (void)setAnimPropertys:(NSDictionary *)anims
{
    CGAffineTransform t = self.affineTransform;
    for (NSString *key in [anims keyEnumerator]) {
        
        if ([key isEqualToString:kMove]) {
            UIOffset offset = [[anims valueForKey:key] UIOffsetValue];
            t = CGAffineTransformTranslate(t, offset.horizontal, offset.vertical);
        }
        else
        {
            CGFloat value =  [[anims valueForKey:key] floatValue];
            
            if ([key isEqualToString:kFade]) {
                self.opacity = value;
            } else if ([key isEqualToString:kRotate]) {
                t = CGAffineTransformRotate(t, radians(value));
            } else if ([key isEqualToString:kScale]) {
                t = CGAffineTransformScale(t, value, value);
            }
        }
    }
    self.affineTransform = t;
}

- (void)resetBasicAnims
{
    self.basicAnims = @{kFade: @1.0f, kScale: @1.0f, kRotate: @0.0f};
    self.affineTransform = CGAffineTransformIdentity;
}

@end


NSValue *moveOffset(CGFloat x, CGFloat y) {
    return [NSValue valueWithUIOffset:UIOffsetMake(x, y)];
}


#pragma mark - CAShapeLayer

@implementation CAShapeLayer (ReadableAnimation)

- (CGFloat)drawOutline
{
    return self.strokeEnd;
}
- (void)setDrawOutline:(CGFloat)drawOutline
{
    self.strokeEnd = drawOutline;
}

- (NSDictionary *)basicAnims {
    return objc_getAssociatedObject(self, @selector(basicAnims));
}

- (void)setBasicAnims:(NSDictionary *)basicAnims
{
    objc_setAssociatedObject(self, @selector(basicAnims), basicAnims, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setAnimPropertys:basicAnims];
}

- (void)setAnimPropertys:(NSDictionary *)anims
{
    CGAffineTransform t = self.affineTransform;
    for (NSString *key in [anims keyEnumerator]) {
        
        CGFloat value =  [[anims valueForKey:key] floatValue];
        
        if ([key isEqualToString:kFade]) {
            self.opacity = value;
        } else if ([key isEqualToString:kRotate]) {
            t = CGAffineTransformRotate(t, radians(value));
        } else if ([key isEqualToString:kScale]) {
            t = CGAffineTransformScale(t, value, value);
        } else if ([key isEqualToString:kDrawOutline]) {
            self.strokeEnd = value;
        }
    }
    self.affineTransform = t;
}

- (void)resetBasicAnims
{
    [super resetBasicAnims];
    self.drawOutline = 1.0f;
}

@end
