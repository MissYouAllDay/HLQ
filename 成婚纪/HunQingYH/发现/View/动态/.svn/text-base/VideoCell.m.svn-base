//
//  VideoCell.m
//  WMVideoPlayer
//
//  Created by zhengwenming on 16/1/17.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "VideoCell.h"
#import "VideoModel.h"
#import "UIImageView+WebCache.h"

@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)plackClick:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cl_tableViewCellPlayVideoWithCell:)]){
        [_delegate cl_tableViewCellPlayVideoWithCell:self];
    }
}
-(void)setDtModel:(HRDongTaiModel *)dtModel{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _dtModel =dtModel;
    
    [ _IconImageView sd_setImageWithURL:[NSURL URLWithString:dtModel.DynamicerHeadportrait] placeholderImage:[UIImage imageNamed:@"占位图"]];
    if ([dtModel.DynamicerName isEqualToString:@""]) {
        _nameLab.text =@"未设置姓名";
    }else{
        _nameLab.text =dtModel.DynamicerName;
    }
    
    _shenfenLab.text = [CXDataManager checkUserProfession:dtModel.OccupationCode];
    
    _timeLab.text =dtModel.CreateTime;
    
    _backgroundIV.contentMode = UIViewContentModeScaleAspectFit;
    _backgroundIV.clipsToBounds = YES;
    [_backgroundIV sd_setImageWithURL:[NSURL URLWithString:dtModel.FileId] placeholderImage:[UIImage imageNamed:@"图片"]];
    _desLab.text =dtModel.Content;
    _likeLab.text =[NSString stringWithFormat:@"%zd人喜欢·%zd人评论",dtModel.GivethumbCount,dtModel.CommentsCount];
  
    
    if (dtModel.State ==1) {
        [_likeBtn setImage:[UIImage imageNamed:@"like_b"] forState:UIControlStateNormal];
    }else{
        [_likeBtn setImage:[UIImage imageNamed:@"like_a"] forState:UIControlStateNormal];
    }
    
    self.desLabHeight.constant =[self getHeighWithTitle:dtModel.Content font:kFont(15) width:(ScreenWidth -30)];


}

#pragma mark - 动态计算label高度
- (CGFloat )getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
    
}

@end
