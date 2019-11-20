//
//  YPFADetailController.h
//  hunqing
//
//  Created by YanpengLee on 2017/7/10.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetDemoPlanList.h"
#import "YPGetWebPlanList.h"

@interface YPFADetailController : UIViewController



@property (nonatomic, copy) NSString *planID;//方案ID
@property (nonatomic, assign) BOOL isCollected;//是否已收藏
@end
