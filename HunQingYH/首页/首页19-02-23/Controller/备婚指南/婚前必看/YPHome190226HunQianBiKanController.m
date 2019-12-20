//
//  YPHome190226HunQianBiKanController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/26.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHome190226HunQianBiKanController.h"
#import <JXCategoryTitleView.h>
#import <JXCategoryListContainerView.h>
#import "YPGetWeddingInformationList.h"
#import <JXCategoryIndicatorBackgroundView.h>
#import "JXGradientView.h"
#import "YPHome190226HunQianBiKanListController.h"

@interface YPHome190226HunQianBiKanController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

//备婚笔记
///标题模型数组
@property (nonatomic, strong) NSMutableArray<YPGetWeddingInformationList *> *titleMarr;
///标题数组
@property (nonatomic, strong) NSMutableArray *tagMarr;

@end

@implementation YPHome190226HunQianBiKanController{
    UIView *_navView;
    //备婚笔记
    __block NSString *_WeddingInformationID;//当前标题ID
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [self GetWeddingInformationList];
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

- (void)setIsSubViews:(BOOL)isSubViews {
    
    _isSubViews = isSubViews;
     [_navView removeFromSuperview];
     [self GetWeddingInformationList];
}

#pragma mark - UI
- (void)setupUI{
    
    CGFloat top = self.isSubViews == YES ? 0 : NAVIGATION_BAR_HEIGHT;
  
    if (!self.myCategoryView) {
        self.myCategoryView = [[JXCategoryTitleView alloc]initWithFrame:CGRectMake(0, top, ScreenWidth, 60)];
        self.myCategoryView.delegate = self;
        self.myCategoryView.titles = self.tagMarr.copy;
        self.myCategoryView.titleColor = RGBS(102);
        self.myCategoryView.titleSelectedColor = [UIColor whiteColor];
        self.myCategoryView.titleColorGradientEnabled = YES;
        self.myCategoryView.titleLabelZoomEnabled = NO;
//        self.myCategoryView.titleLabelStrokeWidthEnabled = YES;
        JXCategoryIndicatorBackgroundView *bgView = [[JXCategoryIndicatorBackgroundView alloc] init];
        //相当于把JXCategoryIndicatorBackgroundView当做视图容器，你可以在上面添加任何想要的效果
        JXGradientView *gradientView = [[JXGradientView alloc]init];
        gradientView.gradientLayer.endPoint = CGPointMake(1, 0);
        gradientView.gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:253/255.0 green:117/255.0 blue:95/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:250/255.0 green:80/255.0 blue:120/255.0 alpha:1.0].CGColor];
        //设置gradientView布局和JXCategoryIndicatorBackgroundView一样
        gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [bgView addSubview:gradientView];
        
        bgView.indicatorHeight = 32;
        bgView.indicatorCornerRadius = 4;
        bgView.clipsToBounds = YES;
        self.myCategoryView.indicators = @[bgView];
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, top+59, ScreenWidth, 1)];
    line.backgroundColor = CHJ_bgColor;
    [self.view addSubview:line];
    [self.view addSubview:self.myCategoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.frame = CGRectMake(0, top+60, ScreenWidth, ScreenHeight-top-60-HOME_INDICATOR_HEIGHT);
    self.listContainerView.defaultSelectedIndex = 0;
    [self.view addSubview:self.listContainerView];
    //关联cotentScrollView，关联之后才可以互相联动！！！
    self.myCategoryView.contentScrollView = self.listContainerView.scrollView;
    [self.myCategoryView reloadData];
    [self.listContainerView reloadData];
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
    titleLab.text = @"婚前必看";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont systemFontOfSize:18];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.centerX.mas_equalTo(_navView);
    }];
}

#pragma mark - JXCategoryListContainerViewDelegate
//返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titleMarr.count;
}
//返回遵从`JXCategoryListContentViewDelegate`协议的实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    YPGetWeddingInformationList *model = self.titleMarr[index];
    YPHome190226HunQianBiKanListController *list = [[YPHome190226HunQianBiKanListController alloc] init];
    list.articleID = model.WeddingInformationID;
    return list;
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

#pragma mark - 网络请求
#pragma mark 获取标题列表
- (void)GetWeddingInformationList{
    
    NSString *url = @"/api/HQOAApi/GetWeddingInformationList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.titleMarr removeAllObjects];
            [self.tagMarr removeAllObjects];
            
            self.titleMarr = [YPGetWeddingInformationList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            for (YPGetWeddingInformationList *info in self.titleMarr) {
                [self.tagMarr addObject:info.Title];
            }
            
            [self setupUI];
            
//            if (self.titleMarr.count > 0) {
//                YPGetWeddingInformationList *list = self.titleMarr[0];
//
//                //切换标题 清空数组
//                if (![list.WeddingInformationID isEqualToString:_WeddingInformationID]) {
//                    [self.articleMarr removeAllObjects];
//                }
//
//                _WeddingInformationID = list.WeddingInformationID;
//                [self GetInformationArticleListWithWeddingInformationId:list.WeddingInformationID];
//            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark - getter
- (NSMutableArray<YPGetWeddingInformationList *> *)titleMarr{
    if (!_titleMarr) {
        _titleMarr = [NSMutableArray array];
    }
    return _titleMarr;
}

- (NSMutableArray *)tagMarr{
    if (!_tagMarr) {
        _tagMarr = [NSMutableArray array];
        
    }
    return _tagMarr;
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
