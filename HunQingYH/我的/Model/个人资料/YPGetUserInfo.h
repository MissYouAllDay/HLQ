//
//  YPGetUserInfo.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/11.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetUserInfo : NSObject

/**用户ID*/
@property (nonatomic, copy)                                                                                                                                                                              NSString *UserId;
/**姓名*/
@property (nonatomic, copy) NSString *Name;
/**头像*/
@property (nonatomic, copy) NSString *Headportrait;
/**职业*/
@property (nonatomic, copy) NSString *Profession;
/**手机号*/
@property (nonatomic, copy) NSString *Phone;
/**服务商Id*/
@property (nonatomic, copy) NSString *FacilitatorId;
/**地址*/
@property (nonatomic, copy) NSString *Address;
/**简介*/
@property (nonatomic, copy) NSString *Abstract;
/**供应商身份--手机端用不到*/
@property (nonatomic, copy) NSString *Identity;
/**省市区Id*/
@property (nonatomic, copy) NSString *region;
/**省市区名称*/
@property (nonatomic, copy) NSString *regionname;

///9.12 添加
/**是否加入车队 0未加入、1已加入*/
@property (nonatomic, copy) NSString *IsMotorcade;
/**是否有邀请消息 0没有、1有*/
@property (nonatomic, copy) NSString *IsNews;
/**队长ID*/
@property (nonatomic, copy) NSString *CaptainID;
/**车型ID*/
@property (nonatomic, copy) NSString *ModelID;

///5-29 添加
/**关注数量*/
@property (nonatomic, assign) NSInteger FollowNumber;
/**粉丝数量*/
@property (nonatomic, assign) NSInteger FansNumber;

/**状态 0未审核、1审核通过、2审核驳回*/
@property (nonatomic, copy) NSString *StatusType;

///18-08-16 添加
/**微信原始昵称*/
@property (nonatomic, copy) NSString *WeChatName;
/**是否绑定微信
 0未绑定，1已绑定*/
@property (nonatomic, copy) NSString *WeChatType;

//18-11-02
/**婚期*/
@property (nonatomic, copy) NSString *Wedding;

@end
