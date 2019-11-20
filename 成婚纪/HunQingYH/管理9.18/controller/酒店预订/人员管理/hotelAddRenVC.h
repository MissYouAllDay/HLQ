//
//  hotelAddRenVC.h
//  HunQingYH
//
//  Created by Hiro on 2019/6/27.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface hotelAddRenVC : UIViewController
/**1添加 其他编辑*/
@property(nonatomic,assign)NSInteger  formIndex;
/**<#注释#>*/
@property(nonatomic,copy)NSString  *ID;
/***/
@property(nonatomic,copy)NSString  *nameStr;
/**<#注释#>*/
@property(nonatomic,copy)NSString  *phoneStr;
/**<#注释#>*/
@property(nonatomic,copy)NSString  *shenfenStr;
@end

NS_ASSUME_NONNULL_END
