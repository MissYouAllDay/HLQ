//
//  CXApplyReceiveMoneyView.h
//  HunQingYH
//
//  Created by canxue on 2019/12/29.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - 全额返现 我要报名- - - - - - - - - - - - - - - - - - - - - -

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXApplyReceiveMoneyView : UIView

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIView *nameBgView;
@property (weak, nonatomic) IBOutlet UIView *telBgView;
@property (weak, nonatomic) IBOutlet UIView *hunQiBgView;
@property (weak, nonatomic) IBOutlet UIView *addressBgView;
@property (weak, nonatomic) IBOutlet UIView *tabNumBgView;
@property (weak, nonatomic) IBOutlet UIView *canbiaoBgView;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *telTF;
@property (weak, nonatomic) IBOutlet UITextField *hunqiTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *tabNumTF;
@property (weak, nonatomic) IBOutlet UITextField *canbiaoTF;


@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@property (weak, nonatomic) IBOutlet UIView *bgView;



- (IBAction)closeBtn:(UIButton *)sender;


- (void)showView;


@end

NS_ASSUME_NONNULL_END
