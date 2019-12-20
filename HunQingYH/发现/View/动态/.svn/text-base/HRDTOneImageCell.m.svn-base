//
//  HRDTOneImageCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDTOneImageCell.h"

@implementation HRDTOneImageCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRDTOneImageCell";
    HRDTOneImageCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRDTOneImageCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
    
}
-(void)setDtModel:(HRDongTaiModel *)dtModel{
    _dtModel =dtModel;
    [ _IconImageView sd_setImageWithURL:[NSURL URLWithString:dtModel.DynamicerHeadportrait] placeholderImage:[UIImage imageNamed:@"占位图"]];
    if ([dtModel.DynamicerName isEqualToString:@""]) {
        _nameLab.text =@"未设置姓名";
    }else{
          _nameLab.text =dtModel.DynamicerName;
    }
  
//    if (dtModel.ObjectTypes ==0) {
//         _shenfenLab.text =[NSString stringWithFormat:@"·用户"];
//    }else{
//         _shenfenLab.text =[NSString stringWithFormat:@"·公司"];
//    }
   
    NSString * profession = [CXDataManager checkUserProfession:dtModel.OccupationCode];
    NSString *pro = [profession stringByReplacingOccurrencesOfString:@" " withString:@""];
    _shenfenLab.text = [NSString stringWithFormat:@"·%@",pro];
    
    _timeLab.text =dtModel.CreateTime;
    
    _oneImageView.contentMode = UIViewContentModeScaleAspectFill;
    _oneImageView.clipsToBounds = YES;
    
    [_oneImageView sd_setImageWithURL:[NSURL URLWithString:dtModel.FileId] placeholderImage:[UIImage imageNamed:@"图片"]];
    _desLab.text =dtModel.Content;
    _likeLab.text =[NSString stringWithFormat:@"%zd人喜欢·%zd人评论",dtModel.GivethumbCount,dtModel.CommentsCount];

    
    if (dtModel.State ==1) {
        [_likeBtn setImage:[UIImage imageNamed:@"like_b"] forState:UIControlStateNormal];
    }else{
        [_likeBtn setImage:[UIImage imageNamed:@"like_a"] forState:UIControlStateNormal];
    }
    
    //暂时隐藏关注
    _guanzhuBtn.hidden =YES;
    

    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.IconImageView.clipsToBounds =YES;
    self.IconImageView.layer.cornerRadius =15;
    // Initialization code

  
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
