//
//  YPHYTHDetailCanBiaoDateCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/18.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHDetailCanBiaoDateCell.h"
#import "UIImage+YPGradientImage.h"

@implementation YPHYTHDetailCanBiaoDateCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHDetailCanBiaoDateCell";
    YPHYTHDetailCanBiaoDateCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHDetailCanBiaoDateCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    _backView.layer.cornerRadius = 4;
    _backView.clipsToBounds = YES;
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = _backView.bounds;
//    gradient.startPoint = CGPointMake(0, 0.5);
//    gradient.endPoint = CGPointMake(1, 0.5);
//    gradient.colors = [NSArray arrayWithObjects:
//                       (id)[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0].CGColor,
//                       (id)[UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0].CGColor, nil];
////    [_backView.layer addSublayer:];
//    [_backView.layer insertSublayer:gradient atIndex:0];
}

- (void)setBackImgV:(UIImageView *)backImgV{
    _backImgV = backImgV;
    _backImgV.layer.cornerRadius = 4;
    _backImgV.clipsToBounds = YES;
    [_backImgV setImage:[UIImage gradientImageWithBounds:_backImgV.frame andColors:@[[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0],[UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0]] andGradientType:1]];
}

- (void)setDateBtn:(UIButton *)dateBtn{
    _dateBtn = dateBtn;
//    _dateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    _dateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
//    _dateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
}

- (void)setAllCanBiao:(UIButton *)allCanBiao{
    _allCanBiao = allCanBiao;
//    _allCanBiao.imageEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
//    _allCanBiao.titleEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.allCanBiao setTitle:@"查看全部 >" forState:UIControlStateNormal];
    [self.allCanBiao setTitleColor:[UIColor colorWithHexString:@"#FB3F6E"] forState:UIControlStateNormal];
    self.allCanBiao.titleLabel.font = kFont(13);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
