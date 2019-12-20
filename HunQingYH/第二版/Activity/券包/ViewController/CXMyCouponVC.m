//
//  TestViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "CXMyCouponVC.h"
#import "JXCategoryTitleView.h"
#import "CXMyCouponListVC.h"    // kist
@interface CXMyCouponVC ()<JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;

@end

@implementation CXMyCouponVC

- (void)viewDidLoad {
    if (self.titles == nil) {
        self.titles = @[@"未使用", @"已使用", @"已过期"];
    }

    [super viewDidLoad];
    
    self.title = @"券包";
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)self.categoryView;
    titleCategoryView.titleColorGradientEnabled = NO;
    titleCategoryView.titleLabelMaskEnabled = YES;

     JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorWidth = JXCategoryViewAutomaticDimension;

    lineView.lineStyle = JXCategoryIndicatorLineStyle_LengthenOffset;
    titleCategoryView.indicators = @[lineView];
    self.myCategoryView.titles = self.titles;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.categoryView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.bounds.size.width, [self preferredCategoryViewHeight]);
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
    CXMyCouponListVC *list = [[CXMyCouponListVC alloc] init];
    list.conpouType = index;
    list.mainNa = self.navigationController;
    return list;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

// MARK: - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    
    NSLog(@"你点击了老%ld",index);
    
}

@end
