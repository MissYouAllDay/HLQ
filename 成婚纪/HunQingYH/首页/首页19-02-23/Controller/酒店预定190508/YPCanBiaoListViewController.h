//
//  YPCanBiaoListViewController.h
//  HunQingYH
//
//  Created by Else丶 on 2019/5/16.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CanbiaoListBlock)(NSString *canbiaoID,NSString *canbiaoName);

@interface YPCanBiaoListViewController : UIViewController

@property (nonatomic, copy) NSString *tingID;
@property (nonatomic, copy) NSString *dateStr;

@property (nonatomic, copy) CanbiaoListBlock listBlock;

@end

NS_ASSUME_NONNULL_END
