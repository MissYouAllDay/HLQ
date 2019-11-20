//
//  YPMeTingInfoEditController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/20.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPMeTingInfoEditController.h"
#import "YPSupplierInfoInputCell.h"
#import "YPMeAddYanHuiTingWHCell.h"
#import "YPMeAddYanHuiTingTableCountCell.h"

@interface YPMeTingInfoEditController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

/**名称*/
@property (nonatomic, strong) UITextField *nameTF;
/**面积*/
@property (nonatomic, strong) UITextField *mianjiTF;
/**长度*/
@property (nonatomic, strong) UITextField *lengthTF;
/**宽度*/
@property (nonatomic, strong) UITextField *widthTF;
/**层高*/
@property (nonatomic, strong) UITextField *cenggaoTF;
/**容纳桌数-最小*/
@property (nonatomic, strong) UITextField *tableMinTF;
/**容纳桌数-最大*/
@property (nonatomic, strong) UITextField *tableMaxTF;

@end

@implementation YPMeTingInfoEditController{
    UIView *_navView;
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
    self.view.backgroundColor = CHJ_bgColor;
    
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
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn setTitleColor:RGBS(51) forState:UIControlStateNormal];
    backBtn.titleLabel.font = kFont(16);
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_navView.mas_left).mas_offset(15);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"编辑信息";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"保存" forState:UIControlStateNormal];
    [moreBtn setTitleColor:RGB(250, 80, 120) forState:UIControlStateNormal];
    moreBtn.titleLabel.font = kFont(16);
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3){
        YPSupplierInfoInputCell *cell = [YPSupplierInfoInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"名称";
            cell.inputTF.placeholder = @"请输入宴会厅名称";
            cell.inputTF.enabled = YES;
            self.nameTF = cell.inputTF;
            if (self.infoModel.BanquetHallName.length > 0) {
                cell.inputTF.text = self.infoModel.BanquetHallName;
            }
        }else if (indexPath.row == 1) {
            cell.nameLabel.text = @"面积";
            cell.inputTF.placeholder = @"0.0 ㎡";
            cell.inputTF.enabled = YES;
            self.mianjiTF = cell.inputTF;
            cell.inputTF.text = [NSString stringWithFormat:@"%.2f",self.infoModel.Acreage.floatValue];
        }else if (indexPath.row == 3) {
            cell.nameLabel.text = @"层高";
            cell.inputTF.placeholder = @"0.0 m";
            cell.inputTF.enabled = YES;
            self.cenggaoTF = cell.inputTF;
            cell.inputTF.text = [NSString stringWithFormat:@"%.2f",self.infoModel.Height.floatValue];
        }
        return cell;
    }else if (indexPath.row == 2){
        YPMeAddYanHuiTingWHCell *cell = [YPMeAddYanHuiTingWHCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.lengthTF = cell.lengthTF;
        self.widthTF = cell.widthTF;
        cell.lengthTF.text = [NSString stringWithFormat:@"%.2f",self.infoModel.Length.floatValue];
        cell.widthTF.text = [NSString stringWithFormat:@"%.2f",self.infoModel.Width.floatValue];
        return cell;
    }else {
        YPMeAddYanHuiTingTableCountCell *cell = [YPMeAddYanHuiTingTableCountCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tableMinTF = cell.minTF;
        self.tableMaxTF = cell.maxTF;
        cell.minTF.text = [NSString stringWithFormat:@"%zd",self.infoModel.MinTableCount.integerValue];
        cell.maxTF.text = [NSString stringWithFormat:@"%zd",self.infoModel.MaxTableCount.integerValue];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"保存");
    [self UpBanquetHallInfo];
}

#pragma mark - 网络请求
#pragma mark 修改宴会厅
-(void)UpBanquetHallInfo{
    
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/UpBanquetHallInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BanquetHallName"] = self.nameTF.text;
    params[@"FloorPrice"] = @"";
    params[@"MaxTableCount"] = self.tableMaxTF.text;
    params[@"MinTableCount"] = self.tableMinTF.text;
    params[@"TypeQuestion"] = @"";
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"BanquetID"] = self.BanquetID;
    params[@"Acreage"] = self.mianjiTF.text;
    params[@"Length"] = self.lengthTF.text;
    params[@"Width"] = self.widthTF.text;
    params[@"Height"] = self.cenggaoTF.text;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"修改成功!" inView:self.view];
            [self performSelector:@selector(backVC) withObject:nil afterDelay:1];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
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
