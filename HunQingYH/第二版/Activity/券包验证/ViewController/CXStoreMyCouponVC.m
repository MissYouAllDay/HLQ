//
//  TestViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "CXStoreMyCouponVC.h"
#import "JXCategoryTitleView.h"
#import "CXStoreMyCouponListVC.h"        // 已验证
#import "CXStoreMyCouponNotListVC.h"    // 未验证
#import "CXStoreMyCouponTopView.h"  // 顶部统计视图
@interface CXStoreMyCouponVC ()<JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) CXStoreMyCouponTopView  *topView;    // 顶部视图

@end

@implementation CXStoreMyCouponVC

- (void)viewDidLoad {
    if (self.titles == nil) {
        self.titles = @[@"已验证", @"未验证"];
    }

    [super viewDidLoad];
    
    self.title = @"领券情况";
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)self.categoryView;
    titleCategoryView.titleColorGradientEnabled = NO;
    titleCategoryView.titleLabelMaskEnabled = YES;

     JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorWidth = JXCategoryViewAutomaticDimension;

    lineView.lineStyle = JXCategoryIndicatorLineStyle_Lengthen;
    titleCategoryView.indicators = @[lineView];
    titleCategoryView.separatorLineShowEnabled = YES;
    self.myCategoryView.titles = self.titles;
    [self.view addSubview:self.topView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.topView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.bounds.size.width, 110);
    self.categoryView.frame = CGRectMake(0, self.topView.bottom, self.view.bounds.size.width, [self preferredCategoryViewHeight]);
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

    if (index == 0) {
        CXStoreMyCouponListVC *list = [[CXStoreMyCouponListVC alloc] init];
        list.mainNa = self.navigationController;
        return list;
    }else {
        CXStoreMyCouponNotListVC *list = [[CXStoreMyCouponNotListVC alloc] init];
        list.mainNa = self.navigationController;
        return list;
    }
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

// MARK: - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    
    NSLog(@"你点击了老%ld",index);
    
}
// MARK: - 懒加载
- (CXStoreMyCouponTopView *)topView {
    
    if (!_topView) {
        _topView = [[[NSBundle mainBundle] loadNibNamed:@"CXStoreMyCouponTopView" owner:nil options:nil] lastObject];
    }
    return _topView;
}


@end
