//
//  YPImgTitleInputTWCell.m
//  HunQingYH
//
//  Created by Else丶 on 2017/11/30.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPImgTitleInputTWCell.h"
#import "BATextView.h"

@implementation YPImgTitleInputTWCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPImgTitleInputTWCell";
    YPImgTitleInputTWCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPImgTitleInputTWCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = CHJ_bgColor;
    return cell;
    
}

- (void)setInputTW:(UITextView *)inputTW{
    _inputTW = inputTW;
    
    _inputTW.layer.cornerRadius = 5;
    _inputTW.clipsToBounds = YES;
    
    _inputTW.userInteractionEnabled = YES;
    /**
     文字字体，注意：一定要用 ba_textFont 设置，用系统的 self.font 设置无效
     */
    _inputTW.ba_textFont = [UIFont systemFontOfSize:17];
    /**
     文字颜色，注意：一定要用 ba_textColor 设置，用系统的 self.textColor 设置无效
     */
    _inputTW.ba_textColor = [UIColor blackColor];
    
    _inputTW.backgroundColor = WhiteColor;
//    // 自定义 placeholder
//    _inputTW.ba_placeholder = @"这里是 placeholder ！";
//    // 自定义 placeholder 颜色
//    _inputTW.ba_placeholderColor = [UIColor orangeColor];
//    // 自定义 placeholder 字体
//    _inputTW.ba_placeholderFont = [UIFont systemFontOfSize:17];
    
    // 设置代理
    [_inputTW ba_textViewWithDelegate:_inputTW];
    
    /**
     快速设定最大字数限制返回当前字数
     
     @param limitNumber 最大字数限制
     @param block BAKit_TextView_WordDidChangedBlock
     */
    [_inputTW ba_textView_wordLimitWithMaxWordLimitNumber:200 block:^(NSString *current_text) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.limitLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)current_text.length, (long)_inputTW.ba_maxWordLimitNumber];
            [self.contentView setNeedsLayout];
        });
    }];
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
