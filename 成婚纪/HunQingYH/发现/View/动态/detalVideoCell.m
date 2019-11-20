//
//  VideoCell.m
//  WMVideoPlayer
//
//  Created by zhengwenming on 16/1/17.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "detalVideoCell.h"
#import "VideoModel.h"
#import "UIImageView+WebCache.h"

@implementation detalVideoCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
//-(void)setDtModel:(HRDongTaiModel *)dtModel{
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    _dtModel =dtModel;
//
//
//
//
//    _backgroundIV.contentMode = UIViewContentModeScaleAspectFit;
//    _backgroundIV.clipsToBounds = YES;
//    [_backgroundIV sd_setImageWithURL:[NSURL URLWithString:dtModel.Imgs] placeholderImage:[UIImage imageNamed:@"图片"]];
//
//
//}
@end
