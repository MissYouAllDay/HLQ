//
//  YPReMeHeaderView.h
//  HunQingYH
//
//  Created by Else丶 on 2018/1/15.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPReMeHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profession;
@property (weak, nonatomic) IBOutlet UILabel *guanZhu;
@property (weak, nonatomic) IBOutlet UILabel *fenSi;
@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
//@property (weak, nonatomic) IBOutlet UIButton *setBtn;
@property (weak, nonatomic) IBOutlet UILabel *point;
@property (weak, nonatomic) IBOutlet UIButton *maskBtn;

+ (instancetype)yp_ReMeHeaderView;

@end
