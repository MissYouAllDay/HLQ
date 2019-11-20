//
//  YPGetConsigneeInfoList.h
//  HunQingYH
//
//  Created by Else丶 on 2018/5/2.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetConsigneeInfoList : NSObject

/**记录Id*/
@property (nonatomic, copy) NSString *Id;
/**地区*/
@property (nonatomic, copy) NSString *Area;
/**详细地址*/
@property (nonatomic, copy) NSString *DetailedAddress;
/**收货人*/
@property (nonatomic, copy) NSString *Consignee;
/**收货人手机号*/
@property (nonatomic, copy) NSString *ConsigneePhone;
/**邮编*/
@property (nonatomic, copy) NSString *PostCode;

///5-2 添加
/**默认地址
 0，否；1，是*/
@property (nonatomic, assign) NSInteger DefaultAddress;
///5-2 添加
/**地区Id*/
@property (nonatomic, copy) NSString *AreaId;

@end
