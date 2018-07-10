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
        view.frame = CGRectMake(0, 0, self.frame.size.width, 100);
        view.backgroundColor = [UIColor cyanColor];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat:self.frame.size.height];
        animation.repeatCount = HUGE_VAL;
        animation.removedOnCompletion = NO;
        animation.duration = 1.0f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _scanAnimation = animation;
    }
    return self;
}

- (void)startAnimation
{
    [self.scanLine.layer addAnimation:self.scanAnimation forKey:@"scanAnimation"];
}

- (void)stopAnimation
{
    [self.scanLine.layer removeAllAnimations];
}


@end
