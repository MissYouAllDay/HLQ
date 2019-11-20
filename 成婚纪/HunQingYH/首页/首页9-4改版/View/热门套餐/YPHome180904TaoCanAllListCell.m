//
//  YPHome180904TaoCanAllListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHome180904TaoCanAllListCell.h"

@implementation YPHome180904TaoCanAllListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHome180904TaoCanAllListCell";
    YPHome180904TaoCanAllListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHome180904TaoCanAllListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setListModel:(YPGetWeddingPackageList *)listModel{
    _listModel = listModel;
    
    if (_listModel.Name.length > 0) {
        _titleLabel.text = _listModel.Name;
    }else{
        _titleLabel.text = @"无名称";
    }
    if (_listModel.Label.length > 0) {
        _tag1.text = [_listModel.Label stringByReplacingOccurrencesOfString:@"," withString:@" | "];
    }else{
        _tag1.text = @"无关键字";
    }
    _priceLabel.text = [NSString stringWithFormat:@"¥%zd",[_listModel.PresentPrice integerValue]];
    
    [_imgV1 sd_setImageWithURL:[NSURL URLWithString:listModel.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    
//    NSArray<YPGetWeddingPackageListAreaData *> *areaArr = _listModel.AreaData;
//    YPGetWeddingPackageListAreaData *areaData;
//    YPGetWeddingPackageListAreaDataImageData *imgData;
//    if (areaArr.count >= 3) {
//        //图片1
//        areaData = areaArr[0];
//        if (areaData.AreaName.length > 0) {
//            _bigLab.text = areaData.AreaName;
//        }else{
//            _bigLab.text = @"无名称";
//        }
//        if (areaData.ImageData.count > 0) {
//            imgData = areaData.ImageData[0];
//            [_imgV1 sd_setImageWithURL:[NSURL URLWithString:imgData.Image] placeholderImage:[UIImage imageNamed:@"图片占位"]];
//        }else{
//            [_imgV1 setImage:[UIImage imageNamed:@"图片占位"]];
//        }
//
//        //图片2
//        areaData = areaArr[1];
//        if (areaData.AreaName.length > 0) {
//            _label2.text = areaData.AreaName;
//        }else{
//            _label2.text = @"无名称";
//        }
//        if (areaData.ImageData.count > 0) {
//            imgData = areaData.ImageData[0];
//            [_imgV2 sd_setImageWithURL:[NSURL URLWithString:imgData.Image] placeholderImage:[UIImage imageNamed:@"图片占位"]];
//        }else{
//            [_imgV2 setImage:[UIImage imageNamed:@"图片占位"]];
//        }
//
//        //图片3
//        areaData = areaArr[2];
//        if (areaData.AreaName.length > 0) {
//            _label3.text = areaData.AreaName;
//        }else{
//            _label3.text = @"无名称";
//        }
//        if (areaData.ImageData.count > 0) {
//            imgData = areaData.ImageData[0];
//            [_imgV3 sd_setImageWithURL:[NSURL URLWithString:imgData.Image] placeholderImage:[UIImage imageNamed:@"图片占位"]];
//        }else{
//            [_imgV3 setImage:[UIImage imageNamed:@"图片占位"]];
//        }
//
//    }else if (areaArr.count == 2){
//
//        //图片1
//        areaData = areaArr[0];
//        if (areaData.AreaName.length > 0) {
//            _bigLab.text = areaData.AreaName;
//        }else{
//            _bigLab.text = @"无名称";
//        }
//        if (areaData.ImageData.count > 0) {
//            imgData = areaData.ImageData[0];
//            [_imgV1 sd_setImageWithURL:[NSURL URLWithString:imgData.Image] placeholderImage:[UIImage imageNamed:@"图片占位"]];
//        }else{
//            [_imgV1 setImage:[UIImage imageNamed:@"图片占位"]];
//        }
//
//        //图片2
//        areaData = areaArr[1];
//        if (areaData.AreaName.length > 0) {
//            _label2.text = areaData.AreaName;
//        }else{
//            _label2.text = @"无名称";
//        }
//        if (areaData.ImageData.count > 0) {
//            imgData = areaData.ImageData[0];
//            [_imgV2 sd_setImageWithURL:[NSURL URLWithString:imgData.Image] placeholderImage:[UIImage imageNamed:@"图片占位"]];
//        }else{
//            [_imgV2 setImage:[UIImage imageNamed:@"图片占位"]];
//        }
//
//        //图片3
//        _label3.text = @"无名称";
//        [_imgV3 setImage:[UIImage imageNamed:@"图片占位"]];
//
//    }else if (areaArr.count == 1){
//
//        //图片1
//        areaData = areaArr[0];
//        if (areaData.AreaName.length > 0) {
//            _bigLab.text = areaData.AreaName;
//        }else{
//            _bigLab.text = @"无名称";
//        }
//        if (areaData.ImageData.count > 0) {
//            imgData = areaData.ImageData[0];
//            [_imgV1 sd_setImageWithURL:[NSURL URLWithString:imgData.Image] placeholderImage:[UIImage imageNamed:@"图片占位"]];
//        }else{
//            [_imgV1 setImage:[UIImage imageNamed:@"图片占位"]];
//        }
//
//        //图片2
//        _label2.text = @"无名称";
//        [_imgV2 setImage:[UIImage imageNamed:@"图片占位"]];
//
//        //图片3
//        _label3.text = @"无名称";
//        [_imgV3 setImage:[UIImage imageNamed:@"图片占位"]];
//
//    }else if (areaArr.count == 0){
//
//        //图片1
//        _bigLab.text = @"无名称";
//        [_imgV1 setImage:[UIImage imageNamed:@"图片占位"]];
//
//        //图片2
//        _label2.text = @"无名称";
//        [_imgV2 setImage:[UIImage imageNamed:@"图片占位"]];
//
//        //图片3
//        _label3.text = @"无名称";
//        [_imgV3 setImage:[UIImage imageNamed:@"图片占位"]];
//    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _imgV1.layer.cornerRadius = 12;
    _imgV1.layer.masksToBounds = YES;
//    _backView.layer.shadowColor = LightGrayColor.CGColor;//shadowColor阴影颜色
//    _backView.layer.shadowOffset = CGSizeMake(1,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    _backView.layer.shadowRadius = 2;
//    _backView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
