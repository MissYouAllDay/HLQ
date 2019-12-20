//
//  YPGetFacilitatorActivityList.h
//  HunQingYH
//
//  Created by Else丶 on 2018/8/30.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetFacilitatorActivityList : NSObject

/**记录id*/
@property (nonatomic, copy) NSString *Id;
/**服务商id*/
@property (nonatomic, copy) NSString *FacilitatorId;
/**封面图*/
@property (nonatomic, copy) NSString *CoverMap;
/**详情*/
@property (nonatomic, copy) NSString *Details;
/**创建时间*/
@property (nonatomic, copy) NSString *Createtime;

//18-11-07 分享
/**分享标题*/
@property (nonatomic, copy) NSString *ShareTitle;
/**分享描述*/
@property (nonatomic, copy) NSString *ShareDescribe;

@end
