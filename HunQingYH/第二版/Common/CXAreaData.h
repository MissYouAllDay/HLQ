//
//  CXAreaData.h
//  HunQingYH
//
//  Created by canxue on 2019/12/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - 地址选择器 相关 - - - - - - - - - - - - - - - - - - - - - -
// - - - - - - - - - - - -  后期将地址选择器替换为本文件方法- - - - - - - - - - - - - - - - - - - - - -
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXAreaData : NSObject

/// 迁移数据库
+ (void)moveToDBFile;

/// 根据城市名称+上级id 获取城市id
/// @param cityInfo 城市名称
/// @param parentId 上级id
+ (NSString *)selectDataBaseWithCityInfo:(NSString *)cityInfo withParentId:(int)parentId;


/// 订婚宴、客源管理 使用此方法。查询数据库
/// @param cityInfo 区域名称
+ (NSString *)selectDataBaseWithCityInfo:(NSString *)cityInfo;


/// 查询某市级所管辖的县/区
/// @param parentID 某市级的id
+ (NSArray *)searchCityListWithParentId:(NSInteger )parentID;
    

@end

NS_ASSUME_NONNULL_END
