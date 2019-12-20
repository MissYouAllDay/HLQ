//
//  YPReLoginSupplierIdentityController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/7/31.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetAllOccupationList_New.h"

//typedef void(^SelectIdentityBlock)(YPGetAllOccupationList_New *listModel);

@interface YPReLoginSupplierIdentityController : UIViewController

//@property (nonatomic, copy) SelectIdentityBlock doneBtnBlock;

/**标识 绑定手机号/微信注册:1 手机号验证码注册注册:2*/
@property (nonatomic, copy) NSString *identityType;

/************微信注册**************/
/**微信Id*/
@property (nonatomic, copy) NSString *wxopenId;
/**手机号*/
@property (nonatomic, copy) NSString *wxphone;
/**手机验证码 -- 手机号验证码注册/微信注册 -> 通用*/
@property (nonatomic, copy) NSString *wxphoneCode;
/**18-08-10 添加 微信Access_token*/
@property (nonatomic, copy) NSString *tokenCode;
/************微信注册**************/

///18-11-05 地区
@property (nonatomic, copy) NSString *areaID;

@end
