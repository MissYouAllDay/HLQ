//
//  YPDriverTotalScheduleModel.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/25.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPGetDriverScheduleList.h"

@interface YPDriverTotalScheduleModel : NSObject

/**婚期*/
@property (nonatomic, copy) NSString *WeddingDate;
/**Data*/
@property (nonatomic, strong) NSArray<YPGetDriverScheduleList *> *Data;

@end
