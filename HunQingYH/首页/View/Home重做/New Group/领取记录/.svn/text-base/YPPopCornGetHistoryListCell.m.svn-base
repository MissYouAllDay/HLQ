//
//  YPPopCornGetHistoryListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/3/29.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPPopCornGetHistoryListCell.h"

@implementation YPPopCornGetHistoryListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPPopCornGetHistoryListCell";
    YPPopCornGetHistoryListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPPopCornGetHistoryListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setListModel:(YPGetPopcornReceiveTableList *)listModel{
    _listModel = listModel;
    
    if ([_listModel.Glass integerValue] == 1) {//1 小桶、2 大桶
        self.sizeType.text = @"小桶爆米花";
    }else if ([_listModel.Glass integerValue] == 2) {
        self.sizeType.text = @"大桶爆米花";
    }
    self.timeLabel.text = _listModel.CreateTime;
    self.addressLabel.text = _listModel.ShopAdress;
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    
    _backView.layer.cornerRadius = 5;
    _backView.layer.masksToBounds = NO;
    
    _backView.layer.shadowColor = LightGrayColor.CGColor;//shadowColor阴影颜色
    _backView.layer.shadowOffset = CGSizeMake(1,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _backView.layer.shadowRadius = 2;
    _backView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
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
