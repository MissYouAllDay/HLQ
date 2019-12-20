//
//  YPReYQJHController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/23.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReYQJHController.h"
#import "YPGetCommodityTypeTableList.h"
#import "YPFreeWeddingMainTopCell.h"
#import "YPEDuGoodsListCell.h"
#import "YPActivityRulesCell.h"
#import "HRYQJHHeaderView.h"
#import "YPYQJLOtherInfoController.h"//填写资料
#import "YPEDuGoodDetailController.h"//商品详情
#import "YPEDuGoodsAllListController.h"//全部商品
#import "HRDLYQJLViewController.h"//邀请记录重做，也代理邀请统一
#import "HRDLZQViewController.h"

@interface YPReYQJHController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HRYQJHHeaderView *topView;

@property (nonatomic, strong) NSMutableArray<YPGetCommodityTypeTableList *> *listMarr;

@end

@implementation YPReYQJHController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 菊花不会自动消失，需要自己移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetCommodityTypeTableList];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_01"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1+self.listMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return self.listMarr[section-1].Data.count >= 1 ? 1 : self.listMarr[section-1].Data.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        YPActivityRulesCell *cell = [YPActivityRulesCell cellWithTableView:tableView];
        
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"邀请记录";
            cell.codeImgV.hidden = YES;
        }else if (indexPath.row == 1){
            cell.titleLabel.text = @"活动规则";
            cell.codeImgV.hidden = YES;
        }else if (indexPath.row == 2){
            cell.titleLabel.text = @"代理赚钱";
            cell.codeImgV.hidden = NO;
        }
        
        return cell;
    }else {
        
        YPGetCommodityTypeTableList *listModel = self.listMarr[indexPath.section - 1];
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
//        if ((indexPath.section-1) % 6 == 0){
//            cell.colorArr = [NSArray arrayWithObjects:
//                             (id)RGB(75, 200, 255).CGColor,
//                             (id)RGB(126, 214, 252).CGColor,
//                             (id)[UIColor whiteColor].CGColor, nil];
//        }else if ((indexPath.section-1) % 6 == 1){
//            cell.colorArr = [NSArray arrayWithObjects:
//                             (id)RGB(255, 81, 147).CGColor,
//                             (id)[UIColor colorWithRed:1.00 green:0.52 blue:0.67 alpha:1.00].CGColor,
//                             (id)[UIColor whiteColor].CGColor, nil];
//        }else if ((indexPath.section-1) % 6 == 2){
//            cell.colorArr = [NSArray arrayWithObjects:
//                             (id)RGB(255, 91, 198).CGColor,
//                             (id)[UIColor colorWithRed:0.99 green:0.60 blue:0.85 alpha:1.00].CGColor,
//                             (id)[UIColor whiteColor].CGColor, nil];
//        }else if ((indexPath.section-1) % 6 == 3){
//            cell.colorArr = [NSArray arrayWithObjects:
//                             (id)RGB(185, 106, 255).CGColor,
//                             (id)[UIColor colorWithRed:0.82 green:0.64 blue:0.99 alpha:1.00].CGColor,
//                             (id)[UIColor whiteColor].CGColor, nil];
//        }else if ((indexPath.section-1) % 6 == 4){
//            cell.colorArr = [NSArray arrayWithObjects:
//                             (id)RGB(255, 119, 103).CGColor,
//                             (id)[UIColor colorWithRed:0.99 green:0.66 blue:0.63 alpha:1.00].CGColor,
//                             (id)[UIColor whiteColor].CGColor, nil];
//        }else if ((indexPath.section-1) % 6 == 5){
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
//        cell.colCellClick = ^(NSString *sectionName, NSIndexPath *indexPath) {
//            NSLog(@"colCellClick -- %@ -- %@",sectionName,indexPath);
//            
//            YPGetCommodityTypeTableListData *dataModel = listModel.Data[indexPath.item];
//            
//            YPEDuGoodDetailController *detail = [[YPEDuGoodDetailController alloc]init];
//            detail.commodityId = dataModel.CommodityId;
//            
//            detail.willShowCart = NO;//不显示购物车
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
        return 50;
    }else{
//        return 225+10;
        return ScreenWidth*0.5+10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 340;
    }else{
//        return 0.1;
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        if (!_topView) {
            _topView =[HRYQJHHeaderView inviteView];
        }
        _topView.backgroundColor = WhiteColor;
        
        _topView.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:32];
        _topView.titleLabel.textColor = [UIColor colorWithRed:71.5/255 green:71.5/255 blue:71.5/255 alpha:1];
        _topView.yaoqingBtn.clipsToBounds = YES;
        _topView.yaoqingBtn.layer.cornerRadius = 3;
        [_topView.yaoqingBtn addTarget:self action:@selector(yaoqingClick) forControlEvents:UIControlEventTouchUpInside];
        _topView.fenxiangBtn.clipsToBounds = YES;
        _topView.fenxiangBtn.layer.cornerRadius = 3;
        _topView.fenxiangBtn.layer.borderWidth = 1;
        _topView.fenxiangBtn.layer.borderColor = MainColor.CGColor;
        [_topView.fenxiangBtn addTarget:self action:@selector(fenxiangClick) forControlEvents:UIControlEventTouchUpInside];
        return _topView;
    }else{
        UIView *view = [[UIView alloc]init];
        
        YPGetCommodityTypeTableList *listModel = self.listMarr[section - 1];
        
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
        
        return view;
    
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row ==0) {
            
            HRDLYQJLViewController *jlVC = [HRDLYQJLViewController new];
            jlVC.typeFlag =1;
            [self.navigationController presentViewController:jlVC animated:YES completion:nil];
            
        }else if (indexPath.row ==1){
            HRWebViewController *webVC =[HRWebViewController new];
            webVC.webUrl =@"http://www.chenghunji.com/Download/Rules/OtherFreeWedding.html";
            webVC.isShareBtn =NO;
            
            [self.navigationController pushViewController:webVC animated:YES];
            
        }else{
            
            HRDLZQViewController *DLVC = [HRDLZQViewController new];
            [self.navigationController pushViewController:DLVC animated:YES];
        }
    }else{
        
        YPGetCommodityTypeTableList *listModel = self.listMarr[indexPath.section - 1];
        
        YPEDuGoodsAllListController *all = [[YPEDuGoodsAllListController alloc]init];
        all.titleStr = listModel.TypeName;
        all.typeId = listModel.TypeId;
        //    all.CarCount = self.quotasModel.CarCount;
        
        all.willShowCart = NO;//不显示购物车
        
        [self.navigationController pushViewController:all animated:YES];
        
//        YPGetCommodityTypeTableList *listModel = self.listMarr[indexPath.section - 1];
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

- (void)yaoqingClick{
    NSLog(@"邀请");
    
    YPYQJLOtherInfoController *otherInfo = [[YPYQJLOtherInfoController alloc]init];
    [self.navigationController pushViewController:otherInfo animated:YES];
}

- (void)fenxiangClick{

    
    [HRShareView showShareViewWithPublishContent:@{@"title":@"邀好友来婚礼桥办婚礼，可赢取100元现金，可提现！",
                                                   @"text" :@"与好友一起起航，登上“小成梦想号”，赴免费盛宴，掌握赚钱秘籍，赢高额奖励金哦！",
                                                   @"image":@"http://121.42.156.151:93/FileGain.aspx?fi=b73de463-b243-4ac3-bfd2-37f40df12274&it=0",
                                                   @"url"  :@"http://www.chenghunji.com/Redbag/yqoqingjiehun"}
                                          Result:^(SSDKResponseState state, SSDKPlatformType type) {
                                              switch (state) {
                                                  case SSDKResponseStateSuccess:
                                                  {
                                                      if (type == SSDKPlatformSubTypeWechatTimeline) {
                                                          
                                                          
                                                          [EasyShowTextView showSuccessText:@"朋友圈分享成功"];
                                                      }
                                                      if (type == SSDKPlatformSubTypeWechatSession) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"微信好友分享成功"];
                                                      }
                                                      if (type == SSDKPlatformSubTypeQQFriend) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"QQ分享成功"];
                                                      }
                                                      if (type == SSDKPlatformTypeCopy) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"链接复制成功"];
                                                      }
                                                      
                                                  }
                                                      break;
                                                  case SSDKResponseStateFail:
                                                  {
                                                      
                                                      [EasyShowTextView showErrorText:@"分享失败"];
                                                  }
                                                      break;
                                                  case SSDKResponseStateCancel:
                                                  {
                                                      
                                                      [EasyShowTextView showText:@"取消分享"];
                                                  }
                                                      break;
                                                  default:
                                                      break;
                                              }
                                              
                                          }];
 
}

- (void)allBtnClick:(UIButton *)sender{
    NSLog(@"allBtnClick: -- %zd",sender.tag);
    
    YPGetCommodityTypeTableList *listModel = self.listMarr[sender.tag - 1 - 1000];
    
    YPEDuGoodsAllListController *all = [[YPEDuGoodsAllListController alloc]init];
    all.titleStr = listModel.TypeName;
    all.typeId = listModel.TypeId;
//    all.CarCount = self.quotasModel.CarCount;
    
    all.willShowCart = NO;//不显示购物车
    
    [self.navigationController pushViewController:all animated:YES];
    
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
- (NSMutableArray<YPGetCommodityTypeTableList *> *)listMarr{
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
