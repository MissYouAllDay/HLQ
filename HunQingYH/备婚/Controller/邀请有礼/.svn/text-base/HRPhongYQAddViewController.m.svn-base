//
//  HRPhongYQAddViewController.m
//  HunQingYH
//
//  Created by Hiro on 2017/12/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRPhongYQAddViewController.h"

@interface HRPhongYQAddViewController ()<UITextFieldDelegate>
{
    UIView *_navView;
    UITextField *phoneTextField;
    UITextField *nameTextField;
    

}
/**姓名*/
@property(nonatomic,copy)NSString  *NameStr;
/**手机号*/
@property(nonatomic,copy)NSString  *PhoneStr;
@end

@implementation HRPhongYQAddViewController
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
    [self setupNav];
    [self setUpUI];
}
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
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
    titleLab.text = @"手机号邀请";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    self.view.backgroundColor =CHJ_bgColor;
}
-(void)setUpUI{
  
    self.NameStr =@"";
    self.PhoneStr =@"";
   phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(50,NAVIGATION_BAR_HEIGHT+50, ScreenWidth-100, 50)];
    phoneTextField.borderStyle =UITextBorderStyleNone;
    phoneTextField.layer.borderWidth =1.0f;
    phoneTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    phoneTextField.clipsToBounds= YES;
    phoneTextField.layer.cornerRadius =20;
    phoneTextField.placeholder =@"     输入被添加人的手机号码";
    phoneTextField.backgroundColor = RGB(241, 244, 249);
    phoneTextField.tag =1;
    phoneTextField.delegate =self;
    phoneTextField.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:phoneTextField];
    
    nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(50,CGRectGetMaxY(phoneTextField.frame)+30, ScreenWidth-100, 50)];
    nameTextField.borderStyle =UITextBorderStyleNone;
    nameTextField.layer.borderWidth =1.0f;
    nameTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    nameTextField.clipsToBounds= YES;
    nameTextField.layer.cornerRadius =20;
    nameTextField.placeholder =@"     输入被添加人姓名";
    nameTextField.backgroundColor = RGB(241, 244, 249);
    nameTextField.tag =2;
    nameTextField.delegate =self;
    nameTextField.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:nameTextField];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame =CGRectMake(50,CGRectGetMaxY(nameTextField.frame)+30, ScreenWidth-100, 50) ;
    addBtn.clipsToBounds =YES;
    addBtn.layer.cornerRadius =20;
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [addBtn setBackgroundColor:MainColor];
    [self.view addSubview:addBtn];
    
}
#pragma mark --------uitextfieldDelegate ----------
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (textField.tag) {
   
        case 1:
            
            if ([self valiMobile:textField.text]) {
                self.PhoneStr =textField.text;
            }else{
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请填写正确的手机号" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
            }
            
            
            break;
        case 2:
            self.NameStr =textField.text;
            break;
        
        default:
            break;
    }
    
    
    
    
}

//判断手机号码格式是否正确
- (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            
            
            return NO;
        }
    }
}
#pragma mark ---------target-----------
-(void)backVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addBtnClick{

    if ([phoneTextField.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请填写被邀请人手机号" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else if ([nameTextField.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请填写被邀请人姓名" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else{
        self.NameStr =nameTextField.text;
        self.PhoneStr =phoneTextField.text;
        [self AddRequest];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------网络请求---------
//添加被邀请人
- (void)AddRequest{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/AddInvite";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"InviteID"] = UserId_New;
    params[@"BeinvitedName"] = self.NameStr;
    params[@"BeinvitedPhone"] =self.PhoneStr;

    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"添加成功!"];
            [self performSelector:@selector(backVC) withObject:nil afterDelay:1.0f];
            
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
