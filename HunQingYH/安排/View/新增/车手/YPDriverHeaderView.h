//
//  YPDriverHeaderView.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/22.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPDriverHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *xiangshu;
@property (weak, nonatomic) IBOutlet UILabel *pailiang;
@property (weak, nonatomic) IBOutlet UIImageView *xialaImgV;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

+ (instancetype)driverHeaderView;

@end
