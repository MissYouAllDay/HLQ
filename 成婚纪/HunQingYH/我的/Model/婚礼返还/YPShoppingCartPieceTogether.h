//
//  YPShoppingCartPieceTogether.h
//  HunQingYH
//
//  Created by Else丶 on 2018/8/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPShoppingCartPieceTogetherData.h"

@interface YPShoppingCartPieceTogether : NSObject

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

///18-08-09 添加
/**轮播图*/
@property (nonatomic, copy) NSString *CarouselFigure;
/**上下架状态*/
@property (nonatomic, copy) NSString *OffShelf;
/**简介图*/
@property (nonatomic, copy) NSString *BriefIntroduction;
/**Data*/
@property (nonatomic, strong) NSArray<YPShoppingCartPieceTogetherData *> *Data;

@end
