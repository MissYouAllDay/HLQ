//
//  YPOurNewWedsHotelInfoCell.h
//  HunQingYH
//
//  Created by Else丶 on 2017/12/12.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPOurNewWedsHotelInfoCell : UITableViewCell

@property (nonatomic, strong) NSArray *imgArr;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UILabel *hotelName;
@property (weak, nonatomic) IBOutlet UILabel *hotelAddress;
@property (weak, nonatomic) IBOutlet UILabel *hotelTableCount;
@property (weak, nonatomic) IBOutlet UILabel *tingName;
@property (weak, nonatomic) IBOutlet UILabel *tingSize;
@property (weak, nonatomic) IBOutlet UIView  *moreImgsView;
@property (weak, nonatomic) IBOutlet UIView *backView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
