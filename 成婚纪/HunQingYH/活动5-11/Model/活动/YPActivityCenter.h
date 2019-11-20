//
//  YPActivityCenter.h
//  HunQingYH
//
//  Created by Else丶 on 2018/8/14.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPActivityCenter : NSObject

/**图片地址*/
@property (nonatomic, copy) NSString *Imgurl;
/**活动编码*/
@property (nonatomic, copy) NSString *ActivityCenterCode;
/**活动标题*/
@property (nonatomic, copy) NSString *ActivityCenterTitle;
/**跳转链接*/
@property (nonatomic, copy) NSString *JumpUrl;

@end
