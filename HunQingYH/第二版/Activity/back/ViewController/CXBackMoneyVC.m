//
//  TestViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "CXBackMoneyVC.h"
#import "JXCategoryTitleView.h"
#import "CXBackMoneyListVC.h"
#import "CXAreaData.h"
@interface CXBackMoneyVC ()<JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) JXCategoryTitleView  *topTitleView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) NSArray  *segmentData;    // 商家，婚庆，婚宴
@end

@implementation CXBackMoneyVC

- (void)viewDidLoad {
    if (self.titles == nil) {
        CXAreaData *areaData = [CXAreaData shareAreaData];
        self.titles = areaData.citysArr;
    }
    if (self.segmentData == nil) {
        self.segmentData = @[@"酒店",@"婚庆",@"婚纱"];
    }

    [super viewDidLoad];
    
    self.title = @"立返商家";
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)self.categoryView;
    titleCategoryView.titleColorGradientEnabled = NO;
    titleCategoryView.titleLabelMaskEnabled = YES;

     JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorWidth = JXCategoryViewAutomaticDimension;

    lineView.lineStyle = JXCategoryIndicatorLineStyle_LengthenOffset;
    titleCategoryView.indicators = @[lineView];
    self.myCategoryView.titles = self.titles;
    [self.view addSubview:self.topTitleView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.topTitleView.frame = CGRectMake(0, 0, self.view.bounds.size.width, Line375(50));
    self.categoryView.frame = CGRectMake(0, self.topTitleView.bottom, self.view.bounds.size.width, [self preferredCategoryViewHeight]);
    self.listContainerView.frame = CGRectMake(0, self.categoryView.bottom, self.view.bounds.size.width, self.view.bounds.size.height - self.categoryView.bottom - HOME_INDICATOR_HEIGHT);
}
- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}
- (CGFloat)preferredCategoryViewHeight {
    
    return 50;
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    CXBackMoneyListVC *list = [[CXBackMoneyListVC alloc] init];
    list.type = index;
    return list;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

// MARK: - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    
    NSLog(@"你点击了老%ld",index);
    
}
// MARK: - 懒加载
- (JXCategoryTitleView *)topTitleView {
    
    if (!_topTitleView) {
        _topTitleView = [[JXCategoryTitleView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, Line375(40))];
        _topTitleView.titles = self.segmentData;
        _topTitleView.delegate = self;
        _topTitleView.titleColorGradientEnabled = YES;
        _topTitleView.titleSelectedColor = [UIColor redColor];
        _topTitleView.titleLabelStrokeWidthEnabled = YES;
    
       _topTitleView.titleLabelMaskEnabled = YES;
       JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
       backgroundView.indicatorWidthIncrement = 20; // 宽度增加
       backgroundView.indicatorHeight = 30;     // 高度
        backgroundView.indicatorCornerRadius = 4;
        backgroundView.indicatorColor = [UIColor orangeColor];
       _topTitleView.indicators = @[backgroundView];
    }
    return _topTitleView;
}


@end
