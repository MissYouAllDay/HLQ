//
//  CXGiftGoodDetailView.h
//  HunQingYH
//
//  Created by apple on 2019/10/31.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXActivityCouponModel.h"   // model

NS_ASSUME_NONNULL_BEGIN

@interface CXGiftGoodDetailView : UIView

@property (nonatomic, strong) CXActivityCouponModel  *model;    // <#这里是个注释哦～#>
@property (weak, nonatomic) IBOutlet UIView *mainBgView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImg;
@property (weak, nonatomic) IBOutlet UILabel *activityName;

@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UILabel *limitLab;
@property (weak, nonatomic) IBOutlet UILabel *receiveLab;

@property (weak, nonatomic) IBOutlet UIImageView *shopImg;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopAddressLab;   
@property (weak, nonatomic) IBOutlet UIButton *telBtn;  //。客服
@property (weak, nonatomic) IBOutlet UILabel *validityTimeLab;  // 有效期
@property (weak, nonatomic) IBOutlet UILabel *subInfoLimitelab; // 预约信息



@end

NS_ASSUME_NONNULL_END
