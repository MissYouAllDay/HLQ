//
//  YPNewWedsOtherSelectController.h
//  HunQingYH
//
//  Created by Else丶 on 2017/12/11.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPNewWedsOtherSelectDelegate <NSObject>

@optional
- (void)yp_selectUpdateSuccess;

@end

@interface YPNewWedsOtherSelectController : UIViewController

@property (nonatomic, assign) id<YPNewWedsOtherSelectDelegate> selectDelegate;

@property (nonatomic, copy) NSString *titleStr;

@property (nonatomic, copy) NSString *questionID;
/**
 选中的选项
 */
@property (nonatomic, copy) NSString *selectStr;
@property (nonatomic, copy) NSString *contentStr;

/**
 选项 以 , 分隔
 */
@property (nonatomic, copy) NSString *selectTypeStr;

@end
