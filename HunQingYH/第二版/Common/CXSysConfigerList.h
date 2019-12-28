//
//  CXSysConfigerList.h
//  HunQingYH
//
//  Created by canxue on 2019/12/25.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#ifndef CXSysConfigerList_h
#define CXSysConfigerList_h

// - - - - - - - - - - - - - - 系统配置 - - - - - - - - - - - - - - - - - - - - - -

// 客服电话
#define kefuTel @"15192055999"

// 微信
#define Interface_WeChatPay @"http://121.42.156.151:82/example/WeChatAppPayback.aspx"//@"http://localhost:57823/example/WeChatAppPayback.aspx"//


#pragma mark - - - - - - - - - - - - - - 数据保存- - - - - - - - - - - - - - - - - - - - - -

///保存位置经纬度信息
#define mylat [[NSUserDefaults standardUserDefaults]objectForKey:@"latitude"]
#define mylong [[NSUserDefaults standardUserDefaults]objectForKey:@"longitude"]

///是否登录
#define UserIsLogin [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"]

///供应商标题名称 职业为非用户和车手时
#define supplierName [[NSUserDefaults standardUserDefaults] objectForKey:@"Name"]
///车型ID 职业为车手
#define modelID [[NSUserDefaults standardUserDefaults] objectForKey:@"ModelID"]
///酒店ID 职业为酒店
#define myRummeryID [[NSUserDefaults standardUserDefaults] objectForKey:@"RummeryID"]

///能否被搜索到 职业为非用户和车手时
#define isSearch [[NSUserDefaults standardUserDefaults] objectForKey:@"IsSearch"]
///权限编码列表
#define supplierCreateTime [[NSUserDefaults standardUserDefaults] objectForKey:@"SuppLierCreateTime"]


//版本号
#define Version [[NSUserDefaults standardUserDefaults] objectForKey:@"Version"]
//收款码
#define SKCode [[NSUserDefaults standardUserDefaults] objectForKey:@"SKCode"]

#pragma mark - - - - - - - - - - - - - - 用户信息保存- - - - - - - - - - - - - - - - - - - - - -
///用户Id
#define UserId_New [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId_New"]
///用户昵称
#define UserName_New [[NSUserDefaults standardUserDefaults] objectForKey:@"Name_New"]
///头像
#define Headportrait_New [[NSUserDefaults standardUserDefaults] objectForKey:@"Headportrait_New"]
///身份
#define Profession_New [[NSUserDefaults standardUserDefaults] objectForKey:@"Profession_New"]
/** 职业名称  */
#define Profession_Name_New [[NSUserDefaults standardUserDefaults] objectForKey:@"Profession_Name_New"]

///手机号
#define UserPhone_New [[NSUserDefaults standardUserDefaults] objectForKey:@"Phone_New"]
///服务商Id
#define FacilitatorId_New [[NSUserDefaults standardUserDefaults] objectForKey:@"FacilitatorId_New"]
///地区ID
#define areaID_New [[NSUserDefaults standardUserDefaults] objectForKey:@"region_New"]
///地区
#define regionname_New [[NSUserDefaults standardUserDefaults] objectForKey:@"regionname_New"]
///18-08-16 添加
///微信原始昵称
#define WeChatName_New [[NSUserDefaults standardUserDefaults] objectForKey:@"WeChatName_New"]
///是否绑定微信 0未绑定，1已绑定
#define WeChatType_New [[NSUserDefaults standardUserDefaults] objectForKey:@"WeChatType_New"]
///18-11-02 婚期
#define Wedding_New [[NSUserDefaults standardUserDefaults] objectForKey:@"Wedding_New"]

//18-11-13 切换账号 第二账号存储
///当前账号-密码
#define Password_New [[NSUserDefaults standardUserDefaults] objectForKey:@"Password_New"]
///第二账号-用户昵称
#define UserName_Second [[NSUserDefaults standardUserDefaults] objectForKey:@"Name_Second"]
///第二账号-头像
#define Headportrait_Second [[NSUserDefaults standardUserDefaults] objectForKey:@"Headportrait_Second"]
///第二账号-手机号
#define UserPhone_Second [[NSUserDefaults standardUserDefaults] objectForKey:@"Phone_Second"]
///第二账号-密码
#define Password_Second [[NSUserDefaults standardUserDefaults] objectForKey:@"Password_Second"]

#pragma mark----------------------- 身份编码 ------------------------------------

