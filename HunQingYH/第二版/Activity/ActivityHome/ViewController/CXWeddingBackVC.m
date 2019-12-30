//
//  CXWeddingBackVC.m
//  HunQingYH
//
//  Created by canxue on 2019/11/11.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXWeddingBackVC.h"
#import "CXWeddingBackItem.h"
#import "SegMentView.h"
#import "YPGetCommodityTypeTableList.h" //model

#import "YPEDuGoodDetailController.h"   // 商品详情

@interface CXWeddingBackVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JXCategoryViewDelegate>

@property (nonatomic, strong) UICollectionView  *collectionView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) SegMentView  *segmentView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) UIView  *headerView;    // headerView
@property (nonatomic, strong) UILabel  *moneyLab;    // 积分金额
@property (nonatomic, strong) JXCategoryTitleView  *topTitleView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) NSMutableArray<YPGetCommodityTypeTableList *>  *listMarr;    // 分类数据
@property (nonatomic, strong) NSArray<YPGetCommodityTypeTableListData *>  *showDataArr;    // 展示的数据
@end

@implementation CXWeddingBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.collectionView];
    
    [self GetCommodityTypeTableList];
}

- (void)confierData {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (YPGetCommodityTypeTableList *model in self.listMarr) {
        
        [array addObject:model.TypeName];
    }
    
    if (!_topTitleView) {
        [self configerTopTitleView:array];
    }
    self.showDataArr = self.listMarr[0].Data;
    [self.collectionView reloadData];
}

- (void)configerTopTitleView:(NSArray *)titles {
    if (!_topTitleView) {
        _topTitleView = [[JXCategoryTitleView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom - Line375(40), [UIScreen mainScreen].bounds.size.width, Line375(40))];
    }
    self.topTitleView.delegate = self;
    self.topTitleView.titles = titles;
    _topTitleView.titleColorGradientEnabled = YES;
    _topTitleView.titleSelectedColor = [CXUtils colorWithHexString:@"#FD0047"];
    _topTitleView.titleLabelStrokeWidthEnabled = YES;
    
    _topTitleView.titleLabelMaskEnabled = YES;
    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorWidthIncrement = 20; // 宽度增加
    backgroundView.indicatorHeight = 30;     // 高度
    backgroundView.indicatorCornerRadius = 4;
    backgroundView.indicatorColor = [CXUtils colorWithHexString:@"#FCE1E9"];
    _topTitleView.indicators = @[backgroundView];
    [self.view addSubview:self.topTitleView];
}

// MARK: - HTTP
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

// MARK: - Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.showDataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CXWeddingBackItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"CXWeddingBackItem" forIndexPath:indexPath];
    item.model = self.showDataArr[indexPath.item];
    return item;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YPGetCommodityTypeTableListData *listModel = self.showDataArr[indexPath.row];
    
    YPEDuGoodDetailController *detail = [[YPEDuGoodDetailController alloc]init];
    detail.commodityId = listModel.CommodityId;
    
    detail.willShowCart = YES;
    
    detail.ActivityIdType = @"1";
    [self.navigationController pushViewController:detail animated:YES];
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake((ScreenWidth - Line375(45))/2, Line375(240));
        flow.sectionInset = UIEdgeInsetsMake(Line375(15), Line375(15), Line375(15), Line375(15));
        flow.minimumLineSpacing = Line375(10);
        flow.minimumInteritemSpacing = Line375(10);
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, ScreenWidth, ScreenHeight - self.headerView.bottom - HOME_INDICATOR_HEIGHT) collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"CXWeddingBackItem" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CXWeddingBackItem"];
    }
    return _collectionView;
}

- (UIView *)listView {
    
    return self.view;
}

// MARK: - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    
    self.showDataArr = self.listMarr[index].Data;
    [self.collectionView reloadData];
    
}

// MARK: - lazy
- (UIView *)headerView {
    
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(130))];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:_headerView.bounds];
        img.image = [UIImage imageNamed:@"婚礼返还banner"];
        
        UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(30))];
        la.text = @"额度";
        la.textAlignment = NSTextAlignmentCenter;
        la.textColor = [UIColor whiteColor];
        la.font = Font(17);
        
        UIButton *questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        questionBtn.frame = CGRectMake(ScreenWidth - 40, la.top, Line375(40), Line375(40));
        [questionBtn setImage:[UIImage imageNamed:@"huodongguize"] forState:UIControlStateNormal];
        [questionBtn addTarget:self action:@selector(questionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(0, la.bottom, ScreenWidth, Line375(40))];
        self.moneyLab.font = FontW(20, UIFontWeightBold);
        self.moneyLab.textColor = [UIColor whiteColor];
        self.moneyLab.textAlignment = NSTextAlignmentCenter;
        self.moneyLab.text = @"0";
        
        [_headerView addSubview:img];
        [_headerView addSubview:la];
        [_headerView addSubview:questionBtn];
        [_headerView addSubview:self.moneyLab];
        
    }
    return _headerView;
}

- (void)questionBtnAction:(UIButton *)sender {
     
    // 这里跳转活动规则界面
    [EasyShowTextView showText:@"更多活动准备中...."];
}

@end
