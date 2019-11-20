//
//  YPTotalScheduleModel.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/14.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPGetScheduleList.h"

@interface YPTotalScheduleModel : NSObject

/**档期时间*/
@property (nonatomic, copy) NSString *ScheduleTime;
@property (nonatomic, strong) NSArray<YPGetScheduleList *> *Data;

@end
