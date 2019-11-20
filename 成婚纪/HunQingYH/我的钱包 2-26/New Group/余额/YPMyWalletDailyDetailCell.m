//
//  YPMyWalletDailyDetailCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyWalletDailyDetailCell.h"

@implementation YPMyWalletDailyDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyWalletDailyDetailCell";
    YPMyWalletDailyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyWalletDailyDetailCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setApModel:(YPGetAPList *)apModel{
    _apModel = apModel;
    if ([_apModel.AccountType integerValue] == 1) {//1:支付宝 2:银行卡
        self.tagImgV.image = [UIImage imageNamed:@"支付宝"];
    }else if ([_apModel.AccountType integerValue] == 2){
        self.tagImgV.image = [UIImage imageNamed:@"支付宝"];
    }
    self.price.text = [NSString stringWithFormat:@"%.2f元",[_apModel.Money floatValue]];
    if ([_apModel.State integerValue] == 0) {//0待审核 1通过 2驳回
        self.stateLabel.text = @"待审核";
    }else if ([_apModel.State integerValue] == 1) {//0待审核 1通过 2驳回
        self.stateLabel.text = @"通过";
        self.stateLabel.textColor = [UIColor greenColor];
    }else if ([_apModel.State integerValue] == 2) {//0待审核 1通过 2驳回
        self.stateLabel.text = @"驳回";
        self.stateLabel.textColor = [UIColor redColor];
    }
    if (_apModel.AccountCode.length == 11) {
        NSString *str = [_apModel.AccountCode stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.account.text = [NSString stringWithFormat:@"(%@)",str];
    }else{
        self.account.text = [NSString stringWithFormat:@"(%@)",_apModel.AccountCode];
    }
    self.timeLabel.text = _apModel.CreateTime;
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
