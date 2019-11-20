//
//  YPReLoginOtherWayView.h
//  HunQingYH
//
//  Created by Else丶 on 2018/6/28.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickBlock)(NSString *btnClass);

@interface YPReLoginOtherWayView : UIView

@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;

@property (nonatomic, copy) ButtonClickBlock btnClickBlock;

+ (instancetype)yp_reLoginOtherWayView;

@end
