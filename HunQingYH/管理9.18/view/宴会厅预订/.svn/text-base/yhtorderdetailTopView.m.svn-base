//
//  yhtorderdetailTopView.m
//  HunQingYH
//
//  Created by xl on 2019/6/22.
//  Copyright © 2019 xl. All rights reserved.
//

#import "yhtorderdetailTopView.h"

@implementation yhtorderdetailTopView
+(instancetype)initViewWithXib{
    yhtorderdetailTopView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"yhtorderdetailTopView" owner:nil options:nil]lastObject];
    }
    return view;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor =CHJ_bgColor;
    self.contentView.backgroundColor=WhiteColor;
    self.contentView.clipsToBounds =YES;
    self.contentView.layer.cornerRadius =5;
    self.iconImageView.clipsToBounds =YES;
    self.iconImageView.layer.cornerRadius =35;
}
@end
