//
//  YPDetailRulerView.m
//  hunqing
//
//  Created by Else丶 on 2017/11/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPDetailRulerView.h"

@implementation YPDetailRulerView

+ (instancetype)detailRulerView{
   YPDetailRulerView *rulerView = [[[NSBundle mainBundle] loadNibNamed:@"YPDetailRulerView" owner:nil options:nil] lastObject];
    return rulerView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
