//
//  SeasoningManagementScanBarcodeVC.m
//  EES
//
//  Created by Albus on 2019-11-22.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "SeasoningManagementScanBarcodeVC.h"
#import "CDZQRScanView.h"

@interface SeasoningManagementScanBarcodeVC () <CDZQRScanDelegate>

@property (nonatomic ,strong) CDZQRScanView *scanView;

@end

@implementation SeasoningManagementScanBarcodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.scanView];
    [self.scanView startScanning];
}

#pragma mark - scanViewDelegate
- (void)scanView:(CDZQRScanView *)scanView pickUpMessage:(NSString *)message {
    [scanView stopScanning];
    
    NSLog(@"barcodeMessage: %@", message);
    
    [self back];
    
    if (self.bacodeFoundBlock) {
        self.bacodeFoundBlock(message);
    }
}

#pragma mark getter

- (CDZQRScanView *)scanView {
    if (!_scanView) {
        _scanView = [[CDZQRScanView alloc] initWithFrame:self.view.bounds];
        _scanView.delegate = self;
        _scanView.showBorderLine = YES;
    }
    return _scanView;
}

@end
