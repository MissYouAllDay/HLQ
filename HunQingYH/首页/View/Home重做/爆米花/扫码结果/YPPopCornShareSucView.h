//
//  YPPopCornShareSucView.h
//  HunQingYH
//
//  Created by Else丶 on 2018/3/30.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPPopCornShareSucView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *line1;
@property (weak, nonatomic) IBOutlet UILabel *line2;

+ (instancetype)yp_popCornShareSucView;

@end
