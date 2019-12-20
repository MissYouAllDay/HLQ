//
//  CXReceiveUserCell.h
//  HunQingYH
//
//  Created by apple on 2019/9/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetFacilitatorFlowRecord.h"
NS_ASSUME_NONNULL_BEGIN

@interface CXReceiveUserCell : UITableViewCell

@property (nonatomic, strong) YPGetFacilitatorFlowRecord *model;

@property (weak, nonatomic) IBOutlet UILabel *payMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *relogBtn;
@property (weak, nonatomic) IBOutlet UIButton *reBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end

NS_ASSUME_NONNULL_END
