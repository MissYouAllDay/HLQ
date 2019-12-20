//
//  HRLickPeopleCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/15.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRLickPeopleCell.h"

@implementation HRLickPeopleCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRLickPeopleCell";
    HRLickPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRLickPeopleCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
//
    _imge1.layer.masksToBounds =YES;
    _imge1.layer.cornerRadius =_imge1.height/2;

    
    
    _imge2.layer.masksToBounds =YES;
    _imge2.layer.cornerRadius = _imge2.height/2;
    _image3.layer.masksToBounds =YES;
    _image3.layer.cornerRadius =_image3.height/2;
    _image4.layer.masksToBounds =YES;
    _image4.layer.cornerRadius =_image4.height/2;
    _image5.layer.masksToBounds =YES;
   _image5.layer.cornerRadius = _image5.height/2;
    _iamge6.layer.masksToBounds =YES;
    _iamge6.layer.cornerRadius =_iamge6.height/2;
    _iamge7.layer.masksToBounds =YES;
    _iamge7.layer.cornerRadius =_iamge7.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
