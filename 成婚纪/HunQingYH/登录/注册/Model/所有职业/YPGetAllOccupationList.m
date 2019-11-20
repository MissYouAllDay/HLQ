//
//  YPGetAllOccupationList.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/1.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPGetAllOccupationList.h"

@implementation YPGetAllOccupationList

+ (NSString *)nameWithCode:(NSString *)code{
//    //酒店
//#define JiuDian(string)     [(string) isEqualToString:@"SF_1001000"]
//    //婚车
//#define HunChe(string)      [(string) isEqualToString:@"SF_2001000"]
//    //主持人
//#define ZhuChi(string)      [(string) isEqualToString:@"SF_3001000"]
//    //摄像师
//#define SheXiang(string)    [(string) isEqualToString:@"SF_4001000"]
//    //摄影师
//#define SheYing(string)     [(string) isEqualToString:@"SF_5001000"]
//    //化妆师
//#define HuaZhuang(string)   [(string) isEqualToString:@"SF_6001000"]
//    //演艺
//#define YanYi(string)       [(string) isEqualToString:@"SF_7001000"]
//    //婚纱
//#define HunSha(string)      [(string) isEqualToString:@"SF_8001000"]
//    //督导师
//#define DuDao(string)       [(string) isEqualToString:@"SF_9001000"]
//    //花艺师
//#define HuaYi(string)       [(string) isEqualToString:@"SF_10001000"]
//    //灯光师
//#define DongGuang(string)   [(string) isEqualToString:@"SF_11001000"]
//    //用户
//#define YongHu(string)      [(string) isEqualToString:@"SF_12001000"]
//    //车手
//#define CheShou(string)     [(string) isEqualToString:@"SF_13001000"]
//    //婚庆
//#define HunQing(string)     [(string) isEqualToString:@"SF_14001000"]
  
    return [CXDataManager checkUserProfession:code];
}

@end
