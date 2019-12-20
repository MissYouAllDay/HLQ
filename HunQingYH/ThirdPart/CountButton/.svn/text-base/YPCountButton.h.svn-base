//
//  YPCountButton.h
//  MEMCoupon
//
//  Created by Else丶 on 2017/3/7.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountButtonDelegate <NSObject>
@optional
- (void)countButtonClicked;
@end

@interface YPCountButton : UIButton

//传入输入框中的内容,判断是否开始计时
@property (nonatomic,copy) NSString *tfText;

@property (nonatomic, assign) NSInteger countdownBeginNumber;
@property (nonatomic, weak) id<CountButtonDelegate> delegate ;
@property (nonatomic, copy) NSString *normalStateImageName;
@property (nonatomic, copy) NSString *highlightedStateImageName;
@property (nonatomic, copy) NSString *selectedStateImageName;
@property (nonatomic, copy) NSString *normalStateBgImageName;
@property (nonatomic, copy) NSString *highlightedStateBgImageName;
@property (nonatomic, copy) NSString *selectedStateBgImageName;
/**
 *  页面将要进入前台，开启定时器
 */
-(void)distantPastTimer;
/**
 *  页面消失，进入后台不显示该页面，关闭定时器
 *
 */
-(void)distantFutureTimer;
@end
