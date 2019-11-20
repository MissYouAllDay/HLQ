//
//  YPGetActivityHotelList.h
//  HunQingYH
//
//  Created by Else丶 on 2018/10/26.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPGetActivityHotelList : NSObject

/**服务商Id*/
@property (nonatomic, copy) NSString *FacilitatorId;
/**用户id*/
@property (nonatomic, copy) NSString *UserId;
/**活动酒店id*/
@property (nonatomic, copy) NSString *ActivityHotelId;
/**名称*/
@property (nonatomic, copy) NSString *Name;
/**Logo*/
@property (nonatomic, copy) NSString *Logo;
/**电话*/
@property (nonatomic, copy) NSString *Phone;
/**地址*/
@property (nonatomic, copy) NSString *Address;
/**简介*/
@property (nonatomic, copy) NSString *Abstract;
/**案例数量*/
@property (nonatomic, copy) NSString *AnliCount;
/**状态数量*/
@property (nonatomic, copy) NSString *StateCount;
/**描述*/
@property (nonatomic, copy) NSString *Describe;
/**消费有礼
 0无礼 1有礼
*/
@property (nonatomic, copy) NSString *Xfyl;
/**婚礼担保
 0无担保 1有担保
*/
@property (nonatomic, copy) NSString *Hldb;
/**创建时间*/
@property (nonatomic, copy) NSString *CreateTime;

@end

NS_ASSUME_NONNULL_END
