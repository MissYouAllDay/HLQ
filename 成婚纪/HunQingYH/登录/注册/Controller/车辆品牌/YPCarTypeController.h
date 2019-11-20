//
//  YPCarTypeController.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/30.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPCarTypeDelegate <NSObject>

@optional
- (void)carType:(NSString *)carType andCarModelID:(NSString *)carID andCarColor:(NSString *)carColor;

@end

@interface YPCarTypeController : UIViewController

@property (nonatomic, assign) id<YPCarTypeDelegate> carTypeDelegate;

@property (nonatomic, copy) NSString *titleStr;
/**车型ID*/
@property (nonatomic, copy) NSString *carModelID;

@end
