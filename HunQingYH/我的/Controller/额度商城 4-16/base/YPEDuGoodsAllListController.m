//
//  YPEDuGoodsAllListController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/18.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPEDuGoodsAllListController.h"
#import "YPEDuGoodsAllListColCell.h"
#import "YPEDuGoodDetailController.h"//商品详情
#import "YPGetCommodityList.h"
#import "YPEDuAllGiftListCell.h"

@interface YPEDuGoodsAllListController ()<UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic, strong) UICollectionView *colView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<YPGetCommodityList *> *listMarr;

@end

@implementation YPEDuGoodsAllListController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetCommodityList];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
    [self setupUI];
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
    titleLab.text = self.titleStr;
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
//    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [moreBtn  setImage:[UIImage imageNamed:@"购物车"] forState:UIControlStateNormal];
//    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_navView addSubview:moreBtn];
//    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_navView).mas_offset(-15);
//        make.centerY.mas_equalTo(backBtn.mas_centerY);
//    }];
//
//    UIButton *ruleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [ruleBtn setImage:[UIImage imageNamed:@"问号_gray"] forState:UIControlStateNormal];
//    [ruleBtn addTarget:self action:@selector(ruleBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_navView addSubview:ruleBtn];
//    [ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(moreBtn.mas_left).mas_offset(-10);
//        make.centerY.mas_equalTo(backBtn.mas_centerY);
//    }];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.itemSize = CGSizeMake((ScreenWidth-10-20)*0.5, (ScreenWidth-10-20)*0.5*1.25);
//    layout.minimumLineSpacing = 10;
//    layout.minimumInteritemSpacing = 10;
//
//    self.colView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, NAVIGATION_BAR_HEIGHT+1, ScreenWidth-20, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) collectionViewLayout:layout];
//    self.colView.backgroundColor = WhiteColor;
//    self.colView.delegate = self;
//    self.colView.dataSource = self;
//    [self.view addSubview:self.colView];
//
//    [self.colView registerNib:[UINib nibWithNibName:@"YPEDuGoodsAllListColCell" bundle:nil] forCellWithReuseIdentifier:@"YPEDuGoodsAllListColCell"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listMarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetCommodityList *listModel = self.listMarr[indexPath.row];
    
    //18-08-31 修改
    YPEDuAllGiftListCell *cell = [YPEDuAllGiftListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:listModel.ShowImage] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    if (listModel.PlaceOrigin.length > 0) {
        cell.placeLabel.text = listModel.PlaceOrigin;
    }else{
        cell.placeLabel.text = @"无产地";
    }
    if (listModel.CommodityName.length > 0) {
        cell.titleLabel.text = listModel.CommodityName;
    }else{
        cell.titleLabel.text = @"无名称";
    }
    
    cell.priceLabel.text = [NSString stringWithFormat:@"%zd",listModel.Quota];
    
    return cell;
    
//    //18-08-21 修改样式
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] init];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    UIImageView *imgV = [[UIImageView alloc]init];
//    [imgV sd_setImageWithURL:[NSURL URLWithString:listModel.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
//    [cell.contentView addSubview:imgV];
//    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.mas_equalTo(cell.contentView);
//        make.height.mas_equalTo(ScreenWidth*0.5);
//    }];
//
//    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = WhiteColor;
//    [cell.contentView addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(imgV.mas_bottom);
//        make.left.right.mas_equalTo(imgV);
//        make.height.mas_equalTo(10);
//    }];
//
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return ScreenWidth*0.5+10;
    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPGetCommodityList *listModel = self.listMarr[indexPath.row];

    YPEDuGoodDetailController *detail = [[YPEDuGoodDetailController alloc]init];
    detail.commodityId = listModel.CommodityId;

    detail.willShowCart = self.willShowCart;
    
    detail.ActivityIdType = self.ActivityIdType;//18-09-19

    [self.navigationController pushViewController:detail animated:YES];
}

//#pragma mark - UICollectionViewDataSource
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.listMarr.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    YPGetCommodityList *listModel = self.listMarr[indexPath.item];
//
//    YPEDuGoodsAllListColCell *cell = (YPEDuGoodsAllListColCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YPEDuGoodsAllListColCell" forIndexPath:indexPath];
//    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:listModel.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
//    if (listModel.CommodityName.length > 0) {
//        cell.titleLabel.text = listModel.CommodityName;
//    }else{
//        cell.titleLabel.text = @"无名称";
//    }
//    cell.priceLabel.text = [NSString stringWithFormat:@"¥ %zd",listModel.Quota];
//    return cell;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//
//    YPGetCommodityList *listModel = self.listMarr[indexPath.item];
//
//    YPEDuGoodDetailController *detail = [[YPEDuGoodDetailController alloc]init];
//    detail.commodityId = listModel.CommodityId;
//
//    detail.willShowCart = self.willShowCart;
//
//    [self.navigationController pushViewController:detail animated:YES];
//}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
#pragma mark 获取商品-型号列表
- (void)GetCommodityList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetCommodityList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Type"] = @"1";//类型(0：全部，1上架，2下架)
    params[@"TypeId"] = self.typeId;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPGetCommodityList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [self.tableView reloadData];
            
            if (self.listMarr.count == 0) {
                [EasyShowTextView showText:@"当前没有礼品"];
            }
            
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
- (NSMutableArray<YPGetCommodityList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
