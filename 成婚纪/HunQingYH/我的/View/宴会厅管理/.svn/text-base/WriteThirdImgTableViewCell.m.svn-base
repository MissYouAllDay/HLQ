//
//  WriteThirdImgTableViewCell.m
//  Coupon
//
//  Created by mac on 16/1/30.
//  Copyright © 2016年 shanshanxu. All rights reserved.
//

#import "WriteThirdImgTableViewCell.h"

@implementation WriteThirdImgTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [_bt1 setAdjustsImageWhenHighlighted:NO];
    [_bt2 setAdjustsImageWhenHighlighted:NO];
    [_bt3 setAdjustsImageWhenHighlighted:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onClick:(UIButton *)sender {
    NSLog(@"onclick");
    if (sender.selected) {
        if ([self.delegate respondsToSelector:@selector(onBtClickForDel:)]) {
                NSLog(@"onclick1");
            [self.delegate onBtClickForDel:sender.tag];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(onBtClickForPick)]) {
                NSLog(@"onclick2");
            [self.delegate onBtClickForPick];
        }
    }

}
+(CGFloat)getHeight
{
 
    return( ScreenWidth-30)/3+10;
}
@end
