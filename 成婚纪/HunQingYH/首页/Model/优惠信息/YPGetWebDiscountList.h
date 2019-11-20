//
//  YPGetWebDiscountList.h
//  HunQingYH
//
//  Created by Else丶 on 2018/1/8.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetWebDiscountList : NSObject

/**图片*/
@property (nonatomic, copy) NSString *ImgUrl;
/**优惠信息id*/
@property (nonatomic, copy) NSString *DiscountID;
/**跳转地址*/
@property (nonatomic, copy) NSString *DiscountURL;

@end
