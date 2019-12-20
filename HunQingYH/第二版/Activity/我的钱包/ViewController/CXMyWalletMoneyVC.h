//
//  CXMyWalletMoneyVC.h
//  CXFrameWork
//
//  Created by canxue on 2019/12/19.
//  Copyright © 2019 canxue. All rights reserved.
//
// - - - - - - - - - - - - - - 我的钱包- - - - - - - - - - - - - - - - - - - - - -
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXMyWalletMoneyVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *seeDetailLab;

@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;
@property (weak, nonatomic) IBOutlet UIButton *cashBtn;
@end

NS_ASSUME_NONNULL_END
