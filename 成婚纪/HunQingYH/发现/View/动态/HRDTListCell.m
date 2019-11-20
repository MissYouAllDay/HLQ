//
//  HRDTListCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/5/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDTListCell.h"
#import <AVFoundation/AVFoundation.h>


@implementation HRDTListCell
-(void)setDtModel:(HRDongTaiModel *)dtModel{
    _dtModel =dtModel;
    if (_dtModel.Content.length > 0) {
        _desLab.text = dtModel.Content;
    }else{
        _desLab.text = @"当前无内容";
    }
    [ _iconImageView sd_setImageWithURL:[NSURL URLWithString:dtModel.DynamicerHeadportrait] placeholderImage:[UIImage imageNamed:@"占位图"]];
    if ([dtModel.DynamicerName isEqualToString:@""]) {
        _nameLab.text =@"未设置姓名";
    }else{
        _nameLab.text =dtModel.DynamicerName;
    }
//    _timeLab.text =dtModel.CreateTime;
    _numLab.text =[NSString stringWithFormat:@"%zd",dtModel.GivethumbCount];
    if (dtModel.State ==1) {
        [_likeBtn setImage:[UIImage imageNamed:@"HLX_like_red"] forState:UIControlStateNormal];
    }else{
        [_likeBtn setImage:[UIImage imageNamed:@"HLX_like"] forState:UIControlStateNormal];
    }
    if (dtModel.FileType==2 ) {
        self.videoImgV.hidden = NO;
//        [_FMImageView sd_setImageWithURL:[NSURL URLWithString:dtModel.CoverImg]];
        
    }else{
        self.videoImgV.hidden = YES;
//        [_FMImageView sd_setImageWithURL:[NSURL URLWithString:dtModel.CoverImg] ];
        
    }
    
    
}

- (void)setListModel:(YPGetSupplierDynamicList *)listModel{
    _listModel = listModel;
 
    if (_listModel.Content.length > 0) {
        _desLab.text = _listModel.Content;
    }else{
        _desLab.text = @"当前无内容";
    }
    
    [ _iconImageView sd_setImageWithURL:[NSURL URLWithString:_listModel.DynamicerHeadportrait] placeholderImage:[UIImage imageNamed:@"占位图"]];
    if ([_listModel.DynamicerName isEqualToString:@""]) {
        _nameLab.text = @"未设置姓名";
    }else{
        _nameLab.text = _listModel.DynamicerName;
    }
//    _timeLab.text = _listModel.CreateTime;
    
    _numLab.text = [NSString stringWithFormat:@"%zd",_listModel.GivethumbCount];
    
    
    if (_listModel.State == 1) {
        [_likeBtn setImage:[UIImage imageNamed:@"HLX_like_red"] forState:UIControlStateNormal];
    }else{
        [_likeBtn setImage:[UIImage imageNamed:@"HLX_like"] forState:UIControlStateNormal];
    }
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    _iconImageView.clipsToBounds =YES;
    _iconImageView.layer.cornerRadius = 9;
    _FMImageView.contentMode = UIViewContentModeScaleAspectFill;
    _FMImageView.clipsToBounds = YES;
    

}

@end
