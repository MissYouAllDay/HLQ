//
//  CXMyCouponDetailCell.h
//  CXFrameWork
//
//  Created by canxue on 2019/12/18.
//  Copyright © 2019 canxue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXMyCouponDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activityLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *statuslab;
@property (weak, nonatomic) IBOutlet UIView *bgView;



/// 未使用
- (void)notUsed;

/// 已使用
- (void)alreadyUsed;

/// 已过期
- (void)expired;

@end

NS_ASSUME_NONNULL_END
