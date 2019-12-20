//
//  YPGetPlanList.h
//  hunqing
//
//  Created by YanpengLee on 2017/7/14.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetPlanList : NSObject

/**方案ID*/
@property (nonatomic, copy) NSString *PlanID;
/**发布人ID*/
@property (nonatomic, copy) NSString *EmployeeID;
/**公司ID*/
@property (nonatomic, copy) NSString *CorpID;
/**发布人姓名*/
@property (nonatomic, copy) NSString *EmployeeName;
/**发布公司名称*/
@property (nonatomic, copy) NSString *CorpName;
/**标题*/
@property (nonatomic, copy) NSString *PlanTitle;
/**关键字*/
@property (nonatomic, copy) NSString *PlanKeyWord;
/**展示图*/
@property (nonatomic, copy) NSString *ShowImg;
/**内容*/
@property (nonatomic, copy) NSString *PlanContent;
/**积分*/
@property (nonatomic, copy) NSString *PlanIntegral;
/**色系*/
@property (nonatomic, copy) NSString *Color;
/**状态 0未审核、1审核通过、2审核失败*/
@property (nonatomic, copy) NSString *Status;
/**方案类型 1本店专用、2共享方案*/
@property (nonatomic, copy) NSString *PlanType;
/**是否已购买 0未购买、1已购买*/
@property (nonatomic, copy) NSString *IsBuy;
/**是否下线 0未下线、1已下线*/
@property (nonatomic, copy) NSString *IsOffline;

///7.14 添加
/**附件说明 字符之间用逗号分隔*/
@property (nonatomic, copy) NSString *AttState;
///7.17 添加
/**创建时间*/
@property (nonatomic, copy) NSString *CreateTime;

@end
