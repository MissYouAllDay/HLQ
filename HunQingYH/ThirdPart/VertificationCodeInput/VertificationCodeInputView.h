//
//  VertificationCodeInputView.h
//  VertificationCodeInput
//
//  Created by wql on 2018/1/26.
//  Copyright © 2018年 wql. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol getTextFieldContentDelegate <NSObject>
//返回搜索内容
-(void)returnTextFieldContent:(NSString*)content;
@end
@interface VertificationCodeInputView : UIView
@property (assign,nonatomic,readwrite)id <getTextFieldContentDelegate>delegate;
/**背景图片*/
@property (nonatomic,copy)NSString *backgroudImageName;
/**验证码/密码的位数*/
@property (nonatomic,assign)NSInteger numberOfVertificationCode;
/**控制验证码/密码是否密文显示*/
@property (nonatomic,assign)bool secureTextEntry;
/**验证码/密码内容，可以通过该属性拿到验证码/密码输入框中验证码/密码的内容*/
@property (nonatomic,copy)NSString *vertificationCode;

-(void)becomeFirstResponder;
-(void)resignFirstResponder;
@end
