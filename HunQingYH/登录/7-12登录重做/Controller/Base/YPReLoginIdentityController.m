//
//  YPReLoginIdentityController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/7/12.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReLoginIdentityController.h"
#import "YPReLoginIdentityView.h"
#import "YPReLoginBindPhoneController.h"//绑定手机号
#import "YPReLoginSupplierIdentityController.h"//供应商二级
#import "YPReLoginWeddingDateController.h"//18-11-02 新人婚期选择
#import "CJAreaPicker.h"//地址选择

@interface YPReLoginIdentityController ()<CJAreaPickerDelegate>

/** 选中身份*/
@property (nonatomic, assign) NSInteger selectProfession;

/***********************************地址选择*****************************************/
/**经纬度坐标*/
@property (strong, nonatomic) NSString *coordinates;
/**缓存城市*/
@property (strong, nonatomic) NSString *cityInfo;
/**缓存城市parentid*/
@property (assign, nonatomic) NSInteger parentID;
/**地区ID*/
@property (strong, nonatomic) NSString *areaid;
/***********************************地址选择*****************************************/

@end

@implementation YPReLoginIdentityController{
    UIView *_navView;
    //数据库
    FMDatabase *dataBase;
    
    YPReLoginIdentityView *_identityV;
    
    FBShimmeringView *_shimmeringView;
    LCTabBarController *tabBarC;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setupNav];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:250/255.0 green:80/255.0 blue:120/255.0 alpha:1];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(4);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"您的身份是?";
    titleLab.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:32];
    titleLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
//    [self.view addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(view);
//        make.left.mas_equalTo(view.mas_right).mas_offset(15);
//    }];
    
    if (!_shimmeringView) {
        _shimmeringView = [[FBShimmeringView alloc] init];
    }
    _shimmeringView.shimmering = YES;
    _shimmeringView.contentView = titleLab;
    [self.view addSubview:_shimmeringView];
    [_shimmeringView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view);
        make.left.mas_equalTo(view.mas_right).mas_offset(10);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
   
    if (!_identityV) {
        _identityV = [YPReLoginIdentityView yp_reloginIdentityView];
    }
    
    __weak typeof(self) weakSelf = self;
    _identityV.btnClickBlock = ^(UIButton *sender) {
        NSLog(@"%zd",sender.tag);
        
        if (sender.tag == 1004) {//地区
            
            //地区
            CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
            picker.delegate = weakSelf;
            UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
            [weakSelf presentViewController:navc animated:YES completion:nil];
            
        }else{
            weakSelf.selectProfession = sender.tag;
        }

    };
    
    //初始选中-新人
    _identityV.xinren.textColor = BlackColor;
    _identityV.xinrenBtn.selected = YES;
    self.selectProfession = 1000;
    
    [self.view addSubview:_identityV];
    [_identityV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(30);
        make.top.mas_equalTo(_shimmeringView.mas_bottom).mas_offset(25);
        make.left.right.mas_equalTo(self.view);
    }];
    
    UIButton *nextBtn = [[UIButton alloc]init];
    [nextBtn setImage:[UIImage imageNamed:@"NextStep"] forState:UIControlStateNormal];
    [nextBtn setImage:[UIImage imageNamed:@"NextStep"] forState:UIControlStateHighlighted];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_identityV.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
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
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.mas_equalTo(_navView).mas_offset(15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
}

