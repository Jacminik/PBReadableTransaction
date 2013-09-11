PBReadableTransaction
=====================

Writable and readable CATransaction Animation Code.

CATransaction code is too long and unreadable:

    [CATransaction begin];
    [CATransaction setAnimationDuration:duration];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    // After Animation.
    [CATransaction setCompletionBlock:^{
        plusLayer.affineTransform = CGAffineTransformMakeScale(1.5f, 1.5f);     // Scale 1.5
        arrowLayer.hidden = YES;
    }];
    
    // animation.
    arrowLayer.opacity = 0.0f; 
    arrowLayer.affineTransform = CGAffineTransformMakeRotation(M_PI * 0.5f);    // Rotate 45.
    plusLayer.opacity = 1.0f;
    plusLayer.affineTransform = CGAffineTransformIdentity;                      // Set Default.
    
    [CATransaction commit];


PBReadableTransaction code:

    [CATransaction animateWithDuration:duration
                    animationCurveType:PBCurveTypeEaseInOut
                            animations:^{
                                arrowLayer.basicAnims = @{kFade: @(0.0f), kRotate: @(90.0f)};
                                plusLayer.basicAnims = @{kFade: @(1.0f), kRotate: @(0.0f)};
                            } completion:^{
                                plusLayer.scale = 1.5f;
                                arrowLayer.hidden = YES;
                            }];

# Usage

### Animatable Propertys

    // CALayer
    layer.fade = 0.45f;     // layer.opacity
    layer.rotate = 45.0f;   // layer.transform = CGAffineTransformMakeRotation(...)
    layer.scale = 1.3f      // layer.transform = CGAffineTransformMakeScale(...)
    layer.move = (UIOffset){10.0f, 10.0f};  // layer.transform = CGAffineTransformMakeTranslate(...)

    // CAShapeLayer added.
    shapeLayer.drawOutline = 1.0f;  // shapeLayer.strokeEnd
    
    
    // Set Multiple Animations
    layer.basicAnims = @{kFade: @0.0f, kRotate: @90.0f, kScale: @1.2f};
    shapeLayer.basicAnims = @{kFade: @0.4f, kMove: moveOffset(10.0f, -15.0f), kDrawOutline: 0.0f};
    
    // Reset all animation propertys
    [layer resetBasicAnims];
    
### CATransaction with Blocks

    // CATransaction Animation
    [CATransaction animateWithDuration:duration
                    animationCurveType:PBCurveTypeEaseInOut
                            animations:^{
                                // Do animation...
                            } completion:^{
                                // Do completed action...
                            }];
                            
    // Disabled Animation
    [CATransaction nonAnimateBlock:^{
        // Set layer propertys. non animate.
    }];
    

### More complicated animation

    typedef void (^transactionBlock_t)();
    
    - (void)beginToggleAnimationIsOn:(BOOL)isOn 
    {
        transactionBlock_t readyBlock = nil;
        transactionBlock_t firstAnimBlock = nil;
        transactionBlock_t secondAnimBlock = nil;
        transactionBlock_t completeBlock = nil;
        
        if (isOn) {
            readyBlock = ^ {
                // Preparations for animation
            };
            firstAnimBlock = ^{ ... };
            secondAnimBlock = ^{ ... };
            completeBlock = ^{ ... };
        } else {
            readyBlock = ...
            firstAnimBlock = ...
            secondAnimBlock = ...
            completeBlock = ...
        }
        
        
        [CATransaction nonAnimateBlock:readyBlock];             // ready
    
        [CATransaction animateWithDuration:firstDuration
                    animationCurveType:PBCurveTypeEaseInOut
                            animations:firstAnimBlock           // first animation
                            completion:^{
            [CATransaction animateWithDuration:secondDuration
                            animationCurveType:PBCurveTypeEaseOut
                                    animations:secondAnimBlock  // second animation
                                    completion:completeBlock];  // completion
        }];
    }


# License

This code is distributed under the terms and conditions of the MIT license.
