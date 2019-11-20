//
//  CXActivityHomeVC.m
//  HunQingYH
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXActivityHomeVC.h"
#import <JXCategoryTitleView.h>
#import <JXCategoryIndicatorImageView.h>
#import <JXCategoryListContainerView.h>
#import "HRHomeSearchViewController.h"

#import "CXReceiveMoneyVC.h"
#import "CXGiftViewController.h"
#import "YPEDuBaseController.h"
#import "CXWeddingBackVC.h"
//#import "YPMoreBtnControl.h"

#define UnselectedColor RGBS(248)
#define SelectedColor RGB(250, 80, 120)

@interface CXActivityHomeVC ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) UIControl *control;

// 按钮数组
@property (nonatomic, strong) NSMutableArray *btnArray;
// 选中按钮
@property (nonatomic, copy) NSString *profession;//编号
@property (nonatomic, copy) NSString *professionName;//职业
//顶部选择器
@property (nonatomic, strong) NSArray *topTitleArr;

@end

@implementation CXActivityHomeVC {
    UIView *_navView;
//    YPMoreBtnControl *control;
    UIView *_moreBackView;
    CGFloat _allHeight;
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
    self.topTitleArr = @[@"领现金",@"婚礼福利",@"丽人福利",@"宝妈福利",@"婚礼返还"];
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupUI{
    NSMutableArray *marr = [NSMutableArray array];
    if (!self.myCategoryView) {
        self.myCategoryView = [[JXCategoryTitleView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth-40, 60)];
        self.myCategoryView.delegate = self;
        self.myCategoryView.titles = self.topTitleArr;
        self.myCategoryView.titleColor = [UIColor lightGrayColor];
        self.myCategoryView.titleSelectedColor = [UIColor blackColor];
        self.myCategoryView.titleColorGradientEnabled = YES;
        self.myCategoryView.titleLabelZoomEnabled = YES;
        
        JXCategoryIndicatorImageView *indicatorImageView = [[JXCategoryIndicatorImageView alloc] init];
        indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"下划弧线"];
        self.myCategoryView.indicators = @[indicatorImageView];
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+59, ScreenWidth, 1)];
    line.backgroundColor = CHJ_bgColor;
    [self.view addSubview:line];
    [self.view addSubview:self.myCategoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
    self.listContainerView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT+60, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-60-HOME_INDICATOR_HEIGHT);
    self.listContainerView.defaultSelectedIndex = 0;
    [self.view addSubview:self.listContainerView];
    //关联cotentScrollView，关联之后才可以互相联动！！！
    self.myCategoryView.contentScrollView = self.listContainerView.scrollView;
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
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"找商家";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont systemFontOfSize:18];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.left.mas_equalTo(backBtn.mas_right).mas_offset(3);
    }];
    
    UIView *searchView = [[UIView alloc]init];
    searchView.backgroundColor =RGBS(248);
    searchView.clipsToBounds =YES;
    searchView.layer.cornerRadius =4;
    [_navView addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(36);
        make.centerX.mas_equalTo(_navView);
    }];
    //导航栏右边搜索按钮
    UIButton *searchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"home190223_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.left.mas_equalTo(14);
        make.centerY.mas_equalTo(searchView);
    }];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"输入商家名称";
    label.textColor = RGBS(190);
    label.font = kFont(13);
    [searchView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(searchBtn);
        make.left.mas_equalTo(searchBtn.mas_right).mas_offset(10);
        make.right.mas_greaterThanOrEqualTo(-10);
    }];
    UIButton *clearBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.backgroundColor =[UIColor clearColor];
    [clearBtn setTitle:@"" forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(searchView.mas_right);
        make.left.mas_equalTo(searchBtn.mas_right);
        make.centerY.mas_equalTo(searchView);
    }];
}

#pragma mark - JXCategoryListContainerViewDelegate
//返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.topTitleArr.count;
}
//返回遵从`JXCategoryListContentViewDelegate`协议的实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
   
    switch (index) {
        case 0:  return [self receiveMoney];
        case 1:  return [self giftViewController:@[@"晨袍",@"对戒",@"牵手"] withIds:@[@"1",@"2",@"3"]];
        case 2:  return [self giftViewController:@[@"美甲",@"婚礼福利banner",@"美妆"] withIds:@[@"1",@"2",@"3"]];
        case 3:  return [self giftViewController:@[@"游泳",@"宝宝照",@"宝妈福利-banner"] withIds:@[@"1",@"2",@"3"]];
        case 4: return [self payReturnVC];
        default: break;
    }
    return [self receiveMoney];
}

- (id)receiveMoney {
    CXReceiveMoneyVC *vc = [[CXReceiveMoneyVC alloc] init];
    return vc;
}

- (id)giftViewController:(NSArray *)dataArr withIds:(NSArray *)allIds{
    CXGiftViewController *vc = [[CXGiftViewController alloc] init];
    vc.dataArr = dataArr;
    vc.allIds = allIds;
    return vc;
}

- (id)payReturnVC {
    
    CXWeddingBackVC *vc = [[CXWeddingBackVC alloc] init];
    return vc;
    YPEDuBaseController *edu = [[YPEDuBaseController alloc]init];
      edu.typeStr = @"1";//婚礼返还
    return edu;
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchBtnClick{
//    HRHomeSearchViewController *searchVC = [HRHomeSearchViewController new];
//    searchVC.zhiYeArr = self.zhiYeArr;
//    [self.navigationController pushViewController:searchVC animated:YES];
}

@end
