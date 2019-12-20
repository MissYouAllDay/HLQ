//
//  YPGetTeamInfoList.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/12.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetTeamInfoList : NSObject

/**关联ID*/
@property (nonatomic, copy) NSString *RelaID;
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
/**申请方式 1队长发起的邀请、2队员发起的申请*/
@property (nonatomic, copy) NSString *Type;
/**审核状态 1未审核、2审核通过、3审核驳回*/
@property (nonatomic, copy) NSString *ExamineStatus;
/**驳回理由*/
@property (nonatomic, copy) NSString *RejectedWhy;

@end
