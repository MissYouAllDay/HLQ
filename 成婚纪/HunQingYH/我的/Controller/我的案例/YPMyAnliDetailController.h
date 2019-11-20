//
//  YPMyAnliDetailController.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/2.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPMyAnliDetailController : UIViewController

/**供应商ID*/
@property(nonatomic,copy)NSString *SupplierID;
/**案例ID*/
@property(nonatomic,copy)NSString  *CaseID;
/**是否车手查询我的车队进入*/
@property (nonatomic, copy) NSString *IsCheShouMyTeam;

@end
