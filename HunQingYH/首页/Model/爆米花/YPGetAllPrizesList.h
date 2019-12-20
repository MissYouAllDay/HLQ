//
//  YPGetAllPrizesList.h
//  HunQingYH
//
//  Created by Else丶 on 2018/4/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetAllPrizesList : NSObject

/**奖品Id*/
@property (nonatomic, copy) NSString *PrizeId;
/**奖品名称*/
@property (nonatomic, copy) NSString *PrizeName;
/**奖品图片地址*/
@property (nonatomic, copy) NSString *Imgurl;

@end