//酒店
#define JiuDian(string)     [(string) isEqualToString:@"99C06C5A-DDB8-46A1-B860-CD1227B4DB68"]||[(string)isEqualToString:@"99c06c5a-ddb8-46a1-b860-cd1227b4db68"]
//婚车
#define HunChe(string)      [(string) isEqualToString:@"2526D327-B0AE-4D88-922E-1F7A91722422"]||[(string) isEqualToString:@"2526d327-b0ae-4d88-922e-1f7a91722422"]
//主持人
#define ZhuChi(string)      [(string) isEqualToString:@"0D2E7D67-57EA-4566-B2FE-2972DDE00306"]||[(string) isEqualToString:@"0d2e7d67-57ea-4566-b2fe-2972dde00306"]
//摄像师
#define SheXiang(string)    [(string) isEqualToString:@"41A3BF32-BBB1-4957-9914-50E17E96795B"]||[(string) isEqualToString:@"41a3bf32-bbb1-4957-9914-50e17e96795b"]
//摄影师
#define SheYing(string)     [(string) isEqualToString:@"5C1D8DA0-9BB6-4CA0-8801-6EA3E187884F"]||[(string) isEqualToString:@"5c1d8da0-9bb6-4ca0-8801-6ea3e187884f"]
//化妆师
#define HuaZhuang(string)   [(string) isEqualToString:@"9A86A0AB-C13B-4A6D-AB97-1D123AF7C69E"]||[(string) isEqualToString:@"9a86a0ab-c13b-4a6d-ab97-1d123af7c69e"]
//演艺
#define YanYi(string)       [(string) isEqualToString:@"F7CC4F9E-A518-47D8-BFF7-4FB9F033CDA8"]||[(string) isEqualToString:@"f7cc4f9e-a518-47d8-bff7-4fb9f033cda8"]
//婚纱
#define HunSha(string)      [(string) isEqualToString:@"ADF7BAAC-AD51-4605-99EE-C59A40BD165D"]||[(string) isEqualToString:@"adf7baac-ad51-4605-99ee-c59a40bd165d"]
//督导师
#define DuDao(string)       [(string) isEqualToString:@"72FE3832-CA92-44CF-9B73-28576E77FA3E"]||[(string) isEqualToString:@"72fe3832-ca92-44cf-9b73-28576e77fa3e"]
//花艺师
#define HuaYi(string)       [(string) isEqualToString:@"76E2FC81-ADF4-4F3A-8805-499C4D634F23"]||[(string) isEqualToString:@"76e2fc81-adf4-4f3a-8805-499c4d634f23"]
//灯光师
#define DongGuang(string)   [(string) isEqualToString:@"3CBD4B30-87BF-48C3-98E6-7C210A7F4EFB"]||[(string) isEqualToString:@"3cbd4b30-87bf-48c3-98e6-7c210a7f4efb"]
//用户
#define YongHu(string)      [(string) isEqualToString:@"70CD854E-D943-4607-B993-91912329C61E"]||[(string) isEqualToString:@"70cd854e-d943-4607-b993-91912329c61e"]

//车手
#define CheShou(string)     [(string) isEqualToString:@"F209497C-2F2E-4394-AF20-312ED665F67A"]||[(string) isEqualToString:@"f209497c-2f2e-4394-af20-312ed665f67a"]
//婚庆
#define HunQing(string)     [(string) isEqualToString:@"7DC8EDF8-A068-400F-AFD0-417B19DB3C7C"]||[(string) isEqualToString:@"7dc8edf8-a068-400f-afd0-417b19db3c7c"]
//大屏幕 新加
#define DaPingMu(string)     [(string) isEqualToString:@"CCE67F8C-66CF-4979-92FA-D751190583E6"]||[(string) isEqualToString:@"cce67f8f-66cf-4979-92fa-d751190583e6"]

//员工 身份显示婚庆
#define YuanGong(string)     [(string) isEqualToString:@"9FFDE235-61BF-408B-8C35-AE76D9113169"]||[(string) isEqualToString:@"9ffde235-61bf-408b-8c35-ae76d9113169"]


#pragma mark - - - - - - - - - - - - - - 别名设置- - - - - - - - - - - - - - - - - - - - - -
// 2018-07-30 身份代码
#define HuaZhuang_New @"9A86A0AB-C13B-4A6D-AB97-1D123AF7C69E"    //化妆师
#define HunChe_New    @"2526D327-B0AE-4D88-922E-1F7A91722422"    //婚车
#define DuDao_New     @"72FE3832-CA92-44CF-9B73-28576E77FA3E"    //督导师
#define ZhuChi_New    @"0D2E7D67-57EA-4566-B2FE-2972DDE00306"    //主持人
#define CheShou_New   @"F209497C-2F2E-4394-AF20-312ED665F67A"    //车手
#define HunQing_New   @"7DC8EDF8-A068-400F-AFD0-417B19DB3C7C"    //婚庆
#define HuaYi_New     @"76E2FC81-ADF4-4F3A-8805-499C4D634F23"    //花艺师
#define YanYi_New     @"F7CC4F9E-A518-47D8-BFF7-4FB9F033CDA8"    //演艺
#define SheXiang_New  @"41A3BF32-BBB1-4957-9914-50E17E96795B"    //摄像师
#define SheYing_New   @"5C1D8DA0-9BB6-4CA0-8801-6EA3E187884F"    //摄影师
#define DongGuang_New @"3CBD4B30-87BF-48C3-98E6-7C210A7F4EFB"    //灯光师
#define YongHu_New    @"70CD854E-D943-4607-B993-91912329C61E"    //用户
#define YuanGong_New  @"9FFDE235-61BF-408B-8C35-AE76D9113169"    //员工
#define HunSha_New    @"ADF7BAAC-AD51-4605-99EE-C59A40BD165D"    //婚纱
#define JiuDian_New   @"99C06C5A-DDB8-46A1-B860-CD1227B4DB68"    //酒店
#define DaPingMu_New  @"CCE67F8C-66CF-4979-92FA-D751190583E6"    //大屏幕

#endif /* CXSysConfigerList_h */
