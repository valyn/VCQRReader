//
//  VCQRScanView.h
//  VCQRCode
//
//  Created by Valyn on 2018/7/9.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@protocol VCQRScanViewDelegate;

@interface VCQRScanView : UIView

- (void)startAnimation;
- (void)stopAnimation;

@end

