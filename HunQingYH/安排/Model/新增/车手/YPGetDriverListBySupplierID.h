//
//  YPGetDriverListBySupplierID.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/20.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetDriverListBySupplierID : NSObject

/**是否选中*/
@property (nonatomic, assign) NSInteger IsSelected;

/**车手ID*/
@property (nonatomic, copy) NSString *DriverID;
/**车手姓名*/
@property (nonatomic, copy) NSString *DriverName;
/**车手手机号*/
@property (nonatomic, copy) NSString *DriverPhone;
/**车手头像*/
@property (nonatomic, copy) NSString *DriverImg;

@end
