//
//  CXShowDidSelectGoodsVC.h
//  HunQingYH
//
//  Created by apple on 2019/9/29.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - - - - - 此步骤为提供用户核对使用 - - - - - - - - - - - - - - - - - - 

#pragma mark - - - - - - - - - - - - - - - 展示已经选择的规格 - - - - - - - - - - - - - - - - -

#import <UIKit/UIKit.h>
#import "YPGetCommodityTypeTableListData.h"
#import "YPGetFacilitatorFlowRecord.h"
NS_ASSUME_NONNULL_BEGIN

@interface CXShowDidSelectGoodsVC : UIViewController

@property (nonatomic, strong) NSArray *dataArr;

/** 套餐id */
@property (nonatomic, copy) NSString *packageId;
@property (nonatomic, strong) YPGetFacilitatorFlowRecord *flowRecord;
@end


@interface CXShowDidSelectGoodsCell : UITableViewCell

@property (nonatomic, strong) YPGetCommodityTypeTableListData *model;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *specLab;
@property (nonatomic, strong) UIImageView *icon;



@end
NS_ASSUME_NONNULL_END
