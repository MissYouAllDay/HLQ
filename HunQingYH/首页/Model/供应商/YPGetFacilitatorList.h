//
//  YPGetFacilitatorList.h
//  HunQingYH
//
//  Created by Else丶 on 2018/8/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetFacilitatorList : NSObject

/**服务商Id*/
@property (nonatomic, copy) NSString *Id;
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

///18-08-10 添加
/**用户id*/
@property (nonatomic, copy) NSString *UserId;
/**酒店活动标识*/
@property (nonatomic, copy) NSString *Tag;
/**服务商身份*/
@property (nonatomic, copy) NSString *SupplierIdentity;

///18-10-26 添加
/**婚礼担保
 0未参加,1已参加*/
@property (nonatomic, copy) NSString *Hldb;
/**消费有礼
 0未参加,1已参加*/
@property (nonatomic, copy) NSString *Xfyl;

///18-09-12
/**StartImgData*/
@property (nonatomic, strong) NSArray *StartImgData;
/**EndImgListData*/
@property (nonatomic, strong) NSArray *EndImgListData;
@end
