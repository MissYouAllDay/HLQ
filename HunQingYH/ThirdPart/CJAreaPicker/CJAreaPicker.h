//
//  CJAreaPicker.h
//  CJAreaPicker
//
//  Created by 曹 景成 on 14-1-22.
//  Copyright (c) 2014年 JasonCao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	@brief	地区类型
 */
typedef enum {
    CJPlaceTypeState = 0, /**< 省份类型 */
    CJPlaceTypeCity = 1,  /**< 市类型 */
    CJPlaceTypeArea = 2   /**< 区类型 */
}CJPlaceType;

/**
 *    @ 最终选择城市节点
 */
typedef enum {
    CJPlaceEndState = 2,   /**只能选择省份 */
    CJPlaceEndCity = 1,    /** 只能选择 省份 -> 市  */
    CJPlaceEndArea = 0     /**< 只能选择 省份 -> 市 -> 县/区 */
}CJPaceSelectType;

@class CJAreaPicker;

/**
 *	@brief	地区选择器协议
 */
@protocol CJAreaPickerDelegate <NSObject>

@optional

/**
 *	@brief	当地区选择器选中地区后
 *
 *	@param 	picker 	    选择器
 *  @param  address     选中的地址
 */
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID;
/**
 *    @brief   选择取消
 */
-(void)areaPicker:(CJAreaPicker *)picker didClickCancleWithAddress:(NSString *)address parentID:(NSInteger)parentID;


/// 当地区选择器选中地区后
/// @param picker 选择器
/// @param address 选中的地址
/// @param fullAddress 完整路径
/// @param parentID parentID
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address withFullAddress:(NSString *)fullAddress parentID:(NSInteger)parentID;

@end

/**
 *	@brief	地区选择器，基类为UITableViewController。数据从are.plist里取,到末级有选择提示。
 */

@interface CJAreaPicker : UITableViewController

/**
 *	@brief	地区类型(省/市/区)
 */
@property (nonatomic) CJPlaceType type;
/**
 *    @brief    选择终结类型
 */
@property (nonatomic) CJPaceSelectType endType;
/**
 *	@brief	Model放(省/市/区)数组
 */
@property (nonatomic, strong) NSMutableArray *places;
@property(nonatomic,strong)NSMutableArray *provinceArray;
@property(nonatomic,strong)NSMutableArray *cityesArray;
@property(nonatomic,strong)NSMutableArray *areaArray;
/**
 *	@brief	当前已经选择的地区信息
 */
@property (nonatomic, strong) NSString *placeName;
/**
 *	@brief	当前用户所在的地区
 */
@property (nonatomic, strong) NSString *userlocation;
/**
 *	@brief	当前用户所在的地区所属地区
 */
@property (nonatomic, strong) NSString *userlocation_parent;
/**
 *	@brief	地区选择器协议委托
 */
@property (nonatomic, unsafe_unretained) IBOutlet id<CJAreaPickerDelegate>delegate;


/**
 *	@brief	当前已经选择的地区parentID
 */
@property (nonatomic, assign) int  parentID;


/**
 *    @brief    当前已经选择的地区parentID
 */
@property (nonatomic, assign) int  parentID_regionID;


@property (nonatomic, copy) NSString *addressInfoDetail;    // 地址信息。使用 空格分割 等级


@end
