//
//  YPGetCommodityTypeTableListData.h
//  HunQingYH
//
//  Created by Else丶 on 2018/4/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXSpecificationsModel.h"   // 规格
@interface YPGetCommodityTypeTableListData : NSObject

/**商品Id*/
@property (nonatomic, copy) NSString *CommodityId;
/**商品名称*/
@property (nonatomic, copy) NSString *CommodityName;
/**产地*/
@property (nonatomic, copy) NSString *PlaceOrigin;
/**额度*/
@property (nonatomic, copy) NSString *Quota;
/**封面图*/
@property (nonatomic, copy) NSString *CoverMap;

///18-08-30
/**商品展示图*/
@property (nonatomic, copy) NSString *ShowImage;
/** 轮播图 */
@property (nonatomic, copy) NSString *CarouselFigure;
@property (nonatomic, strong) NSArray *CarouselFigureArr;

/** 标题 */
@property (nonatomic, copy) NSString *Title;
/** 名称 */
@property (nonatomic, copy) NSString *Name;
// 规格
@property (nonatomic, strong) NSArray<CXSpecificationsModel *> *Data;

/** 所选择的规格 */
@property (nonatomic, copy) NSString *Model;
/** 商品名称 */
@property (nonatomic, copy) NSString *Commodity;
#pragma mark - - - - - - - - - - - - - - - 自定义字段 - - - - - - - - - - - - - - - - -
/** cell的高度。 尽在cxSelectGoodSpectionVC中使用 */
@property (nonatomic, assign) CGFloat  hei;
// 所选择的规格
@property (nonatomic, copy) NSString  *selectSpe;

@end
