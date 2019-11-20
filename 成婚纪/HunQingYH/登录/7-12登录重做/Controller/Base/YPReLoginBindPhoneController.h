//
//  YPReLoginBindPhoneController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/7/16.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPReLoginBindPhoneController : UIViewController

/**微信Id*/
@property (nonatomic, copy) NSString *openId;
/**手机号*/
@property (nonatomic, copy) NSString *phone;
/**身份*/
@property (nonatomic, copy) NSString *identity;
/**手机验证码*/
@property (nonatomic, copy) NSString *phoneCode;
/**18-08-10 添加 微信Access_token*/
@property (nonatomic, copy) NSString *tokenCode;

@end
