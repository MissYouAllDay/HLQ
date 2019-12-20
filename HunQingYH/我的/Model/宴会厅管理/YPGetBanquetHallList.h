//
//  YPGetBanquetHallList.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/8.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetBanquetHallList : NSObject

/**厅ID*/
@property (nonatomic, copy) NSString *BanquetID;
/**厅名称*/
@property (nonatomic, copy) NSString *BanquetHallName;
/**桌数*/
@property (nonatomic, copy) NSString *MaxTableCount;
/**封面图*/
@property (nonatomic, copy) NSString *HotelLogo;
///**最低价位*/
//@property (nonatomic, copy) NSString *FloorPrice;
///**宴会厅图片-- 18-08-14 修改*/
//@property(nonatomic,copy)NSString  *Imgs;

///18-11-19
/**面积*/
@property (nonatomic, copy) NSString *Acreage;
/**高度*/
@property (nonatomic, copy) NSString *Height;

@end
