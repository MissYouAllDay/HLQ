//
//  YPAddIconController.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/25.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPAddIconDelegate <NSObject>

@optional
- (void)returnIconImg:(UIImage *)image;

@end

@interface YPAddIconController : UIViewController

@property (nonatomic, assign) id<YPAddIconDelegate> iconDelegate;

@end
