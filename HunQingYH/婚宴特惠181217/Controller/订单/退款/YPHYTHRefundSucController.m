//
//  YPHYTHRefundSucController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/14.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHRefundSucController.h"
#import "YPHYTHOrderBaseController.h"

@interface YPHYTHRefundSucController ()

@end

@implementation YPHYTHRefundSucController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupUI];
    [self setupNav];
    
}

#pragma mark - UI
- (void)setupUI{
    
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HYTH_refund"]];
    [self.view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT+44);
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"退款申请提交成功！";
    label.textColor = RGBS(51);
    label.font = kFont(20);
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgV.mas_bottom).mas_offset(36);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"请等待我们的审核";
    label1.textColor = RGBS(153);
    label1.font = kFont(13);
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).mas_offset(24);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIButton *sureBtn = [[UIButton alloc]init];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[self gradientImageWithBounds:CGRectMake(0, 0, 270, 40) andColors:@[RGBA(249, 35, 123, 1),RGBA(248, 99, 103, 1)] andGradientType:1] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[self gradientImageWithBounds:CGRectMake(0, 0, 270, 40) andColors:@[RGBA(249, 35, 123, 1),RGBA(248, 99, 103, 1)] andGradientType:1] forState:UIControlStateHighlighted];
    sureBtn.titleLabel.font = kFont(14);
    sureBtn.layer.cornerRadius = 20;
    sureBtn.clipsToBounds = YES;
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).mas_offset(140);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(270, 40));
    }];
    
}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [backBtn setTitleColor:RGBS(51) forState:UIControlStateNormal];
    backBtn.titleLabel.font = kFont(16);
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView).mas_offset(18);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"退款";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sureBtnClick{
    UIViewController *mineVC = nil;
    for (UIViewController * controller in self.navigationController.viewControllers) {
        //遍历
        if([controller isKindOfClass:[YPHYTHOrderBaseController class]]){
            //这里判断是否为你想要跳转的页面
            mineVC = controller;
            break;
        }
    }
    [self.navigationController popToViewController:mineVC  animated:YES];
}

#pragma mark - 渐变色Image
- (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(int)gradientType{
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(bounds.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    
    CGPoint start;
    CGPoint end;
    
    switch (gradientType) {
        case 0://纵向渐变
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, bounds.size.height);
            break;
        case 1://横向渐变
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(bounds.size.width, 0.0);
            break;
        default:
            start = CGPointZero;
            end = CGPointZero;
            break;
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
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
