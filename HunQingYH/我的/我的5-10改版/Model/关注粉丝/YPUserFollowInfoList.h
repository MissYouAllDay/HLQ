//
//  YPUserFollowInfoList.h
//  HunQingYH
//
//  Created by Else丶 on 2018/5/29.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPUserFollowInfoList : NSObject

/**关注用户Id/粉丝Id*/
@property (nonatomic, copy) NSString *UserId;
/**关注用户名称/粉丝名称*/
@property (nonatomic, copy) NSString *Name;
///**供应商简介*/
//@property (nonatomic, copy) NSString *BriefinTroduction;

///5-29 添加
/**头像*/
@property (nonatomic, copy) NSString *Headportrait;
/**身份*/
@property (nonatomic, copy) NSString *Profession;

///6-1 添加
/**供应商Id*/
@property (nonatomic, copy) NSString *FollowSupplierId;

@end
