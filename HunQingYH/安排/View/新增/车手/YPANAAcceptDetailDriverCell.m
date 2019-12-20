//
//  YPANAAcceptDetailDriverCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/21.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPANAAcceptDetailDriverCell.h"

@implementation YPANAAcceptDetailDriverCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPANAAcceptDetailDriverCell";
    YPANAAcceptDetailDriverCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPANAAcceptDetailDriverCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setModel:(YPCaptainGetResponseStatus *)model{
    _model = model;
    
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:_model.Img] placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.nameLabel.text = _model.Name;
    self.carLabel.text = _model.ModelName;
    
    if ([_model.AnswerStatus integerValue] == 0) {//0未应答,1已接受,2已拒绝
        self.stateLabel.text = @"待接受";
        self.stateLabel.textColor = GrayColor;
    }else if ([_model.AnswerStatus integerValue] == 1){
        self.stateLabel.text = @"已接受";
        self.stateLabel.textColor = RGB(0, 132, 0);
    }else if ([_model.AnswerStatus integerValue] == 1){
        self.stateLabel.text = @"已拒绝";
        self.stateLabel.textColor = [UIColor redColor];
        self.phoneBtn.hidden = YES;
    }
}

- (IBAction)phoneBtnClick:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",_model.PhoneNo]]];
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 3;
    _iconImgV.clipsToBounds = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
