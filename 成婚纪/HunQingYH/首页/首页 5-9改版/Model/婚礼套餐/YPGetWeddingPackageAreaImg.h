//
//  YPGetWeddingPackageAreaImg.h
//  HunQingYH
//
//  Created by Else丶 on 2018/6/13.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPGetWeddingPackageAreaImgData.h"

@interface YPGetWeddingPackageAreaImg : NSObject

/**区域Id*/
@property (nonatomic, copy) NSString *AreaId;
/**地区名称*/
@property (nonatomic, copy) NSString *AreaName;
/**图片数组*/
@property (nonatomic, strong) NSArray<YPGetWeddingPackageAreaImgData *> *ImageData;

@end
