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

# Usage

### Designated Initializer

Use the designated initializer below to initialize the circle menu:

    // |buttonCount| : count of buttons around (1<= x <=6)
    // |menuSize| : size of menu
    // |buttonSize| : size of buttons around
    // |buttonImageNameFormat| : name format for button image
    // |centerButtonSize| : size of center button
    // |centerButtonImageName| : name for center button image
    // |centerButtonBackgroundImageName| : name for center button background image
    - (id)      initWithButtonCount:(NSInteger)buttonCount
                           menuSize:(CGFloat)menuSize
                         buttonSize:(CGFloat)buttonSize
              buttonImageNameFormat:(NSString *)buttonImageNameFormat
                   centerButtonSize:(CGFloat)centerButtonSize
              centerButtonImageName:(NSString *)centerButtonImageName
    centerButtonBackgroundImageName:(NSString *)centerButtonBackgroundImageName;

### Button Action

Override the `-runButtonActions:` message to customize your button action:

    - (void)runButtonActions:(id)sender {
      [super runButtonActions:sender];
  
      // Do buttons' action appropriately by |[sender tag]|
      // ...
    }

Tags are defined like below:

    TAG:        1       1   2      1   2     1   2     1 2 3     1 2 3
               \|/       \|/        \|/       \|/       \|/       \|/
    COUNT: 1) --|--  2) --|--   3) --|--  4) --|--  5) --|--  6) --|--
               /|\       /|\        /|\       /|\       /|\       /|\
    TAG:                             3       3   4     4   5     4 5 6

### Navigation Bar

---
# License

This code is distributed under the terms and conditions of the MIT license.
