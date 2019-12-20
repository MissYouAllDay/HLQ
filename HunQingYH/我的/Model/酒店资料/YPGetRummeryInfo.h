//
//  YPGetRummeryInfo.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/11.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetRummeryInfo : NSObject

/**酒店ID*/
@property (nonatomic, copy) NSString *RummeryID;
/**简称*/
@property (nonatomic, copy) NSString *Abbreviation;
/**公司名称*/
@property (nonatomic, copy) NSString *RummeryName;
/**酒店Logo*/
@property (nonatomic, copy) NSString *HotelLogo;
/**酒店图片*/
@property (nonatomic, copy) NSString *HotelImgs;
/**联系人姓名*/
@property (nonatomic, copy) NSString *ContactName;
/**联系人电话*/
@property (nonatomic, copy) NSString *ContactPhone;
/**地址*/
@property (nonatomic, copy) NSString *Address;
/**最低价位*/
@property (nonatomic, copy) NSString *LowestPrice;
/**审核状态 0未审核、1审核通过、2审核失败*/
@property (nonatomic, copy) NSString *IsStatus;

///9.11 添加
/**简介*/
@property (nonatomic, copy) NSString *BriefinTroduction;
/**地区ID*/
@property (nonatomic, copy) NSString *Region;

///6-5 添加
/**地区名称*/
@property (nonatomic, copy) NSString *RegionName;

@end
