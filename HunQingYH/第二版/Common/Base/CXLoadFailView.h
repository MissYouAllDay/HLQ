//
//  CXLoadFailView.h
//  HuanXinDemo
//
//  Created by mac on 2018/10/16.
//  Copyright © 2018年 HuaTingAuto. All rights reserved.
//
// - - - - - - - - - - - - - - - - - - - - 请求失败  - - - - - - - - - - - - - - - - - - - - - -

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXLoadFailView : UIView

@property (nonatomic, strong) UIImageView *imgView; // 请求失败图片

@property (nonatomic, strong) UILabel *alertLab;    // 提示信息

@end

NS_ASSUME_NONNULL_END
