//
//  YPMyWalletBalanceTiXianAccountController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/2/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPMyWalletBalanceTiXianAccountDelegate <NSObject>

@optional
- (void)yp_tixianAccount:(NSString *)account;

@end

@interface YPMyWalletBalanceTiXianAccountController : UIViewController

@property (nonatomic, assign) id<YPMyWalletBalanceTiXianAccountDelegate> accountDelete;

@end
