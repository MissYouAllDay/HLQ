//
//  CXSelectGoodSpectionVC.h
//  HunQingYH
//
//  Created by apple on 2019/9/29.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - - - - - 选择商品规格 - - - - - - - - - - - - - - - - - -


#import <UIKit/UIKit.h>
#import "YPGetCommodityTypeTableListData.h"
#import "YPGetFacilitatorFlowRecord.h"
NS_ASSUME_NONNULL_BEGIN

@interface CXSelectGoodSpectionVC : UIViewController
@property (nonatomic, strong) NSArray *dataArr;
/** <#name#> */
@property (nonatomic, copy) NSString *name;

/** <#name#> */
@property (nonatomic, copy) NSString *packageId;
@property (nonatomic, strong) YPGetFacilitatorFlowRecord *flowRecord;


@end

NS_ASSUME_NONNULL_END
