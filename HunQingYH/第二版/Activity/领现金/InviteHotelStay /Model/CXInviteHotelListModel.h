//
//  CXInviteHotelListModel.h
//  HunQingYH
//
//  Created by canxue on 2019/12/25.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - 邀请酒店记录 model- - - - - - - - - - - - - - - - - - - - - -

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXInviteHotelListModel : NSObject

@property (nonatomic, copy) NSString *Id;                   // Id
@property (nonatomic, copy) NSString *SubmittingID;         // 提交者id
@property (nonatomic, copy) NSString *FacilitatorName;      // 酒店名称
@property (nonatomic, copy) NSString *AreaId;               // 地区id
@property (nonatomic, copy) NSString *Address;              // 详细地址
@property (nonatomic, copy) NSString *MealMark;             // 平均餐标
@property (nonatomic, copy) NSString *BanquetHall;          // 酒店宴会厅
@property (nonatomic, copy) NSString *InviterName;          // 邀请人姓名
@property (nonatomic, copy) NSString *InviterPhone;         // 邀请人手机号
@property (nonatomic, copy) NSString *CreateTime ;    // 创建时间

@property (nonatomic, copy) NSString *Result;    // 0、未签约 1已签约


@end

NS_ASSUME_NONNULL_END
