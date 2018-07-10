//
//  VCQRScanView.m
//  VCQRCode
//
//  Created by Valyn on 2018/7/9.
//

#import "VCQRScanView.h"

@interface VCQRScanView ()

@property (nonatomic, strong) UIView *scanLine;
@property (nonatomic, strong) CABasicAnimation *scanAnimation;

@end

@implementation VCQRScanView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
       
        UIView *view = [UIView new];
        [self addSubview:view];
        view.backgroundColor = [UIColor cyanColor];
        _scanLine = view;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _scanLine.frame = CGRectMake(0, 0, self.frame.size.width, 1);
}

- (void)startAnimation
{
    if (!_scanAnimation) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat:self.frame.size.height];
        animation.repeatCount = HUGE_VAL;
        animation.autoreverses = YES;
        animation.removedOnCompletion = NO;
        animation.duration = 3.0f;
        animation.cumulative = 
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _scanAnimation = animation;
    }
    [self.scanLine.layer addAnimation:self.scanAnimation forKey:@"scanAnimation"];
}

- (void)stopAnimation
{
    [self.scanLine.layer removeAllAnimations];
}


@end
