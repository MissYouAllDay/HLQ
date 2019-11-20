//
//  YPGetCustomerInfoList.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/20.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetCustomerInfoList : NSObject

/**客户信息ID*/
@property (nonatomic, copy) NSString *CustomerInfoID;
/**婚庆公司ID*/
@property (nonatomic, copy) NSString *CorpID;
/**婚庆公司名称*/
@property (nonatomic, copy) NSString *CorpName;
/**婚庆公司Logo*/
@property (nonatomic, copy) NSString *Logo;
/**婚庆公司地址*/
@property (nonatomic, copy) NSString *Address;

@end
