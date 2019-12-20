//
//  NewsDetailsModel.h
//  HunQingYH
//
//  Created by Hiro on 2018/4/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYKit.h"
@interface NewsDetailsModel : NSObject<YYModel , NSCoding>
/**
 资讯Id
 */
@property (nonatomic , copy ) NSString *newsId;
/**
 资讯标题
 */
@property (nonatomic , copy ) NSString *newsTitle;

/**
 资讯Html
 */
@property (nonatomic , copy ) NSString *newsHtml;
#pragma mark - 缓存

+ (NewsDetailsModel *)cacheForNewsId:(NSString *)newsId;

+ (void)setCache:(NewsDetailsModel *)model forNewsId:(NSString *)newsId;

+ (void)cacheSizeWithBlock:(void (^)(NSInteger bytes))block;

+ (void)clearCacheForNewsId:(NSString *)newsId;

+ (void)clearAllCacheWithBlock:(void (^)())block;

@end
