//
//  VCQRScanViewController.m
//  VCQRCode
//
//  Created by Valyn on 2018/7/6.
//

#import "VCQRScanViewController.h"
#import "VCQRScanView.h"
#import "VCQRReader.h"

@interface VCQRScanViewController () <VCQRReaderDelegate>

@property (nonatomic, strong) VCQRScanView *scanView;
@property (nonatomic, strong) VCQRReader *reader;

@end

@implementation VCQRScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _scanView = [VCQRScanView new];
    [self.view addSubview:_scanView];
    _scanView.frame = self.view.bounds;
    [_scanView startAnimation];

    _reader = [VCQRReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    _reader.previewLayer.frame = self.view.bounds;
    
    [self.view.layer insertSublayer:_reader.previewLayer atIndex:0];
    [_reader startRunning];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _reader.previewLayer.frame = self.view.bounds;
}

#pragma mark - Delegate
#pragma mark - VCQRReaderDelegate
- (void)reader:(VCQRReader *)reader didOutputResult:(NSArray<__kindof AVMetadataObject *> *)metadataObjects
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