#pragma mark - 按钮点击事件
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextBtnClick{
    NSLog(@"nextBtnClick");

    if (self.areaid.length > 0 && self.cityInfo.length > 0) {
        if (self.selectProfession == 1001) {//供应商

            YPReLoginSupplierIdentityController *supplier = [[YPReLoginSupplierIdentityController alloc]init];
            supplier.identityType = self.identityType;
            supplier.wxopenId = self.wxopenId;
            supplier.wxphone = self.wxphone;
            supplier.wxphoneCode = self.wxphoneCode;
            supplier.tokenCode = self.tokenCode;//18-08-10 微信Access_token
            supplier.areaID = self.areaid;//18-11-05 地区
            [self.navigationController pushViewController:supplier animated:YES];

        }else if (self.selectProfession == 1000 || self.selectProfession == 1002 || self.selectProfession == 1003){//新人 酒店 婚庆公司

            /**标识 绑定手机号/微信注册:1 手机号验证码注册注册:2*/
            if ([self.identityType isEqualToString:@"1"]) {

                if (self.selectProfession == 1000) {//新人

                    //                [self WXRegisterWithIdentity:YongHu_New];
                    //新人婚期选择
                    YPReLoginWeddingDateController *date = [[YPReLoginWeddingDateController alloc]init];
                    date.identityType = self.identityType;
                    date.wxopenId = self.wxopenId;
                    date.wxphone = self.wxphone;
                    date.wxphoneCode = self.wxphoneCode;
                    date.tokenCode = self.tokenCode;//18-08-10 微信Access_token
                    date.areaID = self.areaid;//18-11-05 地区
                    [self.navigationController pushViewController:date animated:YES];

                }else if (self.selectProfession == 1002){//酒店
                    [self WXRegisterWithIdentity:JiuDian_New];
                }else if (self.selectProfession == 1003){//婚庆公司
                    [self WXRegisterWithIdentity:HunQing_New];
                }

            }else if ([self.identityType isEqualToString:@"2"]){

                if (self.selectProfession == 1000) {//新人

                    //                [self PhoneCodeRegisterWithIdentity:YongHu_New];
                    //新人婚期选择
                    YPReLoginWeddingDateController *date = [[YPReLoginWeddingDateController alloc]init];
                    date.identityType = self.identityType;
                    date.wxopenId = self.wxopenId;
                    date.wxphone = self.wxphone;
                    date.wxphoneCode = self.wxphoneCode;
                    date.tokenCode = self.tokenCode;//18-08-10 微信Access_token
                    date.areaID = self.areaid;//18-11-05 地区
                    [self.navigationController pushViewController:date animated:YES];

                }else if (self.selectProfession == 1002){//酒店
                    [self PhoneCodeRegisterWithIdentity:JiuDian_New];
                }else if (self.selectProfession == 1003){//婚庆公司
                    [self PhoneCodeRegisterWithIdentity:HunQing_New];
                }
            }
        }
    }else{
        [EasyShowTextView showText:@"请选择您所在地区" inView:self.view];
    }
    
}

#pragma mark - 网络请求
#pragma mark 微信注册用户信息
- (void)WXRegisterWithIdentity:(NSString *)identity{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/WXRegister";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"OpenId"] = self.wxopenId;
    params[@"Phone"] = self.wxphone;
    
    params[@"Identity"] = identity;
    
    params[@"PhoneCode"] = self.wxphoneCode;
    ///18-08-10 添加 微信Access_token
    params[@"Token"] = self.tokenCode;
    
    ///18-11-02 婚期
    params[@"Wedding"] = @"";
    //18-11-05 地区
    params[@"AreaId"] = self.areaid;

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            //注册成功
            
            [EasyShowTextView showText:@"注册成功!" inView:self.view];
            
            [self WXGetUserInfo];//18-08-16 获取信息--窦
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
    
}

#pragma mark 手机号验证码注册用户
- (void)PhoneCodeRegisterWithIdentity:(NSString *)identity{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/PhoneCodeRegister";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"Phone"] = self.wxphone;
    
    params[@"Identity"] = identity;
    
    params[@"PassWord"] = @"";//07-31 手机号验证码注册不需要密码
    params[@"PhoneCode"] = self.wxphoneCode;
    
    ///18-11-02 婚期
    params[@"Wedding"] = @"";
    //18-11-05 地区
    params[@"AreaId"] = self.areaid;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            //注册成功
            [EasyShowTextView showText:@"注册成功!" inView:self.view];
            
            [self SMSCodeGetUserInfoRequest];//18-08-16 获取信息--窦
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });

    }];
    
}

