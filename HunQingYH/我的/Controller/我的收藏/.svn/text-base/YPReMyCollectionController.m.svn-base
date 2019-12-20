//
//  YPReMyCollectionController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/8.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPReMyCollectionController.h"
#import "NinaPagerView.h"
#import "YPMyCollectionSupplierController.h"
#import "YPMyCollectionYanHuiTingController.h"
#import "YPMyCollectionSearchController.h"

@interface YPReMyCollectionController ()

@property (nonatomic, strong) NinaPagerView *pageView;

@property (nonatomic, strong) YPMyCollectionSupplierController *supplier;
@property (nonatomic, strong) YPMyCollectionYanHuiTingController *yanhuiting;

@end

@implementation YPReMyCollectionController{
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
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"我的收藏";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    
    
    //设置导航栏右边搜索
    UIButton *searchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
}

- (void)setupUI{
        
    NSArray *titleArr = @[@"供应商",@"宴会厅"];
    
    NSArray *vcMarr = @[self.supplier,self.yanhuiting];
    
    if (!self.pageView) {
        self.pageView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) WithTitles:titleArr WithObjects:vcMarr];
        self.pageView.titleFont = 15;
        self.pageView.underlineColor = RGB(236, 52, 83);
        [self.view addSubview:self.pageView];
    }
        
}
    
#pragma mark - 按钮点击事件
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBtnClick{
    NSLog(@"searchBtnClick");
    
    YPMyCollectionSearchController *search = [[YPMyCollectionSearchController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark - getter
- (YPMyCollectionSupplierController *)supplier{
    if (!_supplier) {
        _supplier = [[YPMyCollectionSupplierController alloc]init];
    }
    return _supplier;
}

- (YPMyCollectionYanHuiTingController *)yanhuiting{
    if (!_yanhuiting) {
        _yanhuiting = [[YPMyCollectionYanHuiTingController alloc]init];
    }
    return _yanhuiting;
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
