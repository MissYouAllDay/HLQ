//
//  YPEDuBaseController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/16.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPEDuBaseController.h"
#import "YPReHomeFuLiCell.h"
#import "YPEDuCountCell.h"
#import "YPEDuGoodsListCell.h"
#import "YPEDuGoodDetailController.h"//商品详情
#import "YPEDuApplyGiftController.h"//申请礼品
#import "YPEDuApplySucView.h"
#import "YPEDuGoodsAllListController.h"//全部礼品列表
#import "YPEDuShoppingCartController.h"//购物车
#import "YPGetCommodityTypeTableList.h"//模型
#import "YPGetUserQuotas.h"//额度模型
#import "YPEDuRulesController.h"//规则

@interface YPEDuBaseController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
/**遮罩*/
@property (nonatomic, strong) UIControl *control;
@property (nonatomic, strong) YPGetUserQuotas *quotasModel;
@property (nonatomic, strong) NSMutableArray<YPGetCommodityTypeTableList *> *listMarr;

@end

@implementation YPEDuBaseController{
    UIView *_navView;
    YPEDuApplySucView *_sucView;
    UIButton *shopCarBtn;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
    
    [self GetUserQuotas];

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
    
    if (self.typeStr.integerValue == 0) {//0伴手礼,1婚礼返还,2代收
        titleLab.text = @"伴手礼";
    }else if (self.typeStr.integerValue == 1) {//0伴手礼,1婚礼返还,2代收
        titleLab.text = @"婚礼返还";
    }else if (self.typeStr.integerValue == 2) {//0伴手礼,1婚礼返还,2代收
        titleLab.text = @"代收";
    }
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    shopCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shopCarBtn  setImage:[UIImage imageNamed:@"购物车"] forState:UIControlStateNormal];
    [shopCarBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:shopCarBtn];
    [shopCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
    
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
    
//    UIView *colorView = [[UIView alloc] init];
//    [colorView setFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight/2.0)];
//    [self.view addSubview:colorView];
//
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = colorView.bounds;
//    gradient.colors = [NSArray arrayWithObjects:
//                       (id)RGB(239, 92, 154).CGColor,
//                       (id)RGB(240, 148, 188).CGColor,
//                       (id)[UIColor whiteColor].CGColor, nil];
//    [colorView.layer addSublayer:gradient];
    
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
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2+self.listMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0 || section == 1) {
        return 1;
    }else{
        
        return self.listMarr[section-2].Data.count >= 1 ? 1 : self.listMarr[section-2].Data.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        YPReHomeFuLiCell *cell = [YPReHomeFuLiCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.quotasModel.HeadImg.length > 0) {
            cell.urlArr = @[self.quotasModel.HeadImg];
        }else{
            cell.urlArr = @[];
        }
//        cell.scrollView.layer.cornerRadius = 10;
//        cell.scrollView.clipsToBounds = YES;
        cell.scrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.8);//5-22 2:1 18-08-21 修改 18-09-17 修改0.8
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else if (indexPath.section == 1){
        YPEDuCountCell *cell = [YPEDuCountCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        if (self.quotasModel.IsUse == 0) {//0未使用,1已使用 18-09-17 去掉
            cell.eDuCount.text = [NSString stringWithFormat:@"%zd",self.quotasModel.Quota];
//        }else if (self.quotasModel.IsUse == 1){
//            cell.eDuCount.text = @"已使用";
//        }
        
        //18-09-20 只有婚礼返还有申请额度
        if (self.typeStr.intValue == 1) {//0伴手礼,1婚礼返还,2代收
            cell.applyBtn.hidden = NO;
        }else{
            cell.applyBtn.hidden = YES;
        }
        
        [cell.applyBtn addTarget:self action:@selector(applyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.ruleBtn addTarget:self action:@selector(ruleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else {
        
        YPGetCommodityTypeTableList *listModel = self.listMarr[indexPath.section - 2];
        YPGetCommodityTypeTableListData *dataModel = listModel.Data[indexPath.row];
        
        //18-08-21 修改样式
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc] init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imgV = [[UIImageView alloc]init];
        [imgV sd_setImageWithURL:[NSURL URLWithString:dataModel.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        [cell.contentView addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(cell.contentView);
            make.height.mas_equalTo(ScreenWidth*0.5);
        }];
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;
        [cell.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imgV.mas_bottom);
            make.left.right.mas_equalTo(imgV);
            make.height.mas_equalTo(10);
        }];
        
        return cell;
        
//        YPEDuGoodsListCell *cell = [YPEDuGoodsListCell cellWithTableView:tableView];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        if ((indexPath.section-2) % 6 == 0){
//            cell.colorArr = [NSArray arrayWithObjects:
//                             (id)RGB(75, 200, 255).CGColor,
//                             (id)RGB(126, 214, 252).CGColor,
//                             (id)[UIColor whiteColor].CGColor, nil];
//        }else if ((indexPath.section-2) % 6 == 1){
//            cell.colorArr = [NSArray arrayWithObjects:
//                             (id)RGB(255, 81, 147).CGColor,
//                             (id)[UIColor colorWithRed:1.00 green:0.52 blue:0.67 alpha:1.00].CGColor,
//                             (id)[UIColor whiteColor].CGColor, nil];
//        }else if ((indexPath.section-2) % 6 == 2){
//            cell.colorArr = [NSArray arrayWithObjects:
//                             (id)RGB(255, 91, 198).CGColor,
//                             (id)[UIColor colorWithRed:0.99 green:0.60 blue:0.85 alpha:1.00].CGColor,
//                             (id)[UIColor whiteColor].CGColor, nil];
//        }else if ((indexPath.section-2) % 6 == 3){
//            cell.colorArr = [NSArray arrayWithObjects:
//                             (id)RGB(185, 106, 255).CGColor,
//                             (id)[UIColor colorWithRed:0.82 green:0.64 blue:0.99 alpha:1.00].CGColor,
//                             (id)[UIColor whiteColor].CGColor, nil];
//        }else if ((indexPath.section-2) % 6 == 4){
//            cell.colorArr = [NSArray arrayWithObjects:
//                             (id)RGB(255, 119, 103).CGColor,
//                             (id)[UIColor colorWithRed:0.99 green:0.66 blue:0.63 alpha:1.00].CGColor,
//                             (id)[UIColor whiteColor].CGColor, nil];
//        }else if ((indexPath.section-2) % 6 == 5){
//            cell.colorArr = [NSArray arrayWithObjects:
//                             (id)RGB(99, 219, 204).CGColor,
//                             (id)[UIColor colorWithRed:0.62 green:0.91 blue:0.87 alpha:1.00].CGColor,
//                             (id)[UIColor whiteColor].CGColor, nil];
//        }
//
//        cell.dataArr = listModel.Data;
//        [cell.goodsView reloadData];
//        cell.listModel = listModel;
//
////        NSLog(@"section -- %zd, dataCount -- %zd",indexPath.section,listModel.Data.count);
//
////        cell.goodsView.delegate = self;
////        cell.goodsView.dataSource = self;
//
//        cell.colCellClick = ^(NSString *sectionName, NSIndexPath *indexPath) {
//            NSLog(@"colCellClick -- %@ -- %@",sectionName,indexPath);
//
//            YPGetCommodityTypeTableListData *dataModel = listModel.Data[indexPath.item];
//
//            YPEDuGoodDetailController *detail = [[YPEDuGoodDetailController alloc]init];
//            detail.commodityId = dataModel.CommodityId;
//
//            detail.willShowCart = YES;//显示购物车
//
//            [self.navigationController pushViewController:detail animated:YES];
//        };
//        cell.allBtn.tag = indexPath.section + 1000;
//        [cell.allBtn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return ScreenWidth*0.8;//18-09-17
    }else if (indexPath.section == 1) {
        return 100;
    }else{
//        return 225+10;
        return ScreenWidth*0.5+10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 0.1;
    }else{
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    
    if (section == 0 || section == 1) {
        view.backgroundColor = CHJ_bgColor;
    }else{
        YPGetCommodityTypeTableList *listModel = self.listMarr[section - 2];
        
        view.backgroundColor = WhiteColor;
        UILabel *label = [[UILabel alloc]init];
        if (listModel.TypeName.length > 0) {
            label.text = listModel.TypeName;
        }else{
            label.text = @"无名称";
        }
        label.font = kFont(18);
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(13);
            make.top.mas_equalTo(15);
        }];
        
//        UIButton *moreBtn = [[UIButton alloc]init];
//        [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
//        [moreBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
//        moreBtn.titleLabel.font = kFont(14);
//        moreBtn.tag = section + 1000;
//        [moreBtn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:moreBtn];
//        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(label);
//            make.right.mas_equalTo(-14);
//        }];
        
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        
    }else{
        
        YPGetCommodityTypeTableList *listModel = self.listMarr[indexPath.section - 2];
        
        YPEDuGoodsAllListController *all = [[YPEDuGoodsAllListController alloc]init];
        all.titleStr = listModel.TypeName;
        all.typeId = listModel.TypeId;
        all.CarCount = self.quotasModel.CarCount;
        
        all.willShowCart = YES;//显示购物车
        
        all.ActivityIdType = self.typeStr;
        
        [self.navigationController pushViewController:all animated:YES];
        
//        YPGetCommodityTypeTableList *listModel = self.listMarr[indexPath.section - 2];
//        YPGetCommodityTypeTableListData *dataModel = listModel.Data[indexPath.item];
//
//        YPEDuGoodDetailController *detail = [[YPEDuGoodDetailController alloc]init];
//        detail.commodityId = dataModel.CommodityId;
//        detail.willShowCart = YES;//显示购物车
//        [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"购物车");
    
    YPEDuShoppingCartController *shop = [[YPEDuShoppingCartController alloc]init];
    shop.ActivityIdType = self.typeStr;
    [self.navigationController pushViewController:shop animated:YES];
}

- (void)ruleBtnClick{
    NSLog(@"规则");
    
    YPEDuRulesController *rule = [[YPEDuRulesController alloc]init];
    rule.ruleStr = self.quotasModel.RulesActivity;
    [self.navigationController pushViewController:rule animated:YES];
}

- (void)applyBtnClick{
    NSLog(@"申请礼品");
    YPEDuApplyGiftController *apply = [[YPEDuApplyGiftController alloc]init];
    apply.submitBlock = ^{
        [self.view addSubview:self.control];
    };
    [self.navigationController pushViewController:apply animated:YES];
}

- (void)allBtnClick:(UIButton *)sender{
    NSLog(@"allBtnClick: -- %zd",sender.tag);
    
    YPGetCommodityTypeTableList *listModel = self.listMarr[sender.tag - 2 - 1000];
    
    YPEDuGoodsAllListController *all = [[YPEDuGoodsAllListController alloc]init];
    all.titleStr = listModel.TypeName;
    all.typeId = listModel.TypeId;
    all.CarCount =self.quotasModel.CarCount;
    
    all.willShowCart = YES;//显示购物车
    
    all.ActivityIdType = self.typeStr;
    
    [self.navigationController pushViewController:all animated:YES];
    
}

- (void)controlClick{
    
    [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _sucView.y = ScreenHeight;
    } completion:^(BOOL finished) {
        [self.control removeFromSuperview];
    }];
}

#pragma mark - 网络请求
#pragma mark 用户获取额度
- (void)GetUserQuotas{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetUserQuotas";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    params[@"Type"] = self.typeStr;//0伴手礼,1婚礼返还,2代收
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.quotasModel.Quota          = [[object valueForKey:@"Quota"] integerValue];
//            self.quotasModel.IsUse          = [[object valueForKey:@"IsUse"] integerValue];//0未使用,1已使用
            self.quotasModel.RulesActivity  = [object valueForKey:@"RulesActivity"];
            self.quotasModel.HeadImg        = [object valueForKey:@"HeadImg"];
            self.quotasModel.CarCount =[[object valueForKey:@"CarCount"]integerValue];

            if (self.quotasModel.Quota > 0 && self.typeStr.integerValue == 0) {//0伴手礼,1婚礼返还,2代收
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"婚宴伴手礼\n在交付酒店定金后一个周内领取有效" message:nil delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                [alert show];
            }
            
            [self GetCommodityTypeTableList];
            [shopCarBtn  yee_MakeBadgeText:[NSString stringWithFormat:@"%zd",self.quotasModel.CarCount] textColor:[UIColor whiteColor] backColor:[UIColor redColor] Font:[UIFont systemFontOfSize:12]];
            
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

#pragma mark 获取类别-商品列表
- (void)GetCommodityTypeTableList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetCommodityTypeTableList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Type"] = @"1";//类型(0：全部，1上架，2下架)
    if (self.typeStr.integerValue == 0) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_banShouLi;
    }else if (self.typeStr.integerValue == 1) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_hunLiFanHuan;
    }else if (self.typeStr.integerValue == 2) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_daiShou;
    }
    
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
            
            [self.tableView reloadData];
            
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
- (UIControl *)control{
    if (!_control) {
        _control = [[UIControl alloc]initWithFrame:self.view.frame];
        _control.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        if (!_sucView) {
            _sucView = [YPEDuApplySucView yp_eDuApplySucView];
        }
//        [_sucView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.mas_equalTo(_control);
////            make.left.mas_equalTo(35);
////            make.right.mas_equalTo(-35);
//        }];
    }
    
    _sucView.centerX = ScreenWidth/2.0;
    _sucView.y = ScreenHeight;
    
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _sucView.center = CGPointMake(ScreenWidth/2.0, ScreenHeight/2.0);
        [_control addSubview:_sucView];
    } completion:nil];
    
    [_control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [_sucView.knowBtn addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    return _control;
}

- (NSMutableArray<YPGetCommodityTypeTableList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (YPGetUserQuotas *)quotasModel{
    if (!_quotasModel) {
        _quotasModel = [[YPGetUserQuotas alloc]init];
    }
    return _quotasModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)listView {
    
    return self.view;
}

@end