#pragma mark 根据微信Id获取用户信息
- (void)WXGetUserInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/WXGetUserInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"OpenId"] = self.wxopenId;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"已注册-主页");
            [CXDataManager savaUserInfo:object];
            
            [EasyShowTextView showText:@"登录成功!" inView:self.view];
            
            //18-11-06 注册成功
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                if (self.selectProfession == 1000) {//新人
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistSuccess" object:nil userInfo:@{@"professionType":YongHu_New}];
                }else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistSuccess" object:nil userInfo:@{@"professionType":@""}];
                }
            }];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    }];
}

#pragma mark 根据手机号验证码获取用户信息
- (void)SMSCodeGetUserInfoRequest{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/SMSCodeGetUserInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Phone"] = self.wxphone;
    params[@"Code"] = self.wxphoneCode;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            NSLog(@"用户信息：%@",[object objectForKey:@"UserId"]);
            
            [CXDataManager savaUserInfo:object];
            [EasyShowTextView showText:@"登录成功!" inView:self.view];
            
            //18-11-06 注册成功
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                if (self.selectProfession == 1000) {//新人
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistSuccess" object:nil userInfo:@{@"professionType":YongHu_New}];
                }else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistSuccess" object:nil userInfo:@{@"professionType":@""}];
                }
            }];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    }];
    
}

#pragma mark - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID = parentID;

    NSLog(@"缓存城市设置为%@",address);
    self.cityInfo = address;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self selectDataBase];
    
}

- (void)areaPicker:(CJAreaPicker *)picker didClickCancleWithAddress:(NSString *)address parentID:(NSInteger)parentID{
    
}

#pragma mark --------数据库-------
-(void)moveToDBFile
{       //1、获得数据库文件在工程中的路径——源路径。
    NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"region"ofType:@"db"];
    
    NSLog(@"sourcesPath %@",sourcesPath);
    //2、获得沙盒中Document文件夹的路径——目的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSLog(@"documentPath %@",documentPath);
    
    NSString *desPath = [documentPath stringByAppendingPathComponent:@"region.db"];
    //3、通过NSFileManager类，将工程中的数据库文件复制到沙盒中。
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:desPath])
    {
        NSError *error ;
        if ([fileManager copyItemAtPath:sourcesPath toPath:desPath error:&error]) {
            NSLog(@"数据库移动成功");
        }
        else {
            NSLog(@"数据库移动失败");
        }
    }
    
}
//打开数据库
- (void)openDataBase{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"region.db"];
    
    dataBase =[[FMDatabase alloc]initWithPath:dbFilePath];
    BOOL ret = [dataBase open];
    if (ret) {
        NSLog(@"打开数据库成功");
        
    }else{
        NSLog(@"打开数据库成功");
    }
    
}
//关闭数据库
- (void)closeDataBase{
    BOOL ret = [dataBase close];
    if (ret) {
        NSLog(@"关闭数据库成功");
    }else{
        NSLog(@"关闭数据库失败");
    }
}
//查询数据库
-(void)selectDataBase{
    [self openDataBase];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    NSLog(@"缓存城市为%@",huanCun);
    NSLog(@"_cityInfo*$#$#$##$$%@",self.cityInfo);
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'AND PARENT_ID =%ld",self.cityInfo,(long)_parentID];
    FMResultSet *set =[dataBase executeQuery:selectSql];
    while ([set next]) {
        int ID = [set intForColumn:@"REGION_ID"];
        NSLog(@"==*****%d",ID);
        NSString *idStr = [NSString stringWithFormat:@"%d",ID];
        
        //6-5
        //        [[NSUserDefaults standardUserDefaults]setObject:idStr forKey:@"areaid"];
        //        NSLog(@"areaid ------- %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"areaid"]);
        self.areaid =idStr;
    }
    [self closeDataBase];
    
    [_identityV.areaBtn setTitle:self.cityInfo forState:UIControlStateNormal];
    
    NSLog(@"~~~~~~ huanCun:%@ cityInfo:%@ areaid:%@ ",huanCun,self.cityInfo,self.areaid);
    
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
