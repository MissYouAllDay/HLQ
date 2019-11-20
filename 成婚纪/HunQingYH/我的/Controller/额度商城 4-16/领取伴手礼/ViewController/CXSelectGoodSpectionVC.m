
//
//  CXSelectGoodSpectionVC.m
//  HunQingYH
//
//  Created by apple on 2019/9/29.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - - - - - 选择商品规格 - - - - - - - - - - - - - - - - - - 

#import "CXSelectGoodSpectionVC.h"
#import "CXGoodSpectionCell.h"
#import "CXShowDidSelectGoodsVC.h"

@interface CXSelectGoodSpectionVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation CXSelectGoodSpectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.name;
    [self setCellHeight];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.sureBtn];
    
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)setCellHeight {
    
    // name :line(25)  item : line(20)
    for (YPGetCommodityTypeTableListData *model in self.dataArr) {
        CGFloat hei = 0;
        NSString *spe = @"" ;
        for (CXSpecificationsModel *subModel in model.Data) {
            
            NSArray *arr = [subModel.Specifications componentsSeparatedByString:@"，"];
            hei = hei + Line375(25) + Line375(30) * (arr.count / 6 + 1);
            if (arr.count != 0) {
                spe = [spe stringByAppendingFormat: @"%@、",arr[0]];
            }
        }
        model.hei = hei + Line375(100);
        if (spe.length > 1) {
            model.selectSpe = [spe substringToIndex:spe.length - 1];
        }else {
            model.selectSpe = @"暂无规格";
        }
    }
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - HOME_INDICATOR_HEIGHT - 44 - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 100;
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        _tableView.backgroundColor =  [UIColor colorWithHexString:@"#F5F5F5"];
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

#pragma mark - - - - - - - - - - - - - - - 创建cell - - - - - - - - - - - - - - - - -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    CXGoodSpectionCell *cell = [[CXGoodSpectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CXGoodSpectionCell"];
    cell.model = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - - - - - - - - - - - - - - - TableViewDelegate - - - - - - - - - - - - - - - - -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    YPGetCommodityTypeTableListData *model = self.dataArr[indexPath.row];
    return model.hei;
}

- (UIButton *)sureBtn {
    
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame =  CGRectMake(0, ScreenHeight-44-HOME_INDICATOR_HEIGHT - NAVIGATION_BAR_HEIGHT, ScreenWidth,44);
        [_sureBtn setBackgroundImage:[UIImage gradientImageWithBounds:_sureBtn.frame andColors:@[[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0], [UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
        [_sureBtn setBackgroundImage:[UIImage gradientImageWithBounds:_sureBtn.frame andColors:@[[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0], [UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(pushShowSelectGoods) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (void)pushShowSelectGoods {
    
    CXShowDidSelectGoodsVC *vc = [[CXShowDidSelectGoodsVC alloc] init];
    vc.dataArr = self.dataArr;
    vc.packageId = self.packageId;
    vc.flowRecord = self.flowRecord;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
