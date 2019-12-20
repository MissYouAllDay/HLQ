//
//  YPReReHomeHeader.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReReHomeHeader.h"

@implementation YPReReHomeHeader

+ (instancetype)yp_rereHomeHeader{
    
    YPReReHomeHeader *header;
    if (!header) {
        header = [[[NSBundle mainBundle]loadNibNamed:@"YPReReHomeHeader" owner:nil options:nil]lastObject];
    }
    return header;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
