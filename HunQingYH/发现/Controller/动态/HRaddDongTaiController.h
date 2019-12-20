//
//  HRaddDongTaiController.h
//  HunQingYH
//
//  Created by Hiro on 2018/1/23.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRaddDongTaiController : UIViewController<UITextViewDelegate>

@property (strong, nonatomic)  UIScrollView *scrollView;

//内容
@property(nonatomic,strong) UITextView *noteTextView;

@end
