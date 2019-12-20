
//
//  YPReHomeNormalHeader.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/2.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeNormalHeader.h"

@implementation YPReHomeNormalHeader

+ (instancetype)returnNormalHeader{
    
    YPReHomeNormalHeader *header;
    
    if (!header) {
        header = [[[NSBundle mainBundle] loadNibNamed:@"YPReHomeNormalHeader" owner:nil options:nil] lastObject];
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
