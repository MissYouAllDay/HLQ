//
//  HRHotelTingXQViewController.h
//  HunQingYH
//
//  Created by DiKai on 2017/8/23.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRHotelTingXQViewController : UIViewController
#pragma mark - 变量-------------------------------------------------------------
// 图片url地址的数组
@property (nonatomic,strong) NSArray *imageUrlArrays ;

#pragma mark - 视图-------------------------------------------------------------
// 第几张图片的文本
@property (nonatomic,strong) UILabel *label ;

/**厅ID*/
@property(nonatomic,assign)NSInteger  BanquetID;
@end
