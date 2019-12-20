//
//  YPHunJJTicketVerifyView.h
//  HunQingYH
//
//  Created by Else丶 on 2018/7/6.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPHunJJTicketVerifyView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *codeImgV;
@property (weak, nonatomic) IBOutlet UILabel *deadLine;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyTime;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *useState;

+ (instancetype)yp_ticketVerifyView;

@end
