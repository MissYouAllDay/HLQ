//
//  YPGetDemoPlanList.h
//  HunQingYH
//
//  Created by Else丶 on 2017/12/14.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetDemoPlanList : NSObject

/**标题*/
@property (nonatomic, copy) NSString *PlanTitle;
/**关键字*/
@property (nonatomic, copy) NSString *PlanKeyWord;
/**展示图*/
@property (nonatomic, copy) NSString *ShowImg;
/**内容*/
@property (nonatomic, copy) NSString *PlanContent;
/**色系*/
@property (nonatomic, copy) NSString *Color;
/**详情图片
 逗号分隔*/
@property (nonatomic, copy) NSString *Imgs;
/**方案ID*/
@property(nonatomic,copy)NSString  *PlanID;
@end
