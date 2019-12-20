//
//  YPReLoginResetPWDController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/7/13.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPReLoginResetPWDController : UIViewController

/**手机号*/
@property (nonatomic, copy) NSString *Phone;
/**手机验证码*/
@property (nonatomic, copy) NSString *PhoneCode;

/**进入方式: 1:修改密码 2:添加账号 3:添加账号中重置密码*/
@property (nonatomic, copy) NSString *inType;

@end
