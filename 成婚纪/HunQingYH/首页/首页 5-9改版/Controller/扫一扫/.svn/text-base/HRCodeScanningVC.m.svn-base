//
//  HRCodeScanningVC.m
//  HunQingYH
//
//  Created by Dikai on 2018/6/14.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRCodeScanningVC.h"
#import "SGQRCode.h"

@interface HRCodeScanningVC ()
<SGQRCodeScanManagerDelegate, SGQRCodeAlbumManagerDelegate>
{
    UIView *_navView;
}
@property (nonatomic, strong) SGQRCodeScanManager *manager;
@property (nonatomic, strong) SGQRCodeScanningView *scanningView;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) UIButton *flashlightBtn;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;
@end

@implementation HRCodeScanningVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
  
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
    [_manager startRunning];
    [_manager resetSampleBufferDelegate];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.scanningView removeTimer];
    [self removeFlashlightBtn];
     [_manager cancelSampleBufferDelegate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =CHJ_bgColor;
  
   
    [self.view addSubview:self.scanningView];
     [self setupNav];
    [self setupQRCodeScanning];
    [self.view addSubview:self.promptLabel];
}
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_red"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"扫一扫";
    titleLab.textColor = WhiteColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    UIButton *xiangceBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [xiangceBtn  setTitle:@"相册" forState:UIControlStateNormal];
    [xiangceBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [xiangceBtn addTarget:self action:@selector(xiangceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:xiangceBtn];
    [xiangceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn);
    }];
}
- (SGQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [[SGQRCodeScanningView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight )];
        _scanningView.scanningImageName = @"SGQRCode.bundle/QRCodeScanningLine";
        _scanningView.scanningAnimationStyle = ScanningAnimationStyleDefault;
        _scanningView.cornerColor = MainColor;
    }
    return _scanningView;
}
- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}



- (void)setupQRCodeScanning {
    self.manager = [SGQRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [_manager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    [_manager cancelSampleBufferDelegate];
    _manager.delegate = self;
}

#pragma mark - - - SGQRCodeAlbumManagerDelegate
- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(SGQRCodeAlbumManager *)albumManager {
    [self.view addSubview:self.scanningView];
}
//相册扫描回调
- (void)QRCodeAlbumManager:(SGQRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
    
    if ([result  hasPrefix:@"http"]||[result  hasPrefix:@"https"]||[result  hasPrefix:@"www."]) {
        NSLog(@"扫描结果是网址：%@",result);
        [self goToWebViewControllerwWithUrlStr:result];

    } else {
        NSLog(@"扫描结果非网址：%@",result);
 
        [self showSystemAlertViewWithTitle:@"扫描结果" desText:result];
    }
}
- (void)QRCodeAlbumManagerDidReadQRCodeFailure:(SGQRCodeAlbumManager *)albumManager {
     [EasyShowTextView showText:@"暂未识别出扫描的二维码"];
}

#pragma mark - - - SGQRCodeScanManagerDelegate
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
//    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager playSoundName:@"SGQRCode.bundle/sound.caf"];
        [scanManager stopRunning];
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        if ([self.fromType isEqualToString:@"1"]) {
            //爆米花扫描
            self.callBackBlock([obj stringValue]);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            if ([[obj stringValue] hasPrefix:@"http"]||[[obj stringValue] hasPrefix:@"https"]||[[obj stringValue] hasPrefix:@"www."]) {
                NSLog(@"扫描结果是网址：%@",[obj stringValue]);
                [self goToWebViewControllerwWithUrlStr:[obj stringValue]];
                
            } else {
                NSLog(@"扫描结果非网址：%@",[obj stringValue]);
                [self showSystemAlertViewWithTitle:@"扫描结果" desText:[obj stringValue]];
                
            }
        }
        
      
        
        
//        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//        jumpVC.comeFromVC = ScanSuccessJumpComeFromWB;
//        jumpVC.jump_URL = [obj stringValue];
//        [self.navigationController pushViewController:jumpVC animated:YES];
    } else {
      
        [EasyShowTextView showText:@"暂未识别出扫描的二维码"];
    }
}
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager brightnessValue:(CGFloat)brightnessValue {
    if (brightnessValue < - 1) {
        [self.view addSubview:self.flashlightBtn];
    } else {
        if (self.isSelectedFlashlightBtn == NO) {
            [self removeFlashlightBtn];
        }
    }
}
- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.backgroundColor = [UIColor clearColor];
        CGFloat promptLabelX = 0;
        CGFloat promptLabelY = 0.73 * self.view.frame.size.height+50;
        CGFloat promptLabelW = self.view.frame.size.width;
        CGFloat promptLabelH = 25;
        _promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
        _promptLabel.text = @"将二维码放入框内, 即可自动扫描";
    }
    return _promptLabel;
}
#pragma mark - - - 闪光灯按钮
- (UIButton *)flashlightBtn {
    if (!_flashlightBtn) {
        // 添加闪光灯按钮
        _flashlightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat flashlightBtnW = 30;
        CGFloat flashlightBtnH = 30;
        CGFloat flashlightBtnX = 0.5 * (self.view.frame.size.width - flashlightBtnW);
        CGFloat flashlightBtnY =  0.73 * self.view.frame.size.height+15;
        _flashlightBtn.frame = CGRectMake(flashlightBtnX, flashlightBtnY, flashlightBtnW, flashlightBtnH);
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"闪光灯打开"] forState:(UIControlStateNormal)];
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"闪光灯关闭"] forState:(UIControlStateSelected)];
        [_flashlightBtn addTarget:self action:@selector(flashlightBtn_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashlightBtn;
}
- (void)flashlightBtn_action:(UIButton *)button {
    if (button.selected == NO) {
        [SGQRCodeHelperTool SG_openFlashlight];
        self.isSelectedFlashlightBtn = YES;
        button.selected = YES;
    } else {
        [self removeFlashlightBtn];
    }
}

- (void)removeFlashlightBtn {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SGQRCodeHelperTool SG_CloseFlashlight];
        self.isSelectedFlashlightBtn = NO;
        self.flashlightBtn.selected = NO;
        [self.flashlightBtn removeFromSuperview];
    });
}

#pragma mark -------target--------
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)goToWebViewControllerwWithUrlStr:(NSString*)urlStr{
    HRWebViewController *webVC =[HRWebViewController new];
    webVC.webUrl =urlStr;
    webVC.isShareBtn =NO;;
    [self.navigationController pushViewController:webVC animated:YES];
   
}
-(void)showSystemAlertViewWithTitle:(NSString*)title desText:(NSString *)des{
    EasyShowAlertView *alertView =[EasyShowAlertView showSystemAlertWithTitle:title message:des];
    [alertView addSystemItemWithTitle:@"确定" itemType:UIAlertActionStyleDefault callback:^(EasyShowAlertView *showview) {
    
    }];
//    [alertView addSystemItemWithTitle:@"" itemType:UIAlertActionStyleDestructive callback:^(EasyShowAlertView *showview) {
//        NSLog(@"dddddwd  ");
//    }];
    [alertView systemShow];
}
- (void)dealloc {
    NSLog(@"WBQRCodeScanningVC - dealloc");
    [self removeScanningView];
}
- (void)xiangceBtnClick{
    SGQRCodeAlbumManager *manager = [SGQRCodeAlbumManager sharedManager];
    [manager readQRCodeFromAlbumWithCurrentController:self];
    manager.delegate = self;
    
    if (manager.isPHAuthorization == YES) {
        [self.scanningView removeTimer];
    }
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
