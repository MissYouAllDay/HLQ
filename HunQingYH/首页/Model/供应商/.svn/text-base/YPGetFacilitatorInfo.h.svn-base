//
//  YPGetFacilitatorInfo.h
//  HunQingYH
//
//  Created by Else丶 on 2018/8/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPGetFacilitatorInfoImgData.h"

@interface YPGetFacilitatorInfo : NSObject

/**服务商Id*/
@property (nonatomic, copy) NSString *Id;
/**用户id*/
@property (nonatomic, copy) NSString *UserId;
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

///18-08-11 添加
/**身份*/
@property (nonatomic, copy) NSString *Identity;
/**省市区Id*/
@property (nonatomic, copy) NSString *region;
/**省市区名称*/
@property (nonatomic, copy) NSString *regionname;
///**酒店ID--暂未添加*/
//@property (nonatomic, copy) NSString *RummeryID;

///18-08-18 添加
/**酒店端文字
 固定”首单送2580元新人礼”*/
@property (nonatomic, copy) NSString *Tag;

///18-08-30 添加
///**封面图
// 逗号分隔*/
//@property (nonatomic, copy) NSString *CoverMap;

///18-10-26 添加
/**婚礼担保
 0未参加,1已参加*/
@property (nonatomic, copy) NSString *Hldb;
/**消费有礼
 0未参加,1已参加*/
@property (nonatomic, copy) NSString *Xfyl;

///18-11-16
/**餐标*/
@property (nonatomic, copy) NSString *MealMark;
/**服务费*/
@property (nonatomic, copy) NSString *ServiceCharge;

///18-11-19
/**基础优惠总条数*/
@property (nonatomic, copy) NSString *BasicPreferencesCount;
/**Data*/
@property (nonatomic, strong) NSArray<YPGetFacilitatorInfoImgData *> *Data;

@end
