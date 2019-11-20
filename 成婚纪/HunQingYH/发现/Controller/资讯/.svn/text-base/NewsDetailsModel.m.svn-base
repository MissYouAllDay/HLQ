//
//  NewsDetailsModel.m
//  HunQingYH
//
//  Created by Hiro on 2018/4/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "NewsDetailsModel.h"
#import "YYKit.h"
#import <YYCache.h>
static NSString *const CacheKey = @"NewsDetailsCache";
@implementation NewsDetailsModel

- (void)encodeWithCoder:(NSCoder *)aCoder { [self modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self modelCopy]; }
- (NSUInteger)hash { return [self modelHash]; }
- (BOOL)isEqual:(id)object { return [self modelIsEqual:object]; }
- (NSString *)description { return [self modelDescription]; }

#pragma mark - 缓存

+ (NewsDetailsModel *)cacheForNewsId:(NSString *)newsId{
    
    if (!newsId) return nil;
    
    YYCache *cache = [YYCache cacheWithName:CacheKey];
    
    return (NewsDetailsModel *)[cache objectForKey:newsId];
}

+ (void)setCache:(NewsDetailsModel *)model forNewsId:(NSString *)newsId{
    
    if (!model && !newsId) return;
    
    YYCache *cache = [YYCache cacheWithName:CacheKey];
    
    [cache setObject:model forKey:model.newsId];
}

+ (void)cacheSizeWithBlock:(void (^)(NSInteger bytes))block{
    
    YYCache *cache = [YYCache cacheWithName:CacheKey];
    
    [cache.diskCache totalCostWithBlock:^(NSInteger totalCost) {
        
        if (block) block(totalCost);
    }];
}

+ (void)clearCacheForNewsId:(NSString *)newsId{
    
    YYCache *cache = [YYCache cacheWithName:CacheKey];
    
    [cache removeObjectForKey:newsId];
}

+ (void)clearAllCacheWithBlock:(void (^)())block{
    
    YYCache *cache = [YYCache cacheWithName:CacheKey];
    
    [cache removeAllObjectsWithBlock:block];
}

@end
