//
//  YPMeYanHuiTingDetailInfoView.h
//  HunQingYH
//
//  Created by Else丶 on 2018/11/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPMeYanHuiTingDetailInfoView : UIView

@property (weak, nonatomic) IBOutlet UILabel *tingName;
@property (weak, nonatomic) IBOutlet UILabel *mianji;
@property (weak, nonatomic) IBOutlet UILabel *cenggao;
@property (weak, nonatomic) IBOutlet UILabel *whLabel;
@property (weak, nonatomic) IBOutlet UILabel *tableCount;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)yp_MeYanHuiTingDetailInfoView;

@end

NS_ASSUME_NONNULL_END
