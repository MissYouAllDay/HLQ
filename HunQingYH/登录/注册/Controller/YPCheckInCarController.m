//
//  YPCheckInCarController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/25.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPCheckInCarController.h"
//#import <fmdb/FMDB.h>
//#import "CJAreaPicker.h"//地址选择
#import "YPCheckInCarNumberCell.h"
#import "YPSelectNormalCell.h"
//#import "FFDropDownMenuView.h"//下拉菜单
#import "YPCarBrandController.h"//车辆品牌
#import "YPCarTypeController.h"//车系
#import "YPAddCarImgsController.h"//添加汽车图片
#import "YPNewPassWordController.h"//设置新密码

#define FFDefaultFloat -10.0

@interface YPCheckInCarController ()<UITableViewDelegate,UITableViewDataSource,YPCarBrandDelegate,YPCarTypeDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataMarr;
//@property (nonatomic, strong) FFDropDownMenuView *menuView;

///选中的鲁X
//@property (nonatomic, strong) UIButton *titleBtn;

@property (nonatomic, copy) NSString *carBrand;
@property (nonatomic, copy) NSString *carType;
@property (nonatomic, copy) NSString *carColor;
@property (nonatomic, copy) NSString *carBrandID;
@property (nonatomic, copy) NSString *carTypeID;

@end

@implementation YPCheckInCarController{
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

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    [self.view addSubview:self.tableView];
    
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"登记车辆";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.mas_equalTo(_navView).mas_offset(15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
    
//    //设置导航栏右边
//    UIButton *addBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addBtn setTitle:@"自行添加" forState:UIControlStateNormal];
//    [addBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
//    [addBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
//    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_navView addSubview:addBtn];
//    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_navView).mas_offset(-15);
//        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
//    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    YPSelectNormalCell *cell = [YPSelectNormalCell cellWithTableView:tableView];
    
    cell.titleLabel.textColor = BlackColor;
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"品牌";
        
        if (self.carBrand.length > 0) {
            cell.descLabel.text = self.carBrand;
        }
        
    }else if (indexPath.row == 1) {
        cell.titleLabel.text = @"型号";
        
        if (self.carType.length > 0) {
            cell.descLabel.text = [NSString stringWithFormat:@"%@ - %@",self.carType,self.carColor];
        }
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = CHJ_bgColor;
        
        //确定按钮
        UIButton *sureBtn = [[UIButton alloc] init];
        [sureBtn setBackgroundColor:NavBarColor];
        [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:sureBtn];
        sureBtn.layer.cornerRadius = 5;
        sureBtn.clipsToBounds = YES;
        
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(30);
            make.height.mas_equalTo(45);
        }];
        
        return view;
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        YPCarBrandController *carBrand = [[YPCarBrandController alloc]init];
        carBrand.brandDelegate = self;
        [self.navigationController pushViewController:carBrand animated:YES];
        
    }else if (indexPath.row == 1) {
        
        if (self.carBrand.length > 0) {
            YPCarTypeController *carType = [[YPCarTypeController alloc]init];
            carType.carTypeDelegate = self;
            carType.titleStr = self.carBrand;
            carType.carModelID = self.carBrandID;
            [self.navigationController pushViewController:carType animated:YES];
        }else{
            Alertmsg(@"请先选择品牌", nil)
        }
        
    }
    
}

#pragma mark - YPCarBrandDelegate
- (void)carBrand:(NSString *)carBrand andCarModelID:(NSString *)carID{
    self.carBrand = carBrand;
    self.carBrandID = carID;
    
    [self.tableView reloadData];
}

#pragma mark - YPCarTypeDelegate
- (void)carType:(NSString *)carType andCarModelID:(NSString *)carID andCarColor:(NSString *)carColor{
    self.carType = carType;
    self.carTypeID = carID;
    self.carColor = carColor;
    
    [self.tableView reloadData];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)addBtnClick{
//    NSLog(@"addBtnClick");
//    
//    YPAddCarInfoController *addInfo = [[YPAddCarInfoController alloc]init];
//    [self.navigationController pushViewController:addInfo animated:YES];
//}

- (void)sureBtnClick{
    NSLog(@"sureBtnClick");
    
    if (self.carBrand.length > 0 && self.carType.length > 0) {
        YPNewPassWordController *newPWD = [[YPNewPassWordController alloc]init];
        newPWD.titleStr = @"设置密码";
        newPWD.setType = @"2";//1-忘记密码 , 2-注册
        
        newPWD.phoneNo = self.phoneNo;
        newPWD.authCodeID = self.authCodeID;
        newPWD.profession = self.profession;
        newPWD.iconID = self.iconID;
        newPWD.shopName = self.shopName;
        newPWD.addressID = self.addressID;
        
        newPWD.address = @"";//只有酒店有
        
        newPWD.idCardFrontID = self.idCardFrontID;
        newPWD.idCardFanID = self.idCardFanID;
        newPWD.handIDCardID = self.handIDCardID;
        newPWD.otherCardID = self.otherCardID;
        
        newPWD.carModelID = self.carTypeID;//只有婚车有
        
        [self.navigationController pushViewController:newPWD animated:YES];
    }else{
        Alertmsg(@"请选择品牌车系", nil)
    }
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
