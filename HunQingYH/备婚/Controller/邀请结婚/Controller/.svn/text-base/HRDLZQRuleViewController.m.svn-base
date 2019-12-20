//
//  HRDLZQRuleViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/6.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDLZQRuleViewController.h"

@interface HRDLZQRuleViewController ()
{
    UIView *_navView;
}
@end

@implementation HRDLZQRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setMainUI];
}
#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_01"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    
 
    
    self.view.backgroundColor = WhiteColor;
}

-(void)setMainUI{
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text =@"赚钱规则";
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:30]];
    titleLab.textColor =BlackColor;
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).offset(50);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        
    }];
    
    UILabel *desLab1 = [[UILabel alloc]init];
    desLab1.text =@"1、每个有效单的劳务费请与举办该活动的商家自行沟通，活动到达截至日期即为该活动结束，请及时自行与商家结算。";
    [desLab1 setFont:kFont(15)];
    desLab1.textColor =TextNormalColor;
    desLab1.numberOfLines =0;
    [self.view addSubview:desLab1];
    [desLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLab.mas_bottom).offset(50);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        
    }];
    UILabel *desLab2 = [[UILabel alloc]init];
    desLab2.text =@"2、每个人生成的专属二维码既可以通过微信分享给其他人，也可以当面展示给他人。只要别人填写资料即视为有效单。";
    [desLab2 setFont:kFont(15)];
    desLab2.textColor =TextNormalColor;
    desLab2.numberOfLines =0;
    [self.view addSubview:desLab2];
    [desLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(desLab1.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        
    }];
    
    
    UILabel *cantitleLab = [[UILabel alloc]init];
    cantitleLab.text =@"推广话术参考：";
    [cantitleLab setFont:kFont(15)];
    cantitleLab.textColor =TextNormalColor;
    cantitleLab.numberOfLines =0;
    [self.view addSubview:cantitleLab];
    [cantitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(desLab2.mas_bottom).offset(30);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        
    }];
    
    UILabel *cankaoLab = [[UILabel alloc]init];
    cankaoLab.text =@"哥或姐,你身边有朋友要结婚吗？推荐一个在婚礼桥签单成功就返还你婚礼单值的10%。";
    [cankaoLab setFont:kFont(15)];
    cankaoLab.textColor =TextNormalColor;
    cankaoLab.numberOfLines =0;
    [self.view addSubview:cankaoLab];
    [cankaoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cantitleLab.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        
    }];
}
-(void)backVC{
    [self dismissViewControllerAnimated:YES completion:nil];
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
