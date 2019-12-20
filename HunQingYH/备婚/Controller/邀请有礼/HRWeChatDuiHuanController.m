//
//  HRWeChatDuiHuanController.m
//  HunQingYH
//
//  Created by Hiro on 2017/12/12.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRWeChatDuiHuanController.h"
#import "YPReceiveAddressController.h"
@interface HRWeChatDuiHuanController ()
{
    UIView *_navView;
}
@property (nonatomic, strong) JVFloatLabeledTextField *CodeTF;
@end

@implementation HRWeChatDuiHuanController
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
    [self setupNav];
    [self setUpUI];
//    [self  getXQRequest];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
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
    titleLab.text = @"兑换礼品";
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
    UIView *inputBgView = [[UIView alloc]initWithFrame:CGRectMake(15, NAVIGATION_BAR_HEIGHT+15, ScreenWidth-30, 50)];
    inputBgView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:inputBgView];
    
    UILabel *desLab = [[UILabel alloc]init];
    desLab.text =@"兑换码:";
    desLab.font =kFont(15);
    
    [inputBgView addSubview:desLab];
    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(inputBgView);
        make.left.mas_equalTo(inputBgView).offset(10);
        make.width.mas_equalTo(80);
    }];
    
    self.CodeTF = [[JVFloatLabeledTextField alloc]init];
    self.CodeTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"请输入兑换码", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.CodeTF.floatingLabelFont = kFont(13);
    self.CodeTF.floatingLabelTextColor = [UIColor brownColor];
    self.CodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.CodeTF setTextAlignment:NSTextAlignmentLeft];
    [inputBgView addSubview:_CodeTF];
    [_CodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(desLab.mas_right);
        make.centerY.mas_equalTo(inputBgView );
        make.right.mas_equalTo(inputBgView);
        make.height.mas_equalTo(inputBgView);
    }];
    
    UIButton *duihuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [duihuanBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [duihuanBtn setTitle:@"兑换礼品" forState:UIControlStateNormal];
    [duihuanBtn addTarget:self action:@selector(duiHuanClick) forControlEvents:UIControlEventTouchUpInside];
    duihuanBtn.backgroundColor =MainColor;
    [self.view addSubview:duihuanBtn];
    [duihuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(inputBgView.mas_bottom).offset(50);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(inputBgView);
        make.right.mas_equalTo(inputBgView);
    }];
    
    //说明区域
    
    


    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+15+150, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-150-15)];
    scrollView.backgroundColor =[UIColor clearColor];
    
    [self.view addSubview:scrollView];
    
    scrollView.contentSize =CGSizeMake(ScreenWidth, ScreenHeight*1.5);
    
    UILabel *lab1= [[UILabel alloc]init];
    lab1.font =kFont(15);
    lab1.textColor =TextNormalColor;
    lab1.text =@"礼品兑换来源：";
    lab1.numberOfLines=0;
    [scrollView addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scrollView.mas_top).offset(10);
        make.left.mas_equalTo(scrollView.mas_left).offset(10);
    }];
