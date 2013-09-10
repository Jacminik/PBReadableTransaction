PBReadableTransaction
=====================

Readable CATransaction Animation.

CATransaction is not readable:

CFTimeInterval duration = 0.425f;
CALayer *arrowLayer = nil;
CALayer *plusLayer = nil;

[CATransaction begin];
[CATransaction setAnimationDuration:duration];
[CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
[CATransaction setCompletionBlock:^{
        
  plusLayer.affineTransform = CGAffineTransformMakeScale(1.5f, 1.5f);
  arrowLayer.hidden = YES;
}];
    
arrowLayer.opacity = 0.0f;
arrowLayer.affineTransform = CGAffineTransformMakeRotation(M_PI * 0.5f);
plusLayer.opacity = 1.0f;
plusLayer.affineTransform = CGAffineTransformIdentity;
    
[CATransaction commit];


