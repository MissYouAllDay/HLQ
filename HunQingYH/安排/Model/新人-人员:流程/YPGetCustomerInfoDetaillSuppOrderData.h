//
//  YPGetCustomerInfoDetaillSuppOrderData.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/20.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetCustomerInfoDetaillSuppOrderData : NSObject

/**供应商姓名*/
@property (nonatomic, copy) NSString *TrueName;
/**Logo*/
@property (nonatomic, copy) NSString *Logo;
/**供应商公司名 这个字段可能会出现空字符串*/
@property (nonatomic, copy) NSString *SuppCorpName;
/**手机号*/
@property (nonatomic, copy) NSString *Phone;
/**职业*/
@property (nonatomic, copy) NSString *Profession;
/**职业名称*/
@property (nonatomic, copy) NSString *ProfessionName;

@end
