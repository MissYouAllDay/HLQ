//
//  YPHunJJTicketVerifyView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/7/6.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHunJJTicketVerifyView.h"

@implementation YPHunJJTicketVerifyView

+ (instancetype)yp_ticketVerifyView{
    YPHunJJTicketVerifyView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPHunJJTicketVerifyView" owner:nil options:nil]lastObject];
    }
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
