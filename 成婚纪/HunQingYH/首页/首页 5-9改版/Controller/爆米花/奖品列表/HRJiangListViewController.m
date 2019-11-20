//
//  HRJiangListViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/4/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRJiangListViewController.h"
#import "YPPopCornGetPrizeListCell.h"
#import "YPReceivePopCornView.h"
#import "YPPopCornVoucherController.h"
#import "YPUserPopcornRecord.h"
#import "YPReceiveAddressController.h"
@interface HRJiangListViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UIView *_navView;
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIControl *control; 
///领取索引
@property (nonatomic, copy) NSString *selectIndex;

@property (nonatomic, strong) NSMutableArray<YPUserPopcornRecord *> *listMarr;

@end

@implementation HRJiangListViewController{
    YPReceivePopCornView *_receiveView;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self UserPopcornRecord];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    self.view.backgroundColor =CHJ_bgColor;
    
    [self setupUI];
    
}
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_01"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"我的奖品";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
//    UIButton *ruleBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
//    [ruleBtn  setTitle:@"规则" forState:UIControlStateNormal];
//    [ruleBtn setTitleColor:TextNormalColor forState:UIControlStateNormal];
//    [ruleBtn addTarget:self action:@selector(ruleClick) forControlEvents:UIControlEventTouchUpInside];
//    [_navView addSubview:ruleBtn];
//    [ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(40, 40));
//        make.right.mas_equalTo(_navView).mas_offset(-15);
//        make.centerY.mas_equalTo(backBtn);
//    }];
}
- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 110;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listMarr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    YPUserPopcornRecord *record = self.listMarr[indexPath.row];
    
    YPPopCornGetPrizeListCell *cell = [YPPopCornGetPrizeListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.getBtn.tag = indexPath.row + 1000;
    [cell.getBtn addTarget:self action:@selector(getBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.recordModel = record;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - target--------
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getBtnClick:(UIButton *)sender{
    NSLog(@"getBtnClick:%zd",sender.tag);
    
    self.selectIndex = [NSString stringWithFormat:@"%zd",sender.tag];

    YPUserPopcornRecord *record = self.listMarr[sender.tag-1000];
    
    if ([record.Type integerValue] == 1) {//0现金1实物2兑换
        
        NSLog(@"实物");
        YPReceiveAddressController *address = [[YPReceiveAddressController alloc]init];
        address.ObjectTypes =5;
       
        address.ActivityPrizesID =[record.Id integerValue];
        
        [self.navigationController pushViewController:address animated:YES];
        
        
    }else if ([record.Type integerValue] == 2){
        
        [self.view addSubview:self.control];
    }
    
}

- (void)controlClick{
    
    [self.control removeFromSuperview];
}

- (void)receiveGetBtnClick{
    
    NSLog(@"receiveGetBtnClick -- %@ ",self.selectIndex);
    
    [self UpdatePopcornPrizes];
}

#pragma mark - 网络请求
#pragma mark 用户爆米花中奖纪录
- (void)UserPopcornRecord{
    
    NSString *url = @"/api/HQOAApi/UserPopcornRecord";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPUserPopcornRecord mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
            if (self.listMarr.count > 0) {
                [self hidenEmptyView];
            }else{
                [self showNoDataEmptyView];
            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 爆米花奖品领取
- (void)UpdatePopcornPrizes{
    
    YPUserPopcornRecord *record = self.listMarr[[self.selectIndex integerValue]-1000];
    
    NSString *url = @"/api/HQOAApi/UpdatePopcornPrizes";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = record.Id;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            YPPopCornVoucherController *voucher = [[YPPopCornVoucherController alloc]init];
            [self presentViewController:voucher animated:YES completion:^{
                [self.control removeFromSuperview];
            }];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
     
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.tableView];
}

#pragma mark - getter
- (UIControl *)control{
    if (!_control) {
        _control = [[UIControl alloc]initWithFrame:self.view.frame];
        _control.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        if (!_receiveView) {
            _receiveView = [YPReceivePopCornView yp_receivePopCornView];
        }
        [_control addSubview:_receiveView];
        [_receiveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_control);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        }];
    }
    [_control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [_receiveView.noBtn addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [_receiveView.getBtn addTarget:self action:@selector(receiveGetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return _control;
}

- (NSMutableArray<YPUserPopcornRecord *> *)listMarr{
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
