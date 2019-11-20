//
//  HRDTPingLunCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDTPingLunCell.h"

@implementation HRDTPingLunCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRDTPingLunCell";
    HRDTPingLunCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRDTPingLunCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
    
}
-(void)setModel:(HRPingLunModel *)model{
    _model =model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.CommentsHeadportrait] placeholderImage:[UIImage imageNamed:@"占位"]];
    
    self.nameLab.text =model.CommentserName;
    self.contentLab.text =model.CommentsContent;
    self.timeLab.text =model.CommentsCreateTime;
    self.shenfenLabel.text = [CXDataManager checkUserProfession:model.Profession];
}

- (void)setPingModel:(YPGetWeddingPackageEvaluateList *)pingModel{
    _pingModel = pingModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_pingModel.PeopleImage] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    
    if (_pingModel.PeopleName.length > 0) {
        self.nameLab.text = _pingModel.PeopleName;
    }else{
        self.nameLab.text = @"无姓名";
    }
    self.contentLab.text = _pingModel.Content;
    self.timeLab.text = _pingModel.CreateTime;
//    self.shenfenLabel.text = [NSString stringWithFormat:@" %@ ",_pingModel.PeopleOccupation];
    self.shenfenLabel.text = [CXDataManager checkUserProfession:_pingModel.PeopleOccupation];
  
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _likeBtn.hidden  =YES;
    _iconImageView.clipsToBounds =YES;
    _iconImageView.layer.cornerRadius =20;
    _likeLab.hidden =YES;
    
    self.shenfenLabel.layer.cornerRadius = 3;
    self.shenfenLabel.clipsToBounds = YES;
    self.shenfenLabel.backgroundColor = RGB(250, 80, 120);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
