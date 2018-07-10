//
//  ViewController.m
//  VCQRCode
//
//  Created by Valyn on 2018/7/6.
//

#import "ViewController.h"
#import "VCQRScanViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    
    [btn setTitle:@"QR Scan" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    btn.frame = CGRectMake(150, 200, 100, 50);
//    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[btn(==100)]-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(@"btn",btn)];
//
//    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[btn(==50)]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(@"btn",btn)];
//    NSMutableArray *tempt = [NSMutableArray array];
//    [tempt addObjectsFromArray:constraint1];
//    [tempt addObjectsFromArray:constraint2];
//    [self.view addConstraints:tempt];
    [btn addTarget:self action:@selector(ScanQR) forControlEvents:UIControlEventTouchDown];
}

- (void)ScanQR
{
    VCQRScanViewController *VC = [VCQRScanViewController new];
    [self presentViewController:VC animated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
