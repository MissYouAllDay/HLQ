//
//  HRYQJLCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/2/7.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRYQJLCell.h"

@implementation HRYQJLCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRYQJLCell";
    HRYQJLCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRYQJLCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
-(void)setModel:(HRInvitePeopleModel *)model{
    _model =model;
//    if ([model.GroomName isEqualToString:@""]) {
//         self.xinlangName.text =@"未添加姓名";
//    }else{
//         self.xinlangName.text =model.GroomName;
//    }
//    if ([model.BrideName isEqualToString:@""]) {
//        self.xinniangName.text =@"未添加姓名";
//    }else{
//        self.xinniangName.text =model.BrideName;
//    }
//    if ([model.GroomPhone isEqualToString:@""]) {
//        self.xinlangPhone.text =@"未添加电话";
//    }else{
//          self.xinlangPhone.text = model.GroomPhone;
//    }
//    if ([model.BridePhone isEqualToString:@""]) {
//        self.xinniangPhone.text =@"未添加电话";
//    }else{
//
//        self.xinniangPhone.text =model.BridePhone;
//    }
  
    if (model.GroomName.length > 0) {
        self.xinlangName.text = model.GroomName;
        self.shenfen.text = @" - 新郎";
    }else if (model.BrideName.length > 0){
        self.xinlangName.text = model.BrideName;
        self.shenfen.text = @" - 新娘";
    }else if (model.GroomPhone.length > 0){
        self.xinlangPhone.text = model.GroomPhone;
    }else if (model.BridePhone.length > 0){
        self.xinlangPhone.text = model.BridePhone;
    }

    
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
