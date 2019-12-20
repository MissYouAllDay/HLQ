//
//  YPInviteFriendsWedNormalFace2FaceController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/23.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPInviteFriendsWedNormalFace2FaceController.h"
#import "HMScannerController.h"

@interface YPInviteFriendsWedNormalFace2FaceController ()

@end

@implementation YPInviteFriendsWedNormalFace2FaceController{
    UIView *_navView;
    UIImageView *codeImageView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupUI{
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"扫一扫 办婚礼";
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:24];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40+NAVIGATION_BAR_HEIGHT);
        make.centerX.mas_equalTo(self.view);
    }];
    
    //二维码
    codeImageView = [[UIImageView alloc]init];
    [self.view addSubview:codeImageView];
    [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).mas_offset(40);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(ScreenWidth-200);
        make.height.mas_equalTo(ScreenWidth-200);
    }];
    
    NSString *cardName = [NSString stringWithFormat:@"http://www.chenghunji.com/Capital/BeiHun?UserId=%@",UserId_New];
    
    [HMScannerController cardImageWithCardName:cardName avatar:nil scale:0.2 completion:^(UIImage *image) {
        codeImageView.image = image;
    }];
    
//    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [saveBtn setTitle:@"保存图片" forState:UIControlStateNormal ];
//    [saveBtn setTitleColor:MainColor forState:UIControlStateNormal];
//    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:saveBtn];
//    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(codeImageView);
//        make.bottom.mas_equalTo(codeImageView.mas_bottom).mas_offset(30);
//        make.size.mas_equalTo(CGSizeMake(80, 30));
//    }];
    
}

- (void)setupNav{
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"面对面邀请";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveBtnClick{
    UIImageWriteToSavedPhotosAlbum(codeImageView.image, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
}

//保存完成后调用的方法
- (void) savedPhotoImage:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    if (error) {
        [EasyShowTextView  showErrorText:@"保存失败"];
    }
    else {
        [EasyShowTextView showSuccessText:@"图片保存成功"];
    }
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
