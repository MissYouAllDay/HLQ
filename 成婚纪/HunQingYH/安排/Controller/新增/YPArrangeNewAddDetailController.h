//
//  YPArrangeNewAddDetailController.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/17.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPArrangeNewAddDetailController : UIViewController

/**订单ID*/
@property (nonatomic, copy) NSString *supplierOrderID;
/**公司ID*/
//@property (nonatomic, copy) NSString *corpID;
/**公司名称*/
@property (nonatomic, copy) NSString *corpName;
/**公司logo*/
@property (nonatomic, copy) NSString *corpLogo;
/**客户ID*/
//@property (nonatomic, copy) NSString *customerID;
/**公司联系人姓名,电话 逗号分隔 例 张三,1860001234 
 9.22 修改 只有电话
 */
@property (nonatomic, copy) NSString *corpPhone;

/**完成block*/
@property (nonatomic, copy) void (^doneBlock)(NSString *str);

@end
