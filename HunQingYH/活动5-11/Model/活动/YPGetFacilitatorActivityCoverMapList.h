//
//  YPGetFacilitatorActivityCoverMapList.h
//  HunQingYH
//
//  Created by Else丶 on 2018/8/29.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPGetFacilitatorActivityCoverMapListData.h"

@interface YPGetFacilitatorActivityCoverMapList : NSObject

/**记录Id*/
@property (nonatomic, copy) NSString *Id;
/**服务商id*/
@property (nonatomic, copy) NSString *FacilitatorId;
/**服务商名称*/
@property (nonatomic, copy) NSString *FacilitatorName;
/**封面图*/
@property (nonatomic, copy) NSString *CoverMap;
/**Data*/
@property (nonatomic, strong) NSArray<YPGetFacilitatorActivityCoverMapListData *> *Data;

//18-11-08
/**头像*/
@property (nonatomic, copy) NSString *HeadImg;

@end
