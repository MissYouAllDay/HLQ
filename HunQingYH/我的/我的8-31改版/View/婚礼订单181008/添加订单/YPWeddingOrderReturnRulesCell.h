//
//  YPWeddingOrderReturnRulesCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/10/26.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMReport.h"
#import "YPGetIntervalAmountParamList.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPWeddingOrderReturnRulesCell : UITableViewCell

@property (nonatomic, strong) NSArray<YPGetIntervalAmountParamList *> *ruleMarr;

@property (strong, nonatomic) LMReportView *listView;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