//
    UILabel *lab2= [[UILabel alloc]init];
    lab2.font =kFont(15);
    lab2.textColor =TextNormalColor;
    lab2.text =@"一、通过酒店订婚宴";
    lab2.numberOfLines=0;
    [scrollView addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab1.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    UILabel *lab3= [[UILabel alloc]init];
    lab3.font =kFont(15);
    lab3.textColor =TextNormalColor;
    lab3.text =@"a:婚宴费用二万元以下赠送德国360元的美体内衣或国际品牌彩妆";
    lab3.numberOfLines=0;
    [scrollView addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab2.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    UILabel *lab4= [[UILabel alloc]init];
    lab4.font =kFont(15);
    lab4.textColor =TextNormalColor;
    lab4.text =@"b:婚宴费用满二万元赠送德国2580元的美体内衣或国际品牌彩妆";
    lab4.numberOfLines=0;
    [scrollView addSubview:lab4];
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab3.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    UILabel *lab5= [[UILabel alloc]init];
    lab5.font =kFont(15);
    lab5.textColor =TextNormalColor;
    lab5.text =@"c:婚宴费用满十万元即送德国12980元的美体内衣或国际品牌彩妆";
    lab5.numberOfLines=0;
    [scrollView addSubview:lab5];
    [lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab4.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    UILabel *lab6= [[UILabel alloc]init];
    lab6.font =kFont(15);
    lab6.textColor =TextNormalColor;
    lab6.text =@"二、通过平台定婚宴";
    lab6.numberOfLines=0;
    [scrollView addSubview:lab6];
    [lab6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab5.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];

    UILabel *lab7= [[UILabel alloc]init];
    lab7.font =kFont(15);
    lab7.textColor =TextNormalColor;
    lab7.text =@"a:将获得比酒店更优惠的独家优惠";
    lab7.numberOfLines=0;
    [scrollView addSubview:lab7];
    [lab7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab6.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    UILabel *lab8= [[UILabel alloc]init];
    lab8.font =kFont(15);
    lab8.textColor =TextNormalColor;
    lab8.text =@"b:婚宴费用二万元以下赠送德国2580元的美体内衣或国际品牌彩妆";
    lab8.numberOfLines=0;
    [scrollView addSubview:lab8];
    [lab8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab7.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    UILabel *lab9= [[UILabel alloc]init];
    lab9.font =kFont(15);
    lab9.textColor =TextNormalColor;
    lab9.text =@"c:婚宴费用满二万元赠送德国5000元的美体内衣或国际品牌彩妆";
    lab9.numberOfLines=0;
    [scrollView addSubview:lab9];
    [lab9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab8.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    UILabel *lab10= [[UILabel alloc]init];
    lab10.font =kFont(15);
    lab10.textColor =TextNormalColor;
    lab10.text =@"d:婚宴费用满十万元即送德国12980元的美体内衣或国际品牌彩妆";
    lab10.numberOfLines=0;
    [scrollView addSubview:lab10];
    [lab10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab9.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    
    UILabel *lab11= [[UILabel alloc]init];
    lab11.font =kFont(15);
    lab11.textColor =TextNormalColor;
    lab11.text =@"礼品领取方式：";
    lab11.numberOfLines=0;
    [scrollView addSubview:lab11];
    [lab11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab10.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    UILabel *lab12= [[UILabel alloc]init];
    lab12.font =kFont(15);
    lab12.textColor =TextNormalColor;
    lab12.text =@"预定成功将会收到带有兑换码的短信，填写兑换码后即可领取";
    lab12.numberOfLines=0;
    [scrollView addSubview:lab12];
    [lab12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab11.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    UILabel *lab13= [[UILabel alloc]init];
    lab13.font =kFont(15);
    lab13.textColor =TextNormalColor;
    lab13.text =@"1、到婚礼桥平台领取----以邮寄为主";
    lab13.numberOfLines=0;
    [scrollView addSubview:lab13];
    [lab13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab12.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    UILabel *lab14= [[UILabel alloc]init];
    lab14.font =kFont(15);
    lab14.textColor =TextNormalColor;
    lab14.text =@"2、到当地维可莎品牌商场专柜领取（视当地商场入驻为准）";
    lab14.numberOfLines=0;
    [scrollView addSubview:lab14];
    [lab14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab13.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    UILabel *lab15= [[UILabel alloc]init];
    lab15.font =kFont(15);
    lab15.textColor =TextNormalColor;
    lab15.text =@"3、到婚礼桥指定地点领取---随时会在婚礼桥app进行更新提示";
    lab15.numberOfLines=0;
    [scrollView addSubview:lab15];
    [lab15 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab14.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    UILabel *lab16= [[UILabel alloc]init];
    lab16.font =kFont(15);
    lab16.textColor =TextNormalColor;
    lab16.text =@"特别提示：";
    lab16.numberOfLines=0;
    [scrollView addSubview:lab16];
    [lab16 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab15.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    UILabel *lab17= [[UILabel alloc]init];
    lab17.font =kFont(15);
    lab17.textColor =TextNormalColor;
    lab17.text =@"通过酒店订婚宴和通过平台定婚宴的赠送礼品，只能选其一。";
    lab17.numberOfLines=0;
    [scrollView addSubview:lab17];
    [lab17 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab16.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
    UILabel *lab18= [[UILabel alloc]init];
    lab18.font =kFont(15);
    lab18.textColor =TextNormalColor;
    lab18.text =@"详情请咨询15192055999（同微信）";
    lab18.numberOfLines=0;
    [scrollView addSubview:lab18];
    [lab18 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab17.mas_bottom).offset(20);
        make.left.mas_equalTo(scrollView.mas_left).offset(15);
        make.width.mas_equalTo(ScreenWidth-30);
    }];
}
#pragma mark -------------target-----------
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)duiHuanClick{
    [self checkRequest];
}

-(void)goAddress{
    YPReceiveAddressController *address = [[YPReceiveAddressController alloc]init];
    address.ObjectTypes =6;//微信投票暂时关闭，传6酒店领取奖品
    address.grade = 0;;
    address.ActivityID = self.ActivityID;
    address.ActivityPrizesID =0;
    address.weiCode =self.CodeTF.text;
    [self.navigationController pushViewController:address animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------网络请求-------------
//查看活动详情
- (void)getXQRequest{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/Corp/GetActivityInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ObjectTypes"]   = @2;
    params[@"ObjectID"] =UserId_New;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.ActivityID = [object valueForKey:@"ActivityID"];
            
          
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

//判断奖品编码是否失效
- (void)checkRequest{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/Corp/IsCargoCodeLapse";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"CargoCode"]   =self.CodeTF.text;

    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"未失效");
           
            [EasyShowTextView showSuccessText:@"验证成功"];
             [self performSelector:@selector(goAddress) withObject:nil afterDelay:1.0f];
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
