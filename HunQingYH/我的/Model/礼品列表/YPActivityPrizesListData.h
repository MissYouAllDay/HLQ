//
//  YPActivityPrizesListData.h
//  HunQingYH
//
//  Created by Else丶 on 2017/11/19.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPActivityPrizesListData : NSObject

/**活动奖品ID*/
@property (nonatomic, copy) NSString *ActivityPrizesID;
/**商品名称*/
@property (nonatomic, copy) NSString *CommodityName;
/**展示图*/
@property (nonatomic, copy) NSString *ShowImg;
/**国家*/
@property (nonatomic, copy) NSString *Country;
/**创建时间*/
@property (nonatomic, copy) NSString *CreateTime;

///11-19 添加
/**价格*/
@property (nonatomic, copy) NSString *MarketPrice;
/**档次*/
@property(nonatomic,copy)NSString  *Grade;
@end
