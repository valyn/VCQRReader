//
//  VCQRReader.m
//  VCQRCode
//
//  Created by Valyn on 2018/7/10.
//

#import "VCQRReader.h"

@interface VCQRReader ()

@property (nonatomic, strong, readwrite) AVCaptureDevice *device;
@property (nonatomic, strong, readwrite) AVCaptureSession *session;
@property (nonatomic, strong, readwrite) AVCaptureDeviceInput *deviceInput;
@property (nonatomic, strong, readwrite) AVCaptureMetadataOutput *metadataOutput;
@property (nonatomic, strong, readwrite) AVCaptureVideoPreviewLayer *previewLayer;


@property (nonatomic, strong, readwrite) NSArray *metadataObjectTypes;


@end


@implementation VCQRReader

+ (instancetype)readerWithMetadataObjectTypes:(NSArray *)metadataObjectTypes
{
    return [[[self class] alloc] initWithMetadataObjectTypes:metadataObjectTypes];
}

- (instancetype)initWithMetadataObjectTypes:(NSArray *)metadataObjectTypes
{
    if (self = [super init]) {
        _metadataObjectTypes = metadataObjectTypes;
        [self  intialReader];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        _metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        [self  intialReader];
    }
    return self;
}

- (void)intialReader
{
    /** 1.session */
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    /** 2.layer */
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //        layer.frame = self.layer.bounds;
    //        [self.layer insertSublayer:layer atIndex:0];
    
    /** 3.device */
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    /** 4.input */
    _deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    if ([_session canAddInput:_deviceInput]) {
        [_session addInput:_deviceInput];
    }
    
    /** 5.output */
    _metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    _metadataOutput.rectOfInterest = self.previewLayer.bounds;
    if ([_session canAddOutput:_metadataOutput]) {
        [_session addOutput:_metadataOutput];
    }
    
    NSMutableSet *available = [NSMutableSet setWithArray:[_metadataOutput availableMetadataObjectTypes]];
    NSSet *desired = [NSSet setWithArray:_metadataObjectTypes];
    [available intersectSet:desired];
    [_metadataOutput setMetadataObjectTypes:available.allObjects];
    
}

#pragma mark - Public Methods
- (void)startRunning
{
    [_session startRunning];
}

- (void)stopRunning
{
    [_session stopRunning];
}

- (BOOL)hasTorch
{
    return _device.hasTorch;
}

- (BOOL)isTorchAvailable
{
    return _device.isTorchAvailable;
}

- (void)switchTorch
{
    if (_device.hasTorch && _device.isTorchAvailable) {
        NSError *err = nil;
        [_device lockForConfiguration:&err];
        if (!err) {
            _device.torchMode = _device.torchMode == AVCaptureTorchModeOn ? AVCaptureTorchModeOff : AVCaptureTorchModeOn;
        }
        [_device unlockForConfiguration];
    }
}

- (NSArray *)metadataObjectTypes
{
    return _metadataObjectTypes;
}

#pragma mark - Delagate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects && metadataObjects.count > 0 ) {
        //        AVMetadataMachineReadableCodeObject *obj = [metadataObjects objectAtIndex:0];
        if ([self.delegate respondsToSelector:@selector(reader:didOutputResult:)]) {
            [self.delegate reader:self didOutputResult:metadataObjects];
        }
    }
}

@end
