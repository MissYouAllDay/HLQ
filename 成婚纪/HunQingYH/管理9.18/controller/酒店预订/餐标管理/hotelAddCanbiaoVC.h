//
//  hotelAddCanbiaoVC.h
//  HunQingYH
//
//  Created by Hiro on 2019/6/27.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface hotelAddCanbiaoVC : UIViewController
/***/
@property(nonatomic,copy)NSString  *tingID;

/**餐标id*/
@property(nonatomic,copy)NSString  *Id;

/**<#注释#>*/

@property(nonatomic,copy) NSString *tingName;

/**<#注释#>*/
@property(nonatomic,copy)NSString *price;
/**菜品*/
@property(nonatomic,copy)NSString  *Menu;
@end

NS_ASSUME_NONNULL_END
