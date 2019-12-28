//
//  CXLoadNullView.h
//  HuanXinDemo
//
//  Created by mac on 2018/10/16.
//  Copyright © 2018年 HuaTingAuto. All rights reserved.
//
// - - - - - - - - - - - - - - - - - - - - 没有数据  - - - - - - - - - - - - - - - - - - - - - -

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^MarkBtnBloack)(void);

@interface CXLoadNullView : UIView

@property (nonatomic, strong) UIImageView *imgView; // 暂无数据图片

@property (nonatomic, strong) UILabel *addLab; // 立即添加 文字

@property (nonatomic, strong) UILabel *alertLab; // 提示信息

@property (nonatomic, copy) MarkBtnBloack markBlock;

- (void)selectMarkBtnAction:(MarkBtnBloack)markBlock;

@end

NS_ASSUME_NONNULL_END
