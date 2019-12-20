

//
//  CXReviceSuccessVC.m
//  HunQingYH
//
//  Created by apple on 2019/9/29.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXReviceSuccessVC.h"

@interface CXReviceSuccessVC ()

@end

@implementation CXReviceSuccessVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"领取成功";
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = self.subBtn.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.2),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[RGB(255, 0, 123) CGColor],(id)[RGB(255, 83, 103) CGColor]]];//渐变数组
    [self.subBtn.layer addSublayer:gradientLayer];
    self.subBtn.layer.cornerRadius = self.subBtn.height/2;
    self.subBtn.clipsToBounds = YES;
    
    NSMutableParagraphStyle *parag = [[NSMutableParagraphStyle alloc] init];
    parag.minimumLineHeight = 100;
    parag.alignment = NSTextAlignmentCenter;
    
    if (self.name.length == 0) { self.name = @""; }
    NSString *text = [NSString stringWithFormat:@"您已成功领取伴手礼\n%@",self.name];
    NSMutableAttributedString *alert = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName:parag}];
    self.alertLab.attributedText = alert;
}

- (IBAction)subBtnAction:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
