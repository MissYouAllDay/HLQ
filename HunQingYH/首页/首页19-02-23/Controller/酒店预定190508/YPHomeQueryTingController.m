//
//  YPHomeQueryTingController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/5/10.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHomeQueryTingController.h"
#import "UIImage+YPGradientImage.h"
#import "YPHomeQueryTingCell.h"
#import "YPHomeReserveTingController.h"
#import "YPGetHotelBanquetlList.h"
#import "YPHomeQueryTingDetailController.h"
#import "YPHYTHDetailController.h"   // 宴会厅详情
@interface YPHomeQueryTingController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<YPGetHotelBanquetlList *> *listMarr;

@end

@implementation YPHomeQueryTingController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetHotelBanquetlList_1];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"查找宴会厅";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStyleGrouped];
    }
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
    return self.listMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YPGetHotelBanquetlList *listModel = self.listMarr[indexPath.section];
    YPHomeQueryTingCell *cell = [YPHomeQueryTingCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:listModel.HotelImage] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    BOOL isHave = NO;
    if ([listModel.Name containsString:@"-"]) {
        NSArray *arr = [listModel.Name componentsSeparatedByString:@"-"];
        if (arr.count == 2) {
            
            cell.titleLabel.text = arr[1];
            cell.zhuoshu.text = [NSString stringWithFormat:@"%@          %@桌",arr[0],listModel.TableNumber];
            isHave = YES;
        }
    }
    
    if (!isHave) {
        cell.titleLabel.text = listModel.Name;
        cell.zhuoshu.text = [NSString stringWithFormat:@"%@桌",listModel.TableNumber];
    }
  
    if (listModel.Data_1.count > 0) {
        NSDictionary *dict = listModel.Data_1[0];
        cell.yudingState.text = dict[@"DinnerTime"];
        cell.payState.text = [dict[@"EarnestType"] integerValue] == 0 ? @"已预订":@"已交定金"; //0预定，1已交定金
    }else{
        cell.yudingState.text = @"该厅暂无任何预订";
        cell.payState.text = @"";
    }
    cell.lookDetail.tag = indexPath.section + 1000;
    cell.reserveBtn.tag = indexPath.section + 2000;
    [cell.lookDetail addTarget:self action:@selector(lookDetailClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.reserveBtn addTarget:self action:@selector(reserveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 131;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 60;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = nil;
    if (section == 0) {
        view = [[UIView alloc]init];
        view.backgroundColor = CHJ_bgColor;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.enabled = NO;
        btn.layer.cornerRadius = 20;
        btn.clipsToBounds = YES;
        [btn setTitle:[NSString stringWithFormat:@"%@    %@",self.dateStr,self.zhuoShu] forState:UIControlStateNormal];
        [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 21];
        [btn setBackgroundImage:[UIImage gradientImageWithBounds:CGRectMake(0, 0, ScreenWidth-36, 40) andColors:@[[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0], [UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage gradientImageWithBounds:CGRectMake(0, 0, ScreenWidth-36, 40) andColors:@[[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0], [UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage gradientImageWithBounds:CGRectMake(0, 0, ScreenWidth-36, 40) andColors:@[[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0], [UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateDisabled];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.right.mas_equalTo(-18);
            make.centerY.mas_equalTo(view);
            make.height.mas_equalTo(40);
        }];
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YPGetHotelBanquetlList *listModel = self.listMarr[indexPath.section];
    YPHYTHDetailController *detail = [[YPHYTHDetailController alloc]init];
    detail.detailID = listModel.Id;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)lookDetailClick:(UIButton *)sender{
    YPGetHotelBanquetlList *listModel = self.listMarr[sender.tag - 1000];
//    YPHomeQueryTingDetailController *detail = [[YPHomeQueryTingDetailController alloc]init];
//    detail.detailID = listModel.Id;
//    [self.navigationController pushViewController:detail animated:YES];
        YPHYTHDetailController *detail = [[YPHYTHDetailController alloc]init];
        detail.detailID = listModel.Id;
        [self.navigationController pushViewController:detail animated:YES];

}

- (void)reserveBtnClick:(UIButton *)sender{
    YPGetHotelBanquetlList *listModel = self.listMarr[sender.tag - 2000];
    YPHomeReserveTingController *reserve = [[YPHomeReserveTingController alloc]init];
    reserve.type = 1;
    reserve.listModel = listModel;
    reserve.hotelTing = listModel.Name;
    reserve.timeStr = self.dateStr;
    reserve.zhuoshu = self.zhuoShu;
    [self.navigationController pushViewController:reserve animated:YES];
}

#pragma mark - 网络请求
#pragma mark 获取婚礼套餐列表
- (void)GetHotelBanquetlList_1{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetHotelBanquetlList_1";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *string = [self.dateStr stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
    string = [string stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    string = [string stringByReplacingOccurrencesOfString:@"日" withString:@""];
    params[@"Time"] = string;
    params[@"TableNumber"] = [self.zhuoShu stringByReplacingOccurrencesOfString:@"桌" withString:@""];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.listMarr removeAllObjects];
            
            self.listMarr = [YPGetHotelBanquetlList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [self showNetErrorEmptyView];
        
    }];
    
}

#pragma mark - 缺省
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"请点击重新加载数据!" subTitle:nil imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetHotelBanquetlList_1];
    }];
    
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
