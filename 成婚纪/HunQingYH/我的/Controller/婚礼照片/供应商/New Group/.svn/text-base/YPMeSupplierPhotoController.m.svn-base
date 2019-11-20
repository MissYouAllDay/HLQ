//
//  YPMeSupplierPhotoController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/3/23.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMeSupplierPhotoController.h"
#import <NinaPagerView.h>
#import "YPMeSupplierPhotoAllController.h"//全部
#import "YPMeSupplierPhotoRejectController.h"//不合格
#import "YPPhotoVideoNoticeView.h"//用前须知

@interface YPMeSupplierPhotoController ()

@property (nonatomic, strong) NinaPagerView *pageView;

@property (nonatomic, strong) UIControl *control;

@end

@implementation YPMeSupplierPhotoController{
    UIView *_navView;
    YPPhotoVideoNoticeView *_noticeView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    
    [self setupUI];
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
        
    }];
    
    UILabel *titleLabel  = [[UILabel alloc]init];
    titleLabel.text = self.manName;
    titleLabel.textColor = BlackColor;
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //设置导航栏右边更多
    UIButton *moreBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setImage:[UIImage imageNamed:@"问号"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.size.mas_equalTo(CGSizeMake(20, 40));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn);
    }];
    
}

- (void)setupUI{
    
    NSMutableArray *vcMarr = [NSMutableArray array];
    
    YPMeSupplierPhotoAllController *all = [[YPMeSupplierPhotoAllController alloc]init];
    all.customerId = self.customerId;
    all.noDataBlock = ^{
        [self moreBtnClick];
    };
    [vcMarr addObject:all];

    YPMeSupplierPhotoRejectController *bad = [[YPMeSupplierPhotoRejectController alloc]init];
    bad.customerId = self.customerId;
    [vcMarr addObject:bad];
    
    if (!self.pageView) {
        self.pageView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) WithTitles:@[@"全部照片",@"不合格照片"] WithObjects:vcMarr];
        self.pageView.titleFont = 18;
        //        self.pageView.selectBottomLinePer = 0.6;//下划线长度比例
        self.pageView.nina_autoBottomLineEnable = YES;//自适应下划线长度
        self.pageView.selectBottomLineHeight = 3;
        self.pageView.loadWholePages = YES;//一次性加载控制器
        self.pageView.selectTitleColor = NavBarColor;
        self.pageView.unSelectTitleColor = GrayColor;
        self.pageView.underlineColor = NavBarColor;
        [self.view addSubview:self.pageView];
    }

}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"moreBtnClick");
    
    [self.view addSubview:self.control];
}

- (void)controlClick{
    
    [self.control removeFromSuperview];
}

#pragma mark - getter
- (UIControl *)control{
    if (!_control) {
        _control = [[UIControl alloc]initWithFrame:self.view.frame];
        _control.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        if (!_noticeView) {
            _noticeView = [YPPhotoVideoNoticeView yp_photoVideoNoticeView];
        }
        [_control addSubview:_noticeView];
        [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_control);
            make.left.mas_equalTo(25);
            make.right.mas_equalTo(-25);
        }];
    }
    [_control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [_noticeView.knowBtn addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    return _control;
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
