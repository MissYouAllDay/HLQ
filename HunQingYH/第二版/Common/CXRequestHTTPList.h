//
//  RequestHTTPList.h
//  HunQingYH
//
//  Created by apple on 2019/10/24.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - 数据请求- - - - - - - - - - - - - - - - - - - - - -

#ifndef RequestHTTPList_h
#define RequestHTTPList_h


// - - - - - - - - - - - - - - 基础- - - - - - - - - - - - - - - - - - - - - -
#pragma mark - 接口基础路径

#define Base_URL @"http://121.42.156.151:52373"  //正式


// - - - - - - - - - - - - - - 免费领- - - - - - - - - - - - - - - - - - - - - -

// 获取分类
#define URL_ACTIVITY_CategoryList     @"/api/HQOAApi/GetCouponCategoryList"

// 获取分类中的列表
#define URL_ACTIVITY_CouponList     @"/api/HQOAApi/GetCouponList"

// 获取优惠券详情（礼品详情）
#define URL_ACTIVITY_GetCouponInfo     @"/api/HQOAApi/GetCouponInfo"

//- - - - - - -  领现金 - - - - - - -
// 申请合伙人
#define URL_ACTIVITY_APPLYPARTNER               @"/api/HQOAApi/ApplyPartner"

// 申请结果查询
#define URL_ACTIVITY_APPLYPARTNER_RESULT        @"/api/HQOAApi/GetApplyPartnerList"

// 酒店入驻提交列表
#define URL_ACTIVITY_InvitehotelStay           @"/api/HQOAApi/AddHotelAccommodation"

// 获取酒店入驻记录
#define URL_ACTIVITY_InviteHotelList    @"/api/HQOAApi/GetHotelAccommodation"

// 立返商家列表
#define URL_ACTIVITY_BackMoneyShopList     @"/api/HQOAApi/GetCashbackFacilitatorList"



#endif /* RequestHTTPList_h */
