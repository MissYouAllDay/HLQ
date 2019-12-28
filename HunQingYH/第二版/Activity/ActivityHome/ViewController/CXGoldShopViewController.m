//
//  TestViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "CXGoldShopViewController.h"
#import "JXCategoryTitleView.h"
#import "CXWeddingBackVC.h"
#import "YPGetCommodityTypeTableList.h" // model

@interface CXGoldShopViewController ()<JXCategoryViewDelegate>

@property (nonatomic, strong) UIView  *headerView;    // headerView
@property (nonatomic, strong) UILabel  *moneyLab;    // 积分金额
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) NSMutableArray  *listMarr;    // <#这里是个注释哦～#>


@end

@implementation CXGoldShopViewController

- (void)viewDidLoad {
   

    [super viewDidLoad];
    
    self.title = @"立返商家";
    [self.view addSubview:self.headerView];
    [self GetCommodityTypeTableList];
}

- (void)confierData {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (YPGetCommodityTypeTableList *model in self.listMarr) {
        
        [array addObject:model.TypeName];
    }
    self.titles = array;
    [self configerUI];

}

- (void)configerUI {
    if (self.titles == nil) { self.titles = @[]; }

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

    if (self.categoryView) {
        self.categoryView.frame = CGRectMake(0, self.headerView.bottom, self.view.bounds.size.width, [self preferredCategoryViewHeight]);
        self.listContainerView.frame = CGRectMake(0, self.categoryView.bottom, self.view.bounds.size.width, self.view.bounds.size.height - self.categoryView.bottom - HOME_INDICATOR_HEIGHT);
    }
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
    
    YPGetCommodityTypeTableList *model = self.listMarr[index];
    CXWeddingBackVC *list = [[CXWeddingBackVC alloc] init];
    list.categoryId = model.TypeId;
    return list;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

// MARK: - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    
    NSLog(@"你点击了老%ld",index);
    
}

- (UIView *)listView {
    
    return self.view;
}


#pragma mark 获取类别-商品列表
- (void)GetCommodityTypeTableList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetCommodityTypeTableList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Type"] = @"1";//类型(0：全部，1上架，2下架)
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"YPGetCommodityTypeTableList --- %@",object);
            
            self.listMarr = [YPGetCommodityTypeTableList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            NSArray *arr = [NSArray arrayWithArray:self.listMarr.copy];
            for (YPGetCommodityTypeTableList *listModel in arr) {
                if (listModel.Data.count == 0) {
                    [self.listMarr removeObject:listModel];
                }
            }
            [self confierData];
            
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

// MARK: - lazy
- (UIView *)headerView {
    
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(185))];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:_headerView.bounds];
        img.image = [UIImage imageNamed:@"婚礼返还banner"];
        
        UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(40))];
        la.text = @"额度";
        la.textAlignment = NSTextAlignmentCenter;
        la.textColor = [UIColor whiteColor];
        la.font = Font(15);
        
        UIButton *questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        questionBtn.frame = CGRectMake(ScreenWidth - 40, 0, Line375(40), Line375(40));
        [questionBtn setImage:[UIImage imageNamed:@"huodongguize"] forState:UIControlStateNormal];
        [questionBtn addTarget:self action:@selector(questionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(0, la.bottom, ScreenWidth, Line375(40))];
        self.moneyLab.font = FontW(15, UIFontWeightBold);
        self.moneyLab.textColor = [UIColor whiteColor];
        self.moneyLab.textAlignment = NSTextAlignmentCenter;
        self.moneyLab.text = @"0";
        
        [_headerView addSubview:la];
        [_headerView addSubview:questionBtn];
        [_headerView addSubview:self.moneyLab];
        
    }
    return _headerView;
}

- (void)questionBtnAction:(UIButton *)sender {
    
    NSLog(@"你点我干哈");
}

@end
