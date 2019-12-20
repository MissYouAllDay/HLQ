//
//  HRBeiHunController.h
//  HunQingYH
//
//  Created by Hiro on 2018/5/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZHNcontainerViewControllerDelegate <NSObject>
@required
- (void)zhnContainerContentScrollToIndex:(NSInteger)index;

@end

@interface HRBeiHunController : UIViewController
//======================= 必填项 =====================================//
/**
 *  头部视图的高度 （包含轮播 + toolview  toolview默认是30的高度）
 */
@property (nonatomic,assign) CGFloat bannerViewHeight;

/**
 *  内部内容控制器的数组
 */
@property (nonatomic,copy) NSArray <Class> * contentViewControllerArray;

/**
 *  banner图片的数组
 */
@property (nonatomic,copy) NSArray * bannerImageArray;

/**
 *  工具栏标题的数组(要和控制器数组一一对应)
 */
@property (nonatomic,copy) NSArray * toolTitleArray;

/**
 *  轮播的placeholder
 */
@property (nonatomic,strong) UIImage * bannerPlaceHolderImage;

//======================= 可选填项 =====================================//
/**
 *  toolview 的选择的颜色和下面小滑块的颜色
 */
@property (nonatomic,strong) UIColor * tintColor;

/**
 *  tool label 选中情况下的字体大小
 */
@property (nonatomic,assign) CGFloat toolLabelhightLightFont;

/**
 *  tool label 普通情况下的字体
 */
@property (nonatomic,assign) CGFloat toolLabelNormalFont;



// 私有的代理
@property (nonatomic,weak) id <ZHNcontainerViewControllerDelegate> delegate;
@end
