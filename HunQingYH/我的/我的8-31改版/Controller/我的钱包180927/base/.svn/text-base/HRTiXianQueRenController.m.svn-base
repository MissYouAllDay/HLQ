//
//  HRTiXianQueRenController.m
//  HunQingYH
//
//  Created by Hiro on 2018/9/27.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "HRTiXianQueRenController.h"
#import "HRAddZFBController.h"
#import "YPReMyWalletAddBankController.h"
#import "YPReMyWalletBaseController.h"

@interface HRTiXianQueRenController (){
    UIView *_navView;
    UIButton *btn;
}

@end

@implementation HRTiXianQueRenController
#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =WhiteColor;
    [self setupNav];
    [self setupUI];
}
- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    
}

-(void)setupUI{
    
    UILabel *desLab = [[UILabel alloc]init];
    desLab.numberOfLines=0;
    desLab.font =kFont(15);
    if (self.typeStr.integerValue == 1) {//1: 支付宝  2: 银行卡
        desLab.text = [NSString stringWithFormat:@"确定要将￥%@提现至该支付宝账户吗？",self.countNum];
    }else if (self.typeStr.integerValue == 2) {//1: 支付宝  2: 银行卡
        desLab.text = [NSString stringWithFormat:@"确定要将￥%@提现至该银行卡账户吗？",self.countNum];
    }
    [self.view addSubview:desLab];
    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).offset(50);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
    }];
    
    UILabel *countLab = [[UILabel alloc]init];
    countLab.font =kFont(20);
    countLab.text = self.phoneOrAccount;
    [self.view addSubview:countLab];
    [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(desLab.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-100);
    }];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setTitle:@"更改账户" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
    editBtn.titleLabel.font =kFont(12);
    editBtn.clipsToBounds =YES;
    editBtn.layer.cornerRadius =13;
    editBtn.layer.borderWidth =1;
    editBtn.layer.borderColor =RGB(221, 221,221).CGColor;
    editBtn.backgroundColor =WhiteColor;
    [editBtn setTitleColor:TextNormalColor forState:UIControlStateNormal];
    [self.view addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(countLab);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(74, 27));
    }];
    
    
    
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(62);
    }];
    //
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = CHJ_bgColor;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    btn = [[UIButton alloc]init];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(255, 207, 139, 1) forState:UIControlStateNormal];
    btn.backgroundColor = RGBA(51, 51, 51, 1);
    btn.userInteractionEnabled =YES;
    btn.titleLabel.font = kFont(16);
    btn.layer.cornerRadius = 4;
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.bottom.mas_equalTo(-12);
    }];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)editClick{
    if (self.typeStr.integerValue == 1) {//1: 支付宝  2: 银行卡
        HRAddZFBController *addVC = [HRAddZFBController new ];
        addVC.typeStr = @"1";//更改账号
        [self.navigationController pushViewController:addVC animated:YES];
    }else if (self.typeStr.integerValue == 2){
        YPReMyWalletAddBankController *addVC = [YPReMyWalletAddBankController new ];
        addVC.typeStr = @"1";//更改账号
        [self.navigationController pushViewController:addVC animated:YES];
    }
}
-(void)submitBtnClick{
 
    [self CreateFacilitatorApplicationCash];
}

#pragma mark - 网络请求
#pragma mark 添加提现申请
- (void)CreateFacilitatorApplicationCash{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CreateFacilitatorApplicationCash";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"AccountNumberId"] = self.AccountNumberId;
    params[@"Money"] = self.countNum;
    if (YongHu(Profession_New)) {
        params[@"FacilitatorId"] = UserId_New;
        params[@"Type"] = @"1";//1新人,2服务商
    }else{
        params[@"FacilitatorId"] = FacilitatorId_New;
        params[@"Type"] = @"2";//1新人,2服务商
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"提现申请成功!" inView:self.view];
            
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIViewController *mineVC = nil;
                for (UIViewController * controller in weakSelf.navigationController.viewControllers) {
                    //遍历
                    if([controller isKindOfClass:[YPReMyWalletBaseController class]]){
                        //这里判断是否为你想要跳转的页面
                        mineVC = controller;
                        break;
                    }
                }
                [weakSelf.navigationController popToViewController:mineVC  animated:YES];
            });
            
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

@end
