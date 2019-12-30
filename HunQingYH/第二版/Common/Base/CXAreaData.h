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

@property (nonatomic, copy) NSString *cityId;    // 城市id
@property (nonatomic, copy) NSString *cityName;    // 当前的城市名称
@property (nonatomic, strong) NSArray  *citysArr;    // 市下方的x区、县集合

+ (id)shareAreaData;

+ (void)defaSetting;

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
/// 第一条数据为“全部区域“ 不使用的话可以在外部去掉
/// @param parentID 某市级的id
+ (NSArray *)searchCityListWithParentId:(NSInteger )parentID;
    

@end

NS_ASSUME_NONNULL_END
