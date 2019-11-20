//
//  HRLotteryCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/29.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRLotteryCell.h"

@implementation HRLotteryCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        50*43
        float height=frame.size.height;
        float width=frame.size.width;
        self.image=[UIImage imageNamed:@"l3"];
        float imageWidth=17;
        float orginX=6;
        
        // float width=frame.size.width;
        _titleImageView=[[UIImageView alloc] initWithFrame:CGRectMake(orginX, (height-imageWidth)/2, imageWidth, imageWidth)];
        _titleImageView.image=[UIImage imageNamed:@"l1"];
        [self addSubview:_titleImageView];
        _label=[[UILabel alloc] initWithFrame:CGRectMake(orginX+imageWidth, (height-imageWidth)/2, frame.size.width, imageWidth)];
        [self addSubview:_label];
        
        
        _label.font=[UIFont systemFontOfSize:13];
        
        
        _label.textAlignment=NSTextAlignmentCenter;
        
        
        
        _label.textColor=[UIColor colorWithRed:0.74 green:0.46 blue:0.07 alpha:1];
        
        
    }
    return self;
}


@end
