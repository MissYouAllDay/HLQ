//
//  YPReLoginIdentityView.h
//  HunQingYH
//
//  Created by Else丶 on 2018/7/12.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickBlock)(UIButton *sender);

@interface YPReLoginIdentityView : UIView

@property (weak, nonatomic) IBOutlet UIButton *xinrenBtn;
@property (weak, nonatomic) IBOutlet UILabel *xinren;
@property (weak, nonatomic) IBOutlet UIButton *gongyingshangBtn;
@property (weak, nonatomic) IBOutlet UILabel *gongyingshang;
@property (weak, nonatomic) IBOutlet UIButton *hotelBtn;
@property (weak, nonatomic) IBOutlet UILabel *hotel;
@property (weak, nonatomic) IBOutlet UIButton *companyBtn;
@property (weak, nonatomic) IBOutlet UILabel *company;

@property (weak, nonatomic) IBOutlet UIButton *areaBtn;

@property (nonatomic, copy) ButtonClickBlock btnClickBlock;

+ (instancetype)yp_reloginIdentityView;

@end
