//
//  HRFAStoreViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/4/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRFAStoreViewController.h"
#import "YPAllFangAnController.h"
//#import "YPYiGouFangAnController.h"
#import "YPFASearchController.h"//搜索
#import "NinaPagerView.h"

@interface HRFAStoreViewController (){
    UIView *_navView;
}
@property (nonatomic, strong) NinaPagerView *pageView;
@property (nonatomic, copy) NSString *colorStr;//色系字段

@end

@implementation HRFAStoreViewController


#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self getColorList];//获取色系
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
    
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
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
    titleLab.text = @"共享方案";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
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
        make.centerY.mas_equalTo(backBtn);
    }];
    
}

- (void)setupUI{
    
    if (self.colorStr.length == 0) {
        Alertmsg(@"当前无色系", nil)
    }else{
        
        NSArray *titleArr = [self.colorStr componentsSeparatedByString:@","];
        
        NSMutableArray *vcMarr=[NSMutableArray array];
        
        for (NSString *str in titleArr) {
            YPAllFangAnController *vc = [[YPAllFangAnController alloc]init];
            vc.colorStr = str;
            [vcMarr addObject:vc];
        }
        
        if (!self.pageView) {
            self.pageView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) WithTitles:titleArr WithObjects:vcMarr];
            self.pageView.titleFont = 15;
            self.pageView.underlineColor = RGB(236, 67, 86);
            [self.view addSubview:self.pageView];
        }
    }
}

#pragma mark - 按钮点击事件
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBtnClick{
    NSLog(@"searchBtnClick");
    
    YPFASearchController *search = [[YPFASearchController alloc]init];
    search.planType = @"2";
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark - 网络请求
#pragma mark 获取色系列表
- (void)getColorList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/PlanColorList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"EmployeeID"]   = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            self.colorStr = [object valueForKey:@"Color"];//以逗号分隔的色系
            [self setupUI];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
    
}

#pragma mark - getter
- (NSString *)colorStr{
    if (!_colorStr) {
        _colorStr = [[NSString alloc]init];
    }
    return _colorStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
