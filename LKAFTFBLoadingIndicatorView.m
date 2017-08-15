//
//  LKAFTFBLoadingIndicatorView.m
//  FourTinyFancyBallsLoadingIndicator
//
//  Created by Luka on 2017/8/12.
//  Copyright © 2017年 Luka. All rights reserved.
//

#import "LKAFTFBLoadingIndicatorView.h"
#define kMargin 5.0

@interface LKAFTFBLoadingIndicatorView () <CAAnimationDelegate>
@property (nonatomic, strong) CALayer *upDotLayer;
@property (nonatomic, strong) CALayer *rightDotLayer;
@property (nonatomic, strong) CALayer *bottomDotLayer;
@property (nonatomic, strong) CALayer *leftDotLayer;
@property (nonatomic, assign) BOOL isAnimating;
@end

@implementation LKAFTFBLoadingIndicatorView

#pragma mark - custom view initialization
- (void)initialization {
    [self setupLayers];
    _isAnimating = NO;
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 0.0;
//    self.layer.shouldRasterize = YES;
//    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    return self;
}


#pragma mark - set up layers
- (void)setupLayers {
    _upDotLayer = [CALayer layer];
    _upDotLayer.rasterizationScale = [UIScreen mainScreen].scale;
    _upDotLayer.shouldRasterize = YES;
    _upDotLayer.backgroundColor = [UIColor colorWithRed:0.99 green:0.46 blue:0.43 alpha:1.00].CGColor;
    [self.layer addSublayer:_upDotLayer];
    
    _rightDotLayer = [CALayer layer];
    _rightDotLayer.rasterizationScale = [UIScreen mainScreen].scale;
    _rightDotLayer.shouldRasterize = YES;
    _rightDotLayer.backgroundColor = [UIColor colorWithRed:0.63 green:0.95 blue:0.84 alpha:1.00].CGColor;
    [self.layer addSublayer:_rightDotLayer];
    
    _bottomDotLayer = [CALayer layer];
    _bottomDotLayer.rasterizationScale = [UIScreen mainScreen].scale;
    _bottomDotLayer.shouldRasterize = YES;
    _bottomDotLayer.backgroundColor = [UIColor colorWithRed:0.50 green:0.83 blue:0.78 alpha:1.00].CGColor;
    [self.layer addSublayer:_bottomDotLayer];
    
    _leftDotLayer = [CALayer layer];
    _leftDotLayer.rasterizationScale = [UIScreen mainScreen].scale;
    _leftDotLayer.shouldRasterize = YES;
    _leftDotLayer.backgroundColor = [UIColor colorWithRed:0.99 green:0.68 blue:0.61 alpha:1.00].CGColor;
    [self.layer addSublayer:_leftDotLayer];
}


#pragma mark - update layer frame
- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateLayers];
}

- (void)updateLayers {
    NSAssert(self.bounds.size.width == self.bounds.size.height, @"THE VIEW ASPECT RATIO SHOULD BE 1 : 1");
    CGFloat width = self.bounds.size.width;
    CGFloat dotWidth = (width - 2 * kMargin) * 0.32;
    CGRect dotBound = CGRectMake(0, 0, dotWidth, dotWidth);
    CGFloat dotRadius = dotWidth / 2.0;
    
    // set cornerRadius
    self.upDotLayer.cornerRadius = dotRadius;
    self.rightDotLayer.cornerRadius = dotRadius;
    self.bottomDotLayer.cornerRadius = dotRadius;
    self.leftDotLayer.cornerRadius = dotRadius;

    self.upDotLayer.bounds = dotBound;
    self.rightDotLayer.bounds = dotBound;
    self.bottomDotLayer.bounds = dotBound;
    self.leftDotLayer.bounds = dotBound;
    
    self.upDotLayer.position = CGPointMake(width / 2.0, dotRadius + kMargin);
    self.rightDotLayer.position = CGPointMake(width - kMargin - dotRadius, width / 2);
    self.bottomDotLayer.position = CGPointMake(width / 2.0, width - kMargin - dotRadius);
    self.leftDotLayer.position = CGPointMake(kMargin + dotRadius, width / 2.0);
    
}

