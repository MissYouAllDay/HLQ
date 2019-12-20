//
//  HRMeVideoCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRMeVideoCell.h"
#import <AVFoundation/AVFoundation.h>
@implementation HRMeVideoCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRMeVideoCell";
    HRMeVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRMeVideoCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
-(void)setModel:(YPGetFileSupplierData *)model{
    _model =model;
    self.fmImageView.image =[self thumbnailImageForVideo:[NSURL URLWithString:model.FileUrlHD]];
    if ([model.Status isEqualToString:@"2"]) {
        self.buhegeBtn.hidden =NO;
    }else{
        self.buhegeBtn.hidden =YES;
    }
    
}
//获取视频封面
- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(2.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumbImg = [[UIImage alloc] initWithCGImage:image];
    
    return thumbImg;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.fmImageView.clipsToBounds =YES;
    self.fmImageView.layer.cornerRadius =10;
    self.buhegeBtn.clipsToBounds =YES;
    self.buhegeBtn.layer.cornerRadius =5;
    self.delBtn.layer.borderWidth =1;
    self.delBtn.layer.borderColor =CHJ_bgColor.CGColor;
}
- (IBAction)playClick:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cl_tableViewCellPlayVideoWithCell:)]){
        [_delegate cl_tableViewCellPlayVideoWithCell:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
