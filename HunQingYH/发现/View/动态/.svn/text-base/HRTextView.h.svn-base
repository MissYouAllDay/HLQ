//
//  HRTextView.h
//  HunQingYH
//
//  Created by Hiro on 2018/1/11.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MaxTextViewHeight 80 //限制文字输入的高度
@interface HRTextView : UIView
@property (nonatomic, strong) UITextView *textView;
//------ 发送文本 -----//
@property (nonatomic,copy) void (^HRTextViewBlock)(NSString *text);
//------  设置占位图符 ------//
- (void)setPlaceholderText:(NSString *)text;
@end
