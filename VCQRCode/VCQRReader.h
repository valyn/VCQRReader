//
//  VCQRReader.h
//  VCQRCode
//
//  Created by Valyn on 2018/7/10.
//


#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@protocol VCQRReaderDelegate;
@interface VCQRReader : NSObject<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong, readonly) AVCaptureDevice *device;
@property (nonatomic, strong, readonly) AVCaptureDeviceInput *deviceInput;
@property (nonatomic, strong, readonly) AVCaptureMetadataOutput *metadataOutput;
@property (nonatomic, strong, readonly) AVCaptureVideoPreviewLayer *previewLayer;


@property (nonatomic, weak) id<VCQRReaderDelegate> delegate;
@property (nonatomic, strong, readonly) NSArray *metadataObjectTypes;


- (instancetype)initWithMetadataObjectTypes:(NSArray *) metadataObjectTypes;
+ (instancetype)readerWithMetadataObjectTypes:(NSArray *) metadataObjectTypes;


- (BOOL)hasTorch;
- (BOOL)isTorchAvailable;
- (void)switchTorch;


- (void)startRunning;
- (void)stopRunning;


@end



@protocol VCQRReaderDelegate<NSObject>

@optional
- (void)reader:(VCQRReader *)render didOutputResult:(NSArray<__kindof AVMetadataObject *> *)metadataObjects;

@end
