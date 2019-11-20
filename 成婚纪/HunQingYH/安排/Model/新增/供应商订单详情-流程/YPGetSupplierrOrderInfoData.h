//
//  YPGetSupplierrOrderInfoData.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/20.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetSupplierrOrderInfoData : NSObject

/**流程ID*/
@property (nonatomic, copy) NSString *WeddingProcessID;
/**开始时间*/
@property (nonatomic, copy) NSString *BeginTime;
/**结束时间*/
@property (nonatomic, copy) NSString *EndTime;
/**内容*/
@property (nonatomic, copy) NSString *Content;

@end
