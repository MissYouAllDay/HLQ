//
//  HRDTThreeImageCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDTThreeImageCell.h"

@implementation HRDTThreeImageCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRDTThreeImageCell";
    HRDTThreeImageCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRDTThreeImageCell" owner:nil options:nil] lastObject];
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
//        _shenfenLab.text =[NSString stringWithFormat:@"·用户"];
//    }else{
//        _shenfenLab.text =[NSString stringWithFormat:@"·公司"];
//    }
    NSString * profession = [CXDataManager checkUserProfession:dtModel.OccupationCode];
    NSString *pro = [profession stringByReplacingOccurrencesOfString:@" " withString:@""];
    _shenfenLab.text = [NSString stringWithFormat:@"·%@",pro];
    
    _timeLab.text =dtModel.CreateTime;
    NSArray *array = [dtModel.FileId componentsSeparatedByString:@","];
  
    
    _oneImageView.contentMode = UIViewContentModeScaleAspectFill;
    _oneImageView.clipsToBounds = YES;
    
    _twoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _twoImageView.clipsToBounds = YES;
    _threeImageView.contentMode = UIViewContentModeScaleAspectFill;
    _threeImageView.clipsToBounds = YES;
    [_oneImageView sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:[UIImage imageNamed:@"图片"]];
    [_twoImageView sd_setImageWithURL:[NSURL URLWithString:array[1]] placeholderImage:[UIImage imageNamed:@"图片"]];
      [_threeImageView sd_setImageWithURL:[NSURL URLWithString:array[2]] placeholderImage:[UIImage imageNamed:@"图片"]];
    if (array.count>3) {
        _photoNumBgView.hidden =NO;
        _photoNumLab.text =[NSString stringWithFormat:@"%zd",array.count];
    }else{
        _photoNumBgView.hidden =YES;
    }
   
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
    // Initialization code
    self.IconImageView.clipsToBounds =YES;
    self.IconImageView.layer.cornerRadius =15;
    self.photoNumBgView.clipsToBounds =YES;
    self.photoNumBgView.layer.cornerRadius =2;
    
    // 根据文本内容的宽度动态改变label的宽度  （宽度最大值为screenwidth-120）
    
    // 根据字体得到label的内容的尺寸
    CGSize size = [self.nameLab.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.nameLab.font,NSFontAttributeName,nil]];
    // label的内容的宽度
    CGFloat JGlabelContentWidth = size.width;
    
    // 如果label的内容的宽度度超过150，则label的宽度就设置为150，即label的最大宽度为150
    if (JGlabelContentWidth >= ScreenWidth-120) {
        JGlabelContentWidth = ScreenWidth-120;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
