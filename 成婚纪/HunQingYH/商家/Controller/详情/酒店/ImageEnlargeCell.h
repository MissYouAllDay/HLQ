//
//  ImageEnlargeCell.h
//  Init
//
//  Created by DiKai on 16/9/20.
//  Copyright © 2016年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageEnlargeCell : UICollectionViewCell<UIScrollViewDelegate>



#pragma mark - 变量-------------------------------------------------------------
// 图片的url地址
@property (nonatomic,strong) NSString *imageUrlString ;


#pragma mark - 视图-------------------------------------------------------------
// 视图
@property (nonatomic,strong) UIImageView *imageView ;

@property (nonatomic,strong) UIScrollView *scrollView ;

@end
