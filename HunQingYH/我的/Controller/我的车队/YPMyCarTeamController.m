//
//  YPMyCarTeamController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/31.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMyCarTeamController.h"
#import "NinaPagerView.h"
#import "YPMyCarJianJieController.h"
#import "YPMyCarCheXingController.h"
#import "YPMyCarMemberController.h"

@interface YPMyCarTeamController ()<UIActionSheetDelegate>

@property (nonatomic, strong) NinaPagerView *pageView;

@property (nonatomic, strong) YPMyCarJianJieController *jianjieVC;
@property (nonatomic, strong) YPMyCarCheXingController *chexingVC;
@property (nonatomic, strong) YPMyCarMemberController  *memberVC;

@end

@implementation YPMyCarTeamController{
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

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = bgColor;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"我的车队";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.mas_equalTo(_navView).mas_offset(15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
    
    //设置导航栏右边搜索
    UIButton *searchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"三个点"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
    
}

- (void)setupUI{
    
    NSArray *titleArr = @[@"简介",@"车型",@"成员"];
    
    NSArray *vcMarr = @[self.jianjieVC,self.chexingVC,self.memberVC];
    
    if (!self.pageView) {
        self.pageView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, kNavH+1, ScreenWidth, ScreenHeight-kNavH-1) WithTitles:titleArr WithVCs:vcMarr];
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
    NSLog(@"操作");
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"修改",@"解散", nil];
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%zd",buttonIndex);
    if (buttonIndex == 0) {
        NSLog(@"修改");
    }else if (buttonIndex == 1) {
        NSLog(@"解散");
    }
}

#pragma mark - getter
- (YPMyCarJianJieController *)jianjieVC{
    if (!_jianjieVC) {
        _jianjieVC = [[YPMyCarJianJieController alloc]init];
    }
    return _jianjieVC;
}

- (YPMyCarCheXingController *)chexingVC{
    if (!_chexingVC) {
        _chexingVC = [[YPMyCarCheXingController alloc]init];
    }
    return _chexingVC;
}

- (YPMyCarMemberController *)memberVC{
    if (!_memberVC) {
        _memberVC = [[YPMyCarMemberController alloc]init];
    }
    return _memberVC;
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
