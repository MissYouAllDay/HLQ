//
//  YPGetUserShoppingRecordCommodityData.h
//  HunQingYH
//
//  Created by Else丶 on 2018/9/19.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPGetUserShoppingRecordCommodityData : NSObject

/**类别Id*/
@property (nonatomic, copy) NSString *CategoryId;
/**类别名称*/
@property (nonatomic, copy) NSString *CategoryName;
/**商品id*/
@property (nonatomic, copy) NSString *CommodityId;
/**商品名称*/
@property (nonatomic, copy) NSString *CommodityName;
/**型号id*/
@property (nonatomic, copy) NSString *SpecificationModelId;
/**型号名称*/
@property (nonatomic, copy) NSString *SpecificationModelIdName;
/**数量*/
@property (nonatomic, copy) NSString *Count;
/**额度*/
@property (nonatomic, copy) NSString *Quate;
/**图片Id*/
@property (nonatomic, copy) NSString *CoverMap;

@end

NS_ASSUME_NONNULL_END
