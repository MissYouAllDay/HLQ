//
//  YPGetCustomerInfoBySupplier.h
//  HunQingYH
//
//  Created by Else丶 on 2018/3/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetCustomerInfoBySupplier : NSObject

/**客户id*/
@property (nonatomic, copy) NSString *Customerid;
/**新娘姓名*/
@property (nonatomic, copy) NSString *BrideName;
/**新娘手机号*/
@property (nonatomic, copy) NSString *BridePhoneNo;
/**新郎姓名*/
@property (nonatomic, copy) NSString *GroomName;
/**新郎手机号*/
@property (nonatomic, copy) NSString *GroomPhoneNo;

@end
