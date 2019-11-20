//
//  HRDTVideoCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/15.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDTVideoCell.h"
#import <UIImageView+AFNetworking.h>

@implementation HRDTVideoCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRDTVideoCell";
    HRDTVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRDTVideoCell" owner:nil options:nil] lastObject];
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
    
    NSString * profession = [CXDataManager checkUserProfession:dtModel.OccupationCode];
    NSString *pro = [profession stringByReplacingOccurrencesOfString:@" " withString:@""];
    _shenfenLab.text = [NSString stringWithFormat:@"·%@",pro];
   
    _timeLab.text =dtModel.CreateTime;
    
    _fenmianImageView.contentMode = UIViewContentModeScaleAspectFill;
    _fenmianImageView.clipsToBounds = YES;
    [_fenmianImageView sd_setImageWithURL:[NSURL URLWithString:dtModel.FileId] placeholderImage:[UIImage imageNamed:@"图片"]];
    _desLab.text =dtModel.Content;
    _likeLab.text =[NSString stringWithFormat:@"%zd人喜欢·%zd人评论",dtModel.GivethumbCount,dtModel.CommentsCount];
    
    
    if (dtModel.State ==1) {
        [_likeBtn setImage:[UIImage imageNamed:@"like_b"] forState:UIControlStateNormal];
    }else{
        [_likeBtn setImage:[UIImage imageNamed:@"like_a"] forState:UIControlStateNormal];
    }
    
    //暂时隐藏关注
//    _guanzhuBtn.hidden =YES;
    
    
    _pinglunLab.hidden =YES;
    
}
- (IBAction)playerClick:(id)sender {
    
//    LSPlayerView* playerView = [LSPlayerView playerView];
//    playerView.index=self.index;
//      NSLog(@"视频的index:%zd",self.index);
//    playerView.currentFrame=_fenmianImageView.frame;
//
//
//
//    //必须先设置tempSuperView在设置videoURL
//    playerView.tempSuperView=self.superview.superview;
//    playerView.videoURL=self.dtModel.Videos;
    if (_delegate && [_delegate respondsToSelector:@selector(cl_tableViewCellPlayVideoWithCell:)]){
        [_delegate cl_tableViewCellPlayVideoWithCell:self];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (CGFloat )getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
