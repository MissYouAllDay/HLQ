//
//  YPGetShoppingOrderList.h
//  HunQingYH
//
//  Created by Else丶 on 2018/4/28.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetShoppingOrderList : NSObject

/**购物车Id*/
@property (nonatomic, copy) NSString *ShoppingCartId;
/**类别Id*/
@property (nonatomic, copy) NSString *TypeId;
/**商品Id*/
@property (nonatomic, copy) NSString *CommodityId;
/**型号ID*/
@property (nonatomic, copy) NSString *PlaceOriginId;
/**商品名称*/
@property (nonatomic, copy) NSString *CommodityName;
/**产地*/
@property (nonatomic, copy) NSString *PlaceOrigin;
/**类别名称*/
@property (nonatomic, copy) NSString *CategoryGoodsName;
/**型号名称*/
@property (nonatomic, copy) NSString *PlaceOriginName;
/**数量*/
@property (nonatomic, copy) NSString *Count;
/**额度(单价)*/
@property (nonatomic, copy) NSString *Quota;
/**封面图*/
@property (nonatomic, copy) NSString *BriefIntroduction;

//18-08-11
/**收货人姓名*/
@property (nonatomic, copy) NSString *Consignee;
/**收货人电话*/
@property (nonatomic, copy) NSString *ConsigneePhone;
/**收货人地址*/
@property (nonatomic, copy) NSString *Address;

@end
