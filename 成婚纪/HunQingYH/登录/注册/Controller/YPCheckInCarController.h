//
//  YPCheckInCarController.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/25.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPCheckInCarController : UIViewController

/**验证码ID*/
@property (nonatomic, copy) NSString *authCodeID;
/**手机号*/
@property (nonatomic, copy) NSString *phoneNo;
/**头像ID*/
@property (nonatomic, copy) NSString *iconID;
/**店铺名称*/
@property (nonatomic, copy) NSString *shopName;
/**经营范围*/
@property (nonatomic, copy) NSString *profession;
/**所在地区ID*/
@property (nonatomic, copy) NSString *addressID;

/**身份证正面*/
@property (nonatomic, copy) NSString *idCardFrontID;
/**身份证反面*/
@property (nonatomic, copy) NSString *idCardFanID;
/**手持身份证*/
@property (nonatomic, copy) NSString *handIDCardID;

/**驾照/营业执照*/
@property (nonatomic, copy) NSString *otherCardID;

@end