- (void)dotsShrinkAnimation {
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    springAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    springAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1.0)];

    springAnimation.fillMode = kCAFillModeBoth;
    springAnimation.removedOnCompletion = NO;
    springAnimation.stiffness = 50;
    springAnimation.damping = 5;
    springAnimation.mass = 0.4;
    springAnimation.initialVelocity = 10;
    springAnimation.duration = 0.7;
    springAnimation.delegate = self;
    springAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.bottomDotLayer addAnimation:springAnimation forKey:nil];

    springAnimation.beginTime = CACurrentMediaTime() + 0.05;
    [self.leftDotLayer addAnimation:springAnimation forKey:nil];
    
    springAnimation.beginTime = CACurrentMediaTime() + 0.1;
    [self.upDotLayer addAnimation:springAnimation forKey:nil];
    
    springAnimation.beginTime = CACurrentMediaTime() + 0.15;
    [springAnimation setValue:@"DotsShrinkAnimation" forKey:@"name"];
    [self.rightDotLayer addAnimation:springAnimation forKey:@"DotsShrinkAnimation"];
}

- (void)rotateAnimation:(NSString *)type {
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    rotateAnimation.additive = YES;
    CGFloat currentRadius = [[self.layer.presentationLayer valueForKeyPath:@"transform.rotation"] floatValue];
    if (currentRadius >(2 * M_PI)) currentRadius -= (2 * M_PI);
    rotateAnimation.fromValue =@( currentRadius );
    rotateAnimation.byValue = @(M_PI_2 * 3 / 2.0);
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotateAnimation.duration = 0.5;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.delegate = self;
    [rotateAnimation setValue:@"RotateAnimation" forKey:@"name"];
    [rotateAnimation setValue:type forKey:@"type"];
    [self.layer addAnimation:rotateAnimation forKey:@"RotateAnimation"];
}

- (void)dotsOriginSizeAnimation {
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    springAnimation.toValue =  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    springAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1.0)];
    springAnimation.fillMode = kCAFillModeForwards;
    springAnimation.removedOnCompletion = NO;
    springAnimation.stiffness = 50;
    springAnimation.damping = 5;
    springAnimation.mass = 0.7;
    springAnimation.initialVelocity = 10;
    springAnimation.duration = 0.7;
    springAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    springAnimation.delegate = self;
    [self.bottomDotLayer addAnimation:springAnimation forKey:nil];
    
    [self.leftDotLayer addAnimation:springAnimation forKey:nil];
    
    [self.upDotLayer addAnimation:springAnimation forKey:nil];
    
    [springAnimation setValue:@"DotsOriginSizeAnimation" forKey:@"name"];
    [self.rightDotLayer addAnimation:springAnimation forKey:@"DotsOriginSizeAnimation"];
}

- (void)startAnimating {
    if (!self.isAnimating) {
        self.isAnimating = YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            [self dotsShrinkAnimation];
        }];
    }
}

- (void)stopAnimating {
    if (self.isAnimating) {
        self.isAnimating = NO;
        self.alpha = 0.0;
        
        [self.layer removeAllAnimations];
        [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeAllAnimations];
        }];
        

    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (!self.isAnimating) return;
    
    NSString *name = [anim valueForKey:@"name"];
    if ([name isEqualToString:@"DotsShrinkAnimation"]) {
        [self rotateAnimation:@"afterShrink"];
    } else if ([name isEqualToString:@"RotateAnimation"]) {
        NSString *type = [anim valueForKey:@"type"];
        if ([type isEqualToString:@"afterShrink"]) {
            [self dotsOriginSizeAnimation];
        } else {
            [self dotsShrinkAnimation];
        }
    } else if ([name isEqualToString:@"DotsOriginSizeAnimation"]) {
        [self rotateAnimation:@"afterOrigin"];
    }
}
@end
