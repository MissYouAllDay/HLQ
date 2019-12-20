//
//  YPMoreBtnControl.h
//  HunQingYH
//
//  Created by Else丶 on 2019/2/25.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YPSelectBtnBlock)(NSString *select);

@interface YPMoreBtnControl : UIControl

#pragma mark - 属性
/** 标题名 */
@property (nonatomic, copy) NSString *titleStr;///< 默认 "选择下列选项"
/** 左右边距 */
@property (nonatomic, assign) CGFloat leftRightMargin;///< 默认18
/** 内部view宽度 */
@property (nonatomic, assign) CGFloat viewWidth;///< 默认屏宽-leftRightMargin*2
/** 内部view高度 */
@property (nonatomic, assign) CGFloat viewHeight;///< 默认根据按钮计算高度
/** Control透明度 */
@property (nonatomic, assign) CGFloat controlAlpha;///< 默认0.4
/** 按钮名称数组 */
@property (nonatomic, strong, readonly) NSArray *btnTitleArr;///< 必传-初始化方法中

/** 按钮间距 */
@property (nonatomic, assign) CGFloat btnMargin;///< 默认15
/** 按钮高度 */
@property (nonatomic, assign) CGFloat btnHeight;///< 默认40
/** 按钮列数 */
@property (nonatomic, assign) NSInteger btnCol;///< 默认3列

/** 普通状态按钮文字颜色 */
@property (nonatomic, strong) UIColor *normalTitleColor;
/** 选中状态按钮文字颜色 */
@property (nonatomic, strong) UIColor *selectedTitleColor;
/** 普通状态按钮颜色 */
@property (nonatomic, strong) UIColor *normalColor;
/** 选中状态按钮颜色 */
@property (nonatomic, strong) UIColor *selectedColor;

@property (nonatomic, copy) YPSelectBtnBlock selectBlock;

#pragma mark - 方法
/** init */
- (instancetype)initWithFrame:(CGRect)frame AndTitleArr:(NSArray *)titleArr;
/** 显示 */
- (void)showControl;
/** 移除 */
- (void)controlRemove;

@end

NS_ASSUME_NONNULL_END
