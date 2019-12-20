//
//  YPHome190226FindSupplierController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/26.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHome190226FindSupplierController.h"
#import <JXCategoryTitleView.h>
#import <JXCategoryIndicatorImageView.h>
#import <JXCategoryListContainerView.h>
#import "HRHomeSearchViewController.h"
#import "HRZHiYeModel.h"
#import "YPHome190226FindSupplierListController.h"
//#import "YPMoreBtnControl.h"

#define UnselectedColor RGBS(248)
#define SelectedColor RGB(250, 80, 120)

@interface YPHome190226FindSupplierController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) UIControl *control;

// 按钮数组
@property (nonatomic, strong) NSMutableArray *btnArray;
// 选中按钮
@property (nonatomic, copy) NSString *profession;//编号
@property (nonatomic, copy) NSString *professionName;//职业

@property (nonatomic, strong) NSMutableArray<HRZHiYeModel *> *zhiYeArr;

@end

@implementation YPHome190226FindSupplierController{
    UIView *_navView;
//    YPMoreBtnControl *control;
    UIView *_moreBackView;
    CGFloat _allHeight;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self getZhiYeList];
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
    
    [self setupNav];
    
}

#pragma mark - UI
- (void)setupUI{
    NSMutableArray *marr = [NSMutableArray array];
    for (HRZHiYeModel *model in self.zhiYeArr) {
        [marr addObject:model.OccupationName];
    }
    
    if (!self.myCategoryView) {
        self.myCategoryView = [[JXCategoryTitleView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth-40, 60)];
        self.myCategoryView.delegate = self;
        self.myCategoryView.titles = marr.copy;
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
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT+60, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-60-HOME_INDICATOR_HEIGHT);
    self.listContainerView.defaultSelectedIndex = 0;
    [self.view addSubview:self.listContainerView];
    //关联cotentScrollView，关联之后才可以互相联动！！！
    self.myCategoryView.contentScrollView = self.listContainerView.scrollView;
    
    UIButton *moreBtn = [[UIButton alloc]init];
    [moreBtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(39);
    }];
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = CHJ_bgColor;
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(moreBtn);
        make.width.mas_equalTo(1);
        make.right.mas_equalTo(moreBtn.mas_left);
    }];
    
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
    return self.zhiYeArr.count;
}
//返回遵从`JXCategoryListContentViewDelegate`协议的实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    HRZHiYeModel *model = self.zhiYeArr[index];
    YPHome190226FindSupplierListController *find = [[YPHome190226FindSupplierListController alloc] init];
    find.professionCode = model.OccupationID;
    return find;
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
    HRHomeSearchViewController *searchVC = [HRHomeSearchViewController new];
    searchVC.zhiYeArr = self.zhiYeArr;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)moreBtnClick{
    [self.view addSubview:self.control];
    
//    NSMutableArray *marr = [NSMutableArray array];
//    for (HRZHiYeModel *model in self.zhiYeArr) {
//        [marr addObject:model.OccupationName];
//    }
//    control = [[YPMoreBtnControl alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) AndTitleArr:marr.copy];
//    control.selectBlock = ^(NSString * _Nonnull select) {
//        NSLog(@"%@",select);
//    };
//    [control showControl];
    
}
//- (void)dealloc{
//    [control controlRemove];
//}
- (void)setupRadioBtnView{
    
    CGFloat marginX = 15;
    CGFloat top = 60;
    CGFloat btnH = 40;
    CGFloat width = (ScreenWidth-18*2-2*marginX)/3.0;
    NSInteger maxCol = 3;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (HRZHiYeModel *model in self.zhiYeArr) {
        [arr addObject:model.OccupationName];
    }
    NSInteger maxRow = arr.count / maxCol; //行
    _allHeight = top + maxRow * (btnH + marginX) + marginX + btnH;
    
    if (!_moreBackView) {
        _moreBackView = [[UIView alloc]init];
    }
    _moreBackView.backgroundColor = WhiteColor;
    
    _moreBackView.frame = CGRectMake(0, -(_allHeight), ScreenWidth, _allHeight);
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _moreBackView.frame = CGRectMake(0, 0, ScreenWidth, _allHeight);
        [_control addSubview:_moreBackView];
    } completion:nil];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"选择商家";
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [_moreBackView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18);
        make.centerX.mas_equalTo(_moreBackView);
    }];
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [_moreBackView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label);
        make.right.mas_equalTo(-18);
    }];
    
    // 循环创建按钮
    for (NSInteger i = 0; i < arr.count; i++) {
        
        UIButton *proBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        proBtn.backgroundColor = UnselectedColor;
        proBtn.layer.cornerRadius = 3.0; // 按钮的边框弧度
        proBtn.clipsToBounds = YES;
        proBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [proBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [proBtn setTitleColor:WhiteColor forState:UIControlStateSelected];
        [proBtn addTarget:self action:@selector(chooseMark:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger col = i % maxCol; //列
        proBtn.x = 18 + col * (width + marginX);
        NSInteger row = i / maxCol; //行
        proBtn.y = top + row * (btnH + marginX);
        proBtn.width = width;
        proBtn.height = btnH;
        [proBtn setTitle:arr[i] forState:UIControlStateNormal];
        
        if ([proBtn.titleLabel.text isEqualToString:self.professionName]){
            proBtn.selected = YES;
            proBtn.enabled = NO;
            [proBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
            proBtn.backgroundColor = SelectedColor;
        }else{
            proBtn.selected = NO;
            proBtn.enabled = YES;
            [proBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
            proBtn.backgroundColor = UnselectedColor;
        }
        
        [_moreBackView addSubview:proBtn];
        proBtn.tag = i;
        [self.btnArray addObject:proBtn];
    }
}

- (void)chooseMark:(UIButton *)sender {
    NSLog(@"点击了%@", sender.titleLabel.text);
    
    self.profession = [self.zhiYeArr[sender.tag] OccupationID];
    self.professionName = [self.zhiYeArr[sender.tag] OccupationName];
    
    sender.selected = !sender.selected;
    
    for (NSInteger j = 0; j < [self.btnArray count]; j++) {
        UIButton *btn = self.btnArray[j] ;
        if (sender.tag == j) {
            btn.selected = sender.selected;
            [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
        } else {
            btn.selected = NO;
            [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        }
        btn.backgroundColor = UnselectedColor;
    }
    
    UIButton *btn = self.btnArray[sender.tag];
    if (btn.selected) {
        btn.backgroundColor = SelectedColor;
        [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    } else {
        btn.backgroundColor = UnselectedColor;
        [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    }
    
    //调用点击方法
    [self.myCategoryView selectCellAtIndex:sender.tag selectedType:JXCategoryCellSelectedTypeClick];
    [self.listContainerView reloadData];
    
    [self controlClick];
}
- (void)controlClick{
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _moreBackView.frame = CGRectMake(0, -_allHeight, ScreenWidth, _allHeight);
    } completion:^(BOOL finished) {
        [self.btnArray removeAllObjects];
        [_moreBackView removeFromSuperview];
        _moreBackView = nil;
        [_control removeFromSuperview];
    }];
}

#pragma mark - 网络请求
#pragma mark 获取所有职业列表
- (void)getZhiYeList{
    NSString *url = @"/api/HQOAApi/GetAllOccupationList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    /**
     0、获取所有
     1、注册（不包含公司、用户、车手、员工）
     2、主页（不包含 用户、车手、员工）
     3、主页（不包含 用户、车手、员工,酒店）
     */
    params[@"Type"] = @"2";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [self.zhiYeArr removeAllObjects];
            self.zhiYeArr = [HRZHiYeModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];

            if (self.zhiYeArr.count > 0) {
                self.profession = [self.zhiYeArr[0] OccupationID];
                self.professionName = [self.zhiYeArr[0] OccupationName];
            }
            
            [self setupUI];
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark - getter
- (NSMutableArray<HRZHiYeModel *> *)zhiYeArr{
    if (!_zhiYeArr) {
        _zhiYeArr =[NSMutableArray array];
    }
    return _zhiYeArr;
}

#pragma mark - getter
- (UIControl *)control{
    if (!_control) {
        _control = [[UIControl alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
        _control.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    }
    [self setupRadioBtnView];
    [_control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    return _control;
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
