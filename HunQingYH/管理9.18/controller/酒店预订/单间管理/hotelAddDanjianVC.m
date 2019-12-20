//
//  hotelAddDanjianVC.m
//  HunQingYH
//
//  Created by Hiro on 2019/6/26.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "hotelAddDanjianVC.h"
#import "hotelAddDanjianView.h"
@interface hotelAddDanjianVC ()<UITextFieldDelegate>

@end

@implementation hotelAddDanjianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createUI];
    if ([self.Id isEqualToString:@""]||!self.Id) {
    }else{
        [self addDelView];

    }
}

- (void)createNav {
    self.view.backgroundColor=CHJ_bgColor ;
    UIView *navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor = WhiteColor;
    [self.view addSubview:navView];
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(navView.mas_left);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-5);
    }];
    UILabel *titleLab  = [[UILabel alloc]init];
    if ([self.Id isEqualToString:@""]||!self.Id) {
        titleLab.text = @"添加单间";
    }else{
        titleLab.text = @"编辑单间";

        
    }
    titleLab.textColor = [UIColor colorWithWhite:0.098 alpha:1.000];
    titleLab.font = [UIFont systemFontOfSize:20 ];
    [navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];
    
    UIButton *saveBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitleColor:TextNormalColor forState:UIControlStateNormal];
    saveBtn.titleLabel.font =kFont(15);
    [navView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.right.mas_equalTo(navView.mas_right).offset(-15);
    }];
    
}
-(void)createUI{
    hotelAddDanjianView *topview =[hotelAddDanjianView initViewWithXib];
    topview.frame =CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, 160);
    topview.nameTextFIELD.delegate =self;
    topview.nameTextFIELD.tag =1;
    topview.minTextField.delegate =self;
    topview.minTextField.tag =2;
    topview.minTextField.keyboardType =UIKeyboardTypeNumberPad;
    topview.maxTextField.delegate =self;
    topview.maxTextField.tag =3;
    if ([_nameStr isEqualToString:@""]||!_nameStr) {
        topview.nameTextFIELD.placeholder=@"请输入单间名称";
    }else{
        topview.nameTextFIELD.text =_nameStr;
    }
    if ([_minStr isEqualToString:@""]||!_minStr) {
        topview.minTextField.placeholder=@"最低";
    }else{
        topview.minTextField.text =_minStr;
    }
    if ([_maxStr isEqualToString:@""]||!_maxStr) {
        topview.maxTextField.placeholder=@"最多";
    }else{
        topview.maxTextField.text =_maxStr;
    }
    topview.maxTextField.keyboardType =UIKeyboardTypeNumberPad;

    [self.view addSubview:topview];
}
-(void)addDelView{
    UIButton *delBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn addTarget:self action:@selector(delClick) forControlEvents:UIControlEventTouchUpInside];
    [delBtn setTitle:@"删除" forState:UIControlStateNormal];
    [delBtn setTitleColor:TextNormalColor forState:UIControlStateNormal];
    [delBtn setBackgroundColor:WhiteColor];
    delBtn.frame =CGRectMake(0, NAVIGATION_BAR_HEIGHT+250, ScreenWidth, 50);
    [self.view addSubview:delBtn];
}

#pragma mark --------------------- target---------------------
-(void)delClick{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"删除该单间？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag =1001;
    [alertView show];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag ==1) {
        _nameStr =textField.text;
    
    }
    if (textField.tag ==2) {
        _minStr =textField.text;
    }
    if (textField.tag ==3) {
        _maxStr =textField.text;
    }
}
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)saveBtnClick{
    if ([_nameStr isEqualToString:@""]||!_nameStr) {
        [EasyShowTextView showText:@"请输入名称"];
    }else if ([_minStr isEqualToString:@""]||!_minStr) {
        [EasyShowTextView showText:@"请输入最低人数"];
    }else if ([_maxStr isEqualToString:@""]||!_maxStr) {
        [EasyShowTextView showText:@"请输入最多人数"];
    }else{
        if ([self.Id isEqualToString:@""]||!self.Id) {
            [self saveRequest];
        }else{
            [self editRequest];


        }
        
    }
}
#pragma mark -----------------网络请求----------
-(void)saveRequest{
    
    
    [EasyShowLodingView showLoding];
    
    
    
    NSString *url = @"/api/HQOAApi/CreateHotelSingleRoom";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
  
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"BanquetName"] = _nameStr;
    params[@"MaxTableNumber"] =_maxStr;
    params[@"MinTableNumber"] =_minStr;
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        [EasyShowLodingView hidenLoding];
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            
            [EasyShowTextView showText:@"添加成功!"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            NSLog(@"%@",[[object valueForKey:@"Message"] valueForKey:@"Inform"]);
            
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
    
}

-(void)editRequest{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpdateHotelSingleRoom";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] =self.Id;
    params[@"ShelfType"] = @"0";//0上架 1下架
    params[@"BanquetName"] = _nameStr;
    params[@"MaxTableNumber"] =_maxStr;
    params[@"MinTableNumber"] =_minStr;
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    NSLog(@"修改参数%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        [EasyShowLodingView hidenLoding];
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            
            [EasyShowTextView showText:@"修改成功!"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            NSLog(@"%@",[[object valueForKey:@"Message"] valueForKey:@"Inform"]);
            
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}
-(void)delteRequest{
    [EasyShowLodingView showLoding];
    
    
    
    NSString *url = @"/api/HQOAApi/DeleteHotelSingleRoom";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] =self.Id;
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        [EasyShowLodingView hidenLoding];
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            
            
            [EasyShowTextView showText:@"删除成功!"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            NSLog(@"%@",[[object valueForKey:@"Message"] valueForKey:@"Inform"]);
            
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    
    if(buttonIndex == 1 && alertView.tag == 1001) {
        
        
        [self delteRequest];
    }
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



@end
