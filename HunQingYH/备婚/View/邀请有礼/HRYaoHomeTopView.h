//
//  HRYaoHomeTopView.h
//  HunQingYH
//
//  Created by Hiro on 2017/11/30.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRYaoHomeTopView : UIView
+ (instancetype)inviteView;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;
@property (weak, nonatomic) IBOutlet UIButton *guiTuBtn;
@property (weak, nonatomic) IBOutlet UIButton *guiBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneTuBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *fenTuBtn;
@property (weak, nonatomic) IBOutlet UIButton *fenBtn;

@end
