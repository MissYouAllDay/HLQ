//
//  YPGetWeddingPackageVideoCaseList.h
//  HunQingYH
//
//  Created by Else丶 on 2018/6/13.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetWeddingPackageVideoCaseList : NSObject

/**案例Id*/
@property (nonatomic, copy) NSString *Id;
/**套餐Id*/
@property (nonatomic, copy) NSString *SchemeId;
/**视频*/
@property (nonatomic, copy) NSString *VideoId;
/**封面图*/
@property (nonatomic, copy) NSString *CoverMap;

@end
