//
//  NewsDetailsAPI.h
//  HunQingYH
//
//  Created by Hiro on 2018/4/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NewsDetailsModel.h"
@interface NewsDetailsAPI : NSObject

/**
 加载数据
 
 @param newsId 资讯Id
 @param resultBlock 结果回调Block
 */
- (void)loadDataWithNewsId:(NSString *)newsId ResultBlock:(void (^)(NewsDetailsModel *model))resultBlock;

@end
