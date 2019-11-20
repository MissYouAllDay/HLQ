//
//  YPMyNewlywedsAddPersonInfoController.h
//  HunQingYH
//
//  Created by Else丶 on 2017/11/30.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetNewPeopleInfo.h"

@protocol YPMyNewlywedsAddPersonInfoDelegate <NSObject>

@optional
- (void)yp_addSuccess;

@end

@interface YPMyNewlywedsAddPersonInfoController : UIViewController

@property (nonatomic, assign) id<YPMyNewlywedsAddPersonInfoDelegate> addDelegate;

@property (nonatomic, strong) YPGetNewPeopleInfo *info;

@end
