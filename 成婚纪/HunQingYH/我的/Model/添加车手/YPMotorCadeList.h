//
//  YPMotorCadeList.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/13.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPMotorCadeList : NSObject

/**车手用户ID*/
@property (nonatomic, copy) NSString *UserID;
/**头像*/
@property (nonatomic, copy) NSString *Headportrait;
/**车手名*/
@property (nonatomic, copy) NSString *TrueName;
/**车型*/
@property (nonatomic, copy) NSString *Parent;
/**手机号*/
@property (nonatomic, copy) NSString *Phone;

@end
