//
//  YPReHomeNormalHeader.h
//  HunQingYH
//
//  Created by Else丶 on 2018/1/2.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPReHomeNormalHeader : UIView

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImgV;

+ (instancetype)returnNormalHeader;

@end
