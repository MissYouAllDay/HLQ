//
//  YPToBeCheckListCell.m
//  hunqing
//
//  Created by Else丶 on 2018/3/15.
//  Copyright © 2018年 DiKai. All rights reserved.
//

#import "YPToBeCheckListCell.h"

@implementation YPToBeCheckListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPToBeCheckListCell";
    YPToBeCheckListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPToBeCheckListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setListModel:(YPGetUploadedFileList *)listModel{
    _listModel = listModel;
    
    if (_listModel.GroomName.length > 0) {
        self.manName.text = _listModel.GroomName;
    }else{
        self.manName.text = @"无姓名";
    }
    if (_listModel.GroomPhone.length > 0) {
        self.manPhone.text = _listModel.GroomPhone;
    }else{
        self.manPhone.text = @"无手机号";
    }
    if (_listModel.BrideName.length > 0) {
        self.womanName.text = _listModel.BrideName;
    }else{
        self.womanName.text = @"无姓名";
    }
    if (_listModel.BridePhone.length > 0) {
        self.womanPhone.text = _listModel.BridePhone;
    }else{
        self.womanPhone.text = @"无手机号";
    }
    
    if ([_listModel.FileType integerValue] == 1) {//1图片 2视频
        self.tagImgV.image = [UIImage imageNamed:@"PV_picture"];
    }else if ([_listModel.FileType integerValue] == 2){
        self.tagImgV.image = [UIImage imageNamed:@"PV_video"];
    }
    
    if (_listModel.UpsName.length > 0) {
        self.authorLabel.text = _listModel.UpsName;
    }else{
        self.authorLabel.text = @"无姓名";
    }

}

- (void)setManView:(UIView *)manView{
    _manView = manView;
    
    _manView.layer.cornerRadius = 3.5;
    _manView.clipsToBounds = YES;
}

- (void)setWomanView:(UIView *)womanView{
    _womanView = womanView;
    
    _womanView.layer.cornerRadius = 3.5;
    _womanView.clipsToBounds = YES;
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
