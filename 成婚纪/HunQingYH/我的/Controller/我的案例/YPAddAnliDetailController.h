//
//  YPAddAnliDetailController.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/2.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "LQPhotoPickerViewController.h"

@interface YPAddAnliDetailController : LQPhotoPickerViewController <UITextViewDelegate>

@property (strong, nonatomic)  UIScrollView *scrollView;

@property(nonatomic,strong) UIView *noteTextBackgroudView;
//标题
@property(nonatomic,strong) UITextView *titleTextView;
//内容
@property(nonatomic,strong) UITextView *noteTextView;

//文字个数提示label
@property(nonatomic,strong) UILabel *textNumberLabel;

//上传类型
@property (nonatomic, copy) NSString *type;
//上传类型Label
@property (nonatomic, strong) UILabel *typeLabel;

@end
