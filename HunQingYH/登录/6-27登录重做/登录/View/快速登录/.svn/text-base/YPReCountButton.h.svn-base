//
//  YPReCountButton.h
//  HunQingYH
//
//  Created by Else丶 on 2018/6/28.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountButtonDelegate <NSObject>
@optional
- (void)countButtonClicked;
@end

@interface YPReCountButton : UIButton


//传入输入框中的内容,判断是否开始计时
@property (nonatomic,copy) NSString *tfText;

@property (nonatomic, assign) NSInteger countdownBeginNumber;
@property (nonatomic, weak) id<CountButtonDelegate> delegate ;
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
