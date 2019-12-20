//
//  CXMyWalletBackMoneyLogCell.h
//  CXFrameWork
//
//  Created by canxue on 2019/12/19.
//  Copyright © 2019 canxue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXMyWalletBackMoneyLogCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *alertLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;


/// 推荐好友
- (void)shareStatus;

/// 首年免费
- (void)freeStatus;


@end

NS_ASSUME_NONNULL_END
