//
//  YPGetHotelBanquetlInfo.h
//  HunQingYH
//
//  Created by Else丶 on 2018/8/14.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPGetFacilitatorInfoImgData.h"

@interface YPGetHotelBanquetlInfo : NSObject

/**宴会厅id*/
@property (nonatomic, copy) NSString *BanquetID;
/**宴会厅名称*/
@property (nonatomic, copy) NSString *BanquetHallName;
/**最低价格*/
@property (nonatomic, copy) NSString *FloorPrice;
/**桌数*/
@property (nonatomic, copy) NSString *MaxTableCount;
/**酒店logo*/
@property (nonatomic, copy) NSString *HotelLogo;
///**详情图*/
//@property (nonatomic, copy) NSString *TypeQuestion;
/**服务商id*/
@property (nonatomic, copy) NSString *FacilitatorId;

///18-11-19
/**Data*/
@property (nonatomic, strong) NSArray<YPGetFacilitatorInfoImgData *> *Data;
/**最小桌数*/
@property (nonatomic, copy) NSString *MinTableCount;
/**面积*/
@property (nonatomic, copy) NSString *Acreage;
/**长度*/
@property (nonatomic, copy) NSString *Length;
/**宽度*/
@property (nonatomic, copy) NSString *Width;
/**层高*/
@property (nonatomic, copy) NSString *Height;
/**封面图*/
@property (nonatomic, copy) NSString *TypeContent;
/**酒店名称*/
@property (nonatomic, copy) NSString *HotelName;

@end
