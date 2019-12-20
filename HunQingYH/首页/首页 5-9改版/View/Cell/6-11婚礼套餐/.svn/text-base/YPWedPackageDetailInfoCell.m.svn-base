//
//  YPWedPackageDetailInfoCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/11.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPWedPackageDetailInfoCell.h"

@implementation YPWedPackageDetailInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPWedPackageDetailInfoCell";
    YPWedPackageDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPWedPackageDetailInfoCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setInfoModel:(YPGetWeddingPackageInfo *)infoModel{
    _infoModel = infoModel;
    
    if (_infoModel.Name.length > 0) {
        self.titleLabel.text = _infoModel.Name;
    }else{
        self.titleLabel.text = @"无名称";
    }
    self.priceLabel.text = [NSString stringWithFormat:@"%zd",[_infoModel.PresentPrice integerValue]];
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_infoModel.OriginalPrice] attributes:attribtDic];
    // 赋值
    _oriPriceLabel.attributedText = attribtStr;

    NSArray *arr = [_infoModel.Label componentsSeparatedByString:@","];
    if (arr.count == 0) {
        self.tag1.hidden = YES;
        self.tag2.hidden = YES;
        self.tag3.hidden = YES;
        self.tag4.hidden = YES;
    }else if (arr.count == 1){
        self.tag1.hidden = NO;
        if ([arr[0] length] == 0) {
            self.tag1.text = @" 无标签 ";
        }else{
            self.tag1.text = [NSString stringWithFormat:@" %@ ",arr[0]];
        }
        self.tag2.hidden = YES;
        self.tag3.hidden = YES;
        self.tag4.hidden = YES;
    }else if (arr.count == 2){
        self.tag1.hidden = NO;
        self.tag1.text = [NSString stringWithFormat:@" %@ ",arr[0]];
        self.tag2.hidden = NO;
        self.tag2.text = [NSString stringWithFormat:@" %@ ",arr[1]];
        self.tag3.hidden = YES;
        self.tag4.hidden = YES;
    }else if (arr.count == 3){
        self.tag1.hidden = NO;
        self.tag1.text = [NSString stringWithFormat:@" %@ ",arr[0]];
        self.tag2.hidden = NO;
        self.tag2.text = [NSString stringWithFormat:@" %@ ",arr[1]];
        self.tag3.hidden = NO;
        self.tag3.text = [NSString stringWithFormat:@" %@ ",arr[2]];
        self.tag4.hidden = YES;
    }else if (arr.count == 4){
        self.tag1.hidden = NO;
        self.tag1.text = [NSString stringWithFormat:@" %@ ",arr[0]];
        self.tag2.hidden = NO;
        self.tag2.text = [NSString stringWithFormat:@" %@ ",arr[1]];
        self.tag3.hidden = NO;
        self.tag3.text = [NSString stringWithFormat:@" %@ ",arr[2]];
        self.tag4.hidden = NO;
        self.tag4.text = [NSString stringWithFormat:@" %@ ",arr[3]];
    }
}

//- (void)setOriPriceLabel:(UILabel *)oriPriceLabel{
//    _oriPriceLabel = oriPriceLabel;
//
//
//}

- (void)setTag1:(UILabel *)tag1{
    _tag1 = tag1;
    
    _tag1.layer.cornerRadius = 2;
    _tag1.clipsToBounds = YES;
    _tag1.layer.borderColor = LightGrayColor.CGColor;
    _tag1.layer.borderWidth = 1;
}

- (void)setTag2:(UILabel *)tag2{
    _tag2 = tag2;
    
    _tag2.layer.cornerRadius = 2;
    _tag2.clipsToBounds = YES;
    _tag2.layer.borderColor = LightGrayColor.CGColor;
    _tag2.layer.borderWidth = 1;
}

- (void)setTag3:(UILabel *)tag3{
    _tag3 = tag3;
    
    _tag3.layer.cornerRadius = 2;
    _tag3.clipsToBounds = YES;
    _tag3.layer.borderColor = LightGrayColor.CGColor;
    _tag3.layer.borderWidth = 1;
}

- (void)setTag4:(UILabel *)tag4{
    _tag4 = tag4;
    
    _tag4.layer.cornerRadius = 2;
    _tag4.clipsToBounds = YES;
    _tag4.layer.borderColor = LightGrayColor.CGColor;
    _tag4.layer.borderWidth = 1;
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
