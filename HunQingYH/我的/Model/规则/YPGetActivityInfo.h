//
//  YPGetActivityInfo.h
//  hunqing
//
//  Created by Else丶 on 2017/11/18.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetActivityInfo : NSObject

/**邀请人数*/
@property (nonatomic, copy) NSString *InvitedNumber;
/**活动id*/
@property (nonatomic, copy) NSString *ActivityID;
/**活动标题*/
@property (nonatomic, copy) NSString *Title;
/**活动内容*/
@property (nonatomic, copy) NSString *Content;
/**活动开始时间*/
@property (nonatomic, copy) NSString *StartTime;
/**活动结束时间*/
@property (nonatomic, copy) NSString *EndTime;
/**详细规则
 以数组形式返回*/
@property (nonatomic, strong) NSArray *Rule;
/**档次列
 以数组形式返回*/
@property (nonatomic, strong) NSArray *Grade;
/**创建时间*/
@property (nonatomic, copy) NSString *CreateTime;
/**相关对象类型
 0公司、1供应商（用户）*/
@property (nonatomic, copy) NSString *ObjectTypes;


/**邀请备婚人数*/
@property(nonatomic,assign)NSInteger  WeddingNumber;
/**签单人数*/
@property(nonatomic,assign)NSInteger SignatureNumber ;
/**邀请码*/
@property(nonatomic,copy)NSString  *YQCode;



@end
