//
//  YPGetCarModel.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/23.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetCarModel : NSObject

/**品牌id*/
@property (nonatomic, copy) NSString *BrandID;
/**品牌名称*/
@property (nonatomic, copy) NSString *BrandName;
/**车型名称*/
@property (nonatomic, copy) NSString *Name;
/**车型ID*/
@property (nonatomic, copy) NSString *ID;
/**图片*/
@property (nonatomic, copy) NSString *CarImg;
/**颜色*/
@property (nonatomic, copy) NSString *Color;

@end
