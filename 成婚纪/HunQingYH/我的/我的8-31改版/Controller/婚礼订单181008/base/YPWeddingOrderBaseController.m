//
//  YPWeddingOrderBaseController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/8.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPWeddingOrderBaseController.h"
#import "YPWeddingOrderListController.h"
#import "YPWeddingOrderAddBanShouLiController.h"//添加伴手礼
#import "YPWeddingOrderAddDaiShouController.h"//添加代收
#import "YPWeddingOrderAddWedFanHuanController.h"//18-11-07 婚礼返还

#import "NinaPagerView.h"
#import "PopoverView.h"//弹窗

@interface YPWeddingOrderBaseController ()

@property (nonatomic, strong) NinaPagerView *pageView;

@end

@implementation YPWeddingOrderBaseController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupUI];
    [self setupNav];
    
}

#pragma mark - UI
- (void)setupUI{

    NSArray *titleArr = @[@"全部",@"待支付",@"已支付",@"已提现"];
    NSMutableArray *vcMarr=[NSMutableArray array];
    for (NSString *str in titleArr) {
        YPWeddingOrderListController *vc = [[YPWeddingOrderListController alloc]init];
        vc.typeStr = str;
        [vcMarr addObject:vc];
    }
    
    if (!self.pageView) {
        self.pageView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) WithTitles:titleArr WithObjects:vcMarr];
        self.pageView.titleFont = 16;
        self.pageView.underlineColor = RGB(250, 80, 120);
        self.pageView.selectBottomLinePer = 0.5;
        self.pageView.selectBottomLineHeight = 3;
        [self.view addSubview:self.pageView];
    }
    
}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
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
    titleLab.text = @"婚礼支付";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    UIButton *rightBtn = [[UIButton alloc]init];
    if (JiuDian(Profession_New)) {//18-10-24 酒店只能添加伴手礼
        [rightBtn setTitle:@"添加伴手礼" forState:UIControlStateNormal];
    }else{
        [rightBtn setTitle:@"添加订单" forState:UIControlStateNormal];
    }
    [rightBtn setTitleColor:RGBA(102, 102, 102, 1) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = kFont(16);
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.right.mas_equalTo(-15);
    }];
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnClick:(UIButton *)sender{
    NSLog(@"rightBtnClick");
    
    if (JiuDian(Profession_New)) {//18-10-24 酒店只能添加伴手礼
        YPWeddingOrderAddBanShouLiController *add = [[YPWeddingOrderAddBanShouLiController alloc]init];
        [self.navigationController pushViewController:add animated:YES];
    }else{
        // 伴手礼 action
        PopoverAction *QRAction = [PopoverAction actionWithImage:nil title:@"伴手礼" handler:^(PopoverAction *action) {
            YPWeddingOrderAddBanShouLiController *add = [[YPWeddingOrderAddBanShouLiController alloc]init];
            [self.navigationController pushViewController:add animated:YES];
        }];
//        // 代收 action 18-11-09 暂时隐藏
//        PopoverAction *payAction = [PopoverAction actionWithImage:nil title:@"代收" handler:^(PopoverAction *action) {
//            YPWeddingOrderAddDaiShouController *add = [[YPWeddingOrderAddDaiShouController alloc]init];
//            [self.navigationController pushViewController:add animated:YES];
//        }];
        //18-11-07 婚礼返还
        // 婚礼返还 action
        PopoverAction *backAction = [PopoverAction actionWithImage:nil title:@"婚礼返还" handler:^(PopoverAction *action) {
            YPWeddingOrderAddWedFanHuanController *add = [[YPWeddingOrderAddWedFanHuanController alloc]init];
            [self.navigationController pushViewController:add animated:YES];
        }];
        
        NSArray *arr = @[QRAction,backAction];
        
        PopoverView *popoverView = [PopoverView popoverView];
        popoverView.showShade = YES; // 显示阴影背景
        [popoverView showToView:sender withActions:arr];
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
