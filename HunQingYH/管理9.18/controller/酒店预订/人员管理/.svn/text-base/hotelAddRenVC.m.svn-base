//
//  hotelAddRenVC.m
//  HunQingYH
//
//  Created by Hiro on 2019/6/27.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "hotelAddRenVC.h"
#import "hotelAddRenView.h"
#import "WTTableAlertView.h"

@interface hotelAddRenVC ()<UITextFieldDelegate>
{
    hotelAddRenView *infoView;
}

@end

@implementation hotelAddRenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.ID isEqualToString:@""]) {
        _nameStr =@"";
        _phoneStr =@"";
        _shenfenStr =@"预订人员";
    }

    [self createNav];
    [self createUI];
    if (self.formIndex==1) {
        
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
    if (self.formIndex==1) {
            titleLab.text = @"添加人员";
    }else{
        titleLab.text = @"编辑人员";
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
    [saveBtn setTitleColor:TextNormalColor forState:UIControlStateNormal];
    saveBtn.titleLabel.font =kFont(15);
    [saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.right.mas_equalTo(navView.mas_right).offset(-15);
    }];
    
   
    
}
-(void)createUI{
     infoView =[hotelAddRenView initViewWithXib];
    infoView.frame =CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, 200);
    [infoView.shenfenBtn setTitle:_shenfenStr forState:UIControlStateNormal];
    [infoView.shenfenBtn addTarget:self action:@selector(shenfenClick) forControlEvents:UIControlEventTouchUpInside];
    
    infoView.nameTextFiled.delegate =self;
    infoView.nameTextFiled.tag =1;
    infoView.phoneTextField.delegate =self;
    infoView.phoneTextField.tag =2;
    infoView.phoneTextField.keyboardType =UIKeyboardTypeNumberPad;
    
    if ([_nameStr isEqualToString:@""]) {
        infoView.nameTextFiled.placeholder=@"请输入姓名";
    }else{
        infoView.nameTextFiled.text =_nameStr;
    }
    if ([_phoneStr isEqualToString:@""]) {
        infoView.phoneTextField.placeholder=@"请输入手机";
    }else{
        infoView.phoneTextField.text =_phoneStr;
    }
    [self.view addSubview:infoView];
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

-(void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason{
    if (textField.tag ==1) {
        _nameStr =textField.text;
    }else{
        _phoneStr =textField.text;
    }
}
#pragma mark --------------------- target---------------------
-(void)delClick{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"删除该员工？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag =1001;
    [alertView show];
}
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)shenfenClick{
    NSArray *shenfenArr=@[@"预订人员",@"销售代表"];
    WTTableAlertView* alertview = [WTTableAlertView initWithTitle:@"选择身份" options:shenfenArr singleSelection:YES selectedItems:@[@(3)] completionHandler:^(NSArray * _Nullable options) {
        for (id obj in options) {
            NSLog(@"单选，且隐藏确定按钮:%@", obj);
            NSInteger index =[obj integerValue];
            _shenfenStr =shenfenArr[index];
            [infoView.shenfenBtn setTitle:_shenfenStr forState:UIControlStateNormal];

            
            
        }
        
    }];
    alertview.hiddenConfirBtn = YES;
    [alertview show];
}
-(void)saveClick{
    if ([_nameStr isEqualToString:@""]) {
        [EasyShowTextView showText:@"请输入姓名"];

    }else if ([_phoneStr isEqualToString:@""]) {
        [EasyShowTextView showText:@"请输入手机"];

    }else{
        if (self.formIndex==1) {
              [self saveRequest];
        }else{
            [self editRequest];
        }
      
    }
}

#pragma mark -----------------网络请求----------
-(void)saveRequest{

    
    [EasyShowLodingView showLoding];

    
    
    NSString *url = @"/api/HQOAApi/CreateHotelPersonnel";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([_shenfenStr isEqualToString:@"销售代表"]) {
        params[@"IdentityId"] = @"E420424F-98FE-4FE2-A342-D530F3893BFB";

    }else{
        params[@"IdentityId"] = @"67FC24E4-E001-4E85-B969-A4DEEDFA0DA2";

    }
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"Name"] = _nameStr;
    params[@"Phone"] =_phoneStr;
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

    NSString *url = @"/api/HQOAApi/UpdateHotelPersonnel";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] =self.ID;
    if ([_shenfenStr isEqualToString:@"销售代表"]) {
        params[@"IdentityId"] = @"E420424F-98FE-4FE2-A342-D530F3893BFB";
        
    }else{
        params[@"IdentityId"] = @"67FC24E4-E001-4E85-B969-A4DEEDFA0DA2";
        
    }
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"Name"] = _nameStr;
    params[@"Phone"] =_phoneStr;
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
    
    
    
    NSString *url = @"/api/HQOAApi/DeleteHotelPersonnel";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] =self.ID;
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
