//
//  CXCompanyReviceLogCell.h
//  HunQingYH
//
//  Created by apple on 2019/10/12.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetFacilitatorFlowRecord.h"
NS_ASSUME_NONNULL_BEGIN

@interface CXCompanyReviceLogCell : UITableViewCell

@property (nonatomic, strong) YPGetFacilitatorFlowRecord *model;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *canbiao;
@property (weak, nonatomic) IBOutlet UILabel *payMoney;

/** 是否是sectionHeader */
@property (nonatomic, assign) BOOL isHeader;

- (void)setSectionHeaderValue;



@end

NS_ASSUME_NONNULL_END
