//
//  YPReMeGuanzhuFensiController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/29.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReMeGuanzhuFensiController.h"
#import <NinaPagerView.h>
#import "YPReMeGuanzhuController.h"//关注
#import "YPReMeFensiController.h"//粉丝

@interface YPReMeGuanzhuFensiController ()

@property (nonatomic, strong) NinaPagerView *pageView;

@end

@implementation YPReMeGuanzhuFensiController{
    UIView *_navView;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
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
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"好友列表";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}

- (void)setupUI{
    
    NSMutableArray *vcMarr = [NSMutableArray array];
    
    YPReMeGuanzhuController *guanzhu = [[YPReMeGuanzhuController alloc]init];
    [vcMarr addObject:guanzhu];
    
    YPReMeFensiController *fensi = [[YPReMeFensiController alloc]init];
    [vcMarr addObject:fensi];
    
    if (!self.pageView) {
        self.pageView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) WithTitles:@[[NSString stringWithFormat:@"关注 %zd",self.guanzhu],[NSString stringWithFormat:@"粉丝 %zd",self.fensi]] WithObjects:vcMarr];
        self.pageView.titleFont = 18;
        //        self.pageView.selectBottomLinePer = 0.6;//下划线长度比例
        self.pageView.nina_autoBottomLineEnable = YES;//自适应下划线长度
        self.pageView.selectBottomLineHeight = 3;
        self.pageView.loadWholePages = YES;//一次性加载控制器
        self.pageView.selectTitleColor = BlackColor;
        self.pageView.unSelectTitleColor = GrayColor;
        self.pageView.underlineColor = NavBarColor;
        self.pageView.topTabHeight = 50;
        self.pageView.topTabBackGroundColor = RGB(249, 249, 249);
        [self.view addSubview:self.pageView];
    }
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
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
