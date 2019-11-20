//
//  YPGetUserQuotas.h
//  HunQingYH
//
//  Created by Else丶 on 2018/4/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetUserQuotas : NSObject

/**额度*/
@property (nonatomic, assign) NSInteger Quota;
/**是否已使用
 0未使用,1已使用 18-09-17 去掉*/
//@property (nonatomic, assign) NSInteger IsUse;
/**活动规则*/
@property (nonatomic, copy) NSString *RulesActivity;
/**图片地址*/
@property (nonatomic, copy) NSString *HeadImg;
/**购物车商品数量*/
@property(nonatomic,assign)NSInteger  CarCount;
@end
