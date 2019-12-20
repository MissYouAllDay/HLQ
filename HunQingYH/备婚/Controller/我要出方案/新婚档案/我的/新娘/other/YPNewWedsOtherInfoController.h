//
//  YPNewWedsOtherInfoController.h
//  HunQingYH
//
//  Created by Else丶 on 2017/12/5.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPNewWedsOtherInfoDelegate <NSObject>

@optional
- (void)yp_infoUpdateSuccess;

@end

@interface YPNewWedsOtherInfoController : UIViewController

@property (nonatomic, assign) id<YPNewWedsOtherInfoDelegate> infoDelegate;

/**
 our 我们的 才赋值  邀请码调用 UpType=4  特别说明调用  UpType=6
 */
@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *titleStr;

/**
 我的 - 问题ID  我们的 - 新人订制ID
 */
@property (nonatomic, copy) NSString *questionID;
@property (nonatomic, copy) NSString *contentStr;

/**
 输入最大字数  -- 不设置,默认200
 */
@property (nonatomic, assign) NSInteger maxNum;

@end
