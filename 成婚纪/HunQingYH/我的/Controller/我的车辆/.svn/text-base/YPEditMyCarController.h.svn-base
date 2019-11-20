//
//  YPEditMyCarController.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPEditMyCarDelegate <NSObject>

@optional
- (void)editMyCarWithImg:(UIImage *)img Pinpai:(NSString *)pinpai PinPaiID:(NSString *)pinpaiID Xinghao:(NSString *)xinghao XingHaoID:(NSString *)xinghaoID Color:(NSString *)color;
- (void)editMyCarWithCarModelID:(NSString *)carModelID;

@end

@interface YPEditMyCarController : UIViewController

@property (nonatomic, assign) id<YPEditMyCarDelegate> editDelegate;

@property (nonatomic, strong) NSMutableArray *iconImgs;
//@property (nonatomic, copy) NSString *iconImgID;

@property (nonatomic, copy) NSString *carBrand;
@property (nonatomic, copy) NSString *carType;
@property (nonatomic, copy) NSString *carColor;
@property (nonatomic, copy) NSString *carBrandID;
@property (nonatomic, copy) NSString *carTypeID;

@end
