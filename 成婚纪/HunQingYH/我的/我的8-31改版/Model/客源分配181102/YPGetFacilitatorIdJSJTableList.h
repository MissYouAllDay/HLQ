//
//  YPGetFacilitatorIdJSJTableList.h
//  HunQingYH
//
//  Created by Else丶 on 2018/11/2.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPGetFacilitatorIdJSJTableList : NSObject

/**身份*/
@property (nonatomic, copy) NSString *Identity;
/**姓名*/
@property (nonatomic, copy) NSString *Name;
/**手机号*/
@property (nonatomic, copy) NSString *Phone;
/**婚期*/
@property (nonatomic, copy) NSString *WeddingTime;
/**备注*/
@property (nonatomic, copy) NSString *Meno;
/**时间*/
@property (nonatomic, copy) NSString *Time;
/**地区*/
@property (nonatomic, copy) NSString *Area;
/**客源来源
 0官方,1个人*/
@property (nonatomic, copy) NSString *Source;
/**身份id*/
@property (nonatomic, copy) NSString *IdentityId;
/**记录id*/
@property (nonatomic, copy) NSString *Id;

/**客源状态
 0待处理,1有意向,2已合作,3已拒单*/
@property (nonatomic, copy) NSString *TouristType;
/**桌数*/
@property (nonatomic, copy) NSString *TablesNumber;
/**餐标*/
@property (nonatomic, copy) NSString *MealMark;

@end

NS_ASSUME_NONNULL_END
