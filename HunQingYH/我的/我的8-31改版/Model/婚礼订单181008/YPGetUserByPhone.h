//
//  YPGetUserByPhone.h
//  HunQingYH
//
//  Created by Else丶 on 2018/10/26.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPGetUserByPhone : NSObject

/**用户id*/
@property (nonatomic, copy) NSString *UserId;
/**姓名*/
@property (nonatomic, copy) NSString *NickName;
/**手机号*/
@property (nonatomic, copy) NSString *Phone;

@end

NS_ASSUME_NONNULL_END
