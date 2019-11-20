//
//  YPReHomeNewsHeaderCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/1/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnClickBlock)(UIButton *sender);

@interface YPReHomeNewsHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

//@property (nonatomic, strong) BtnClickBlock btn1ClickBlock;
//@property (nonatomic, strong) BtnClickBlock btn2ClickBlock;
//@property (nonatomic, strong) BtnClickBlock btn3ClickBlock;

//- (void)yp_btn1Click:(BtnClickBlock)btnClickBlock;
//- (void)yp_btn2Click:(BtnClickBlock)btnClickBlock;
//- (void)yp_btn3Click:(BtnClickBlock)btnClickBlock;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
