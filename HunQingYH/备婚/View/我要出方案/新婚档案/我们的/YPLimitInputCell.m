//
//  YPLimitInputCell.m
//  HunQingYH
//
//  Created by Else丶 on 2017/12/4.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPLimitInputCell.h"
#import "YJJTextField.h"

@implementation YPLimitInputCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPLimitInputCell";
    YPLimitInputCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPLimitInputCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

//- (void)setBackView:(YJJTextField *)backView{
//    _backView = backView;
//
//    if (!_backView) {
//        _backView = [YJJTextField yjj_textField];
//    }
//    _backView.layer.cornerRadius = 3;
//    _backView.clipsToBounds = YES;
//    _backView.backgroundColor = CHJ_bgColor;
//    _backView.frame = CGRectMake(0, 0, CGRectGetWidth(backView.frame), CGRectGetHeight(backView.frame));
//    _backView.maxLength = _maxNum;
//    _backView.errorStr = [NSString stringWithFormat:@"字数长度不得超过%zd位",_maxNum];
//    _backView.placeholder = @"";
//    _backView.showHistoryList = NO;
//    [self.contentView addSubview:_backView];
//}

//- (YJJTextField *)backView{
//    if (!_backView) {
//        _backView = [YJJTextField yjj_textField];
//    }
//    _backView.layer.cornerRadius = 3;
//    _backView.clipsToBounds = YES;
//    _backView.backgroundColor = CHJ_bgColor;
////    _backView.maxLength = _maxNum;
////    _backView.errorStr = [NSString stringWithFormat:@"字数长度不得超过%zd位",_maxNum];
//    _backView.placeholder = @"";
//    _backView.showHistoryList = NO;
//    [self.contentView addSubview:_backView];
//    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.top.mas_equalTo(self.iconImgV.mas_bottom).mas_offset(15);
//        make.right.mas_equalTo(-15);
//        make.bottom.mas_equalTo(-10);
//    }];
//    
//    return _backView;
//}

//- (void)setMaxNum:(NSInteger)maxNum{
//    _maxNum = maxNum;

//    _limitNum.text = [NSString stringWithFormat:@"%ld/%ld", (long)_inputTF.text.length, (long)_maxNum];
    
//    self.inputTF = [YJJTextField yjj_textField];
//    self.inputTF.frame = CGRectMake(0, 0, CGRectGetWidth(_backView.frame), CGRectGetHeight(_backView.frame));
//    self.backView.maxLength = _maxNum;
//    self.backView.errorStr = [NSString stringWithFormat:@"字数长度不得超过%zd位",_maxNum];
//    self.inputTF.placeholder = @"";
//    self.inputTF.showHistoryList = NO;
//    self.inputTF.backgroundColor = CHJ_bgColor;
//    [_backView addSubview:self.inputTF];
//
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
