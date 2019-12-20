//
//  CXStoreMyCouponListCell.h
//  CXFrameWork
//
//  Created by canxue on 2019/12/18.
//  Copyright © 2019 canxue. All rights reserved.
//

// - - - - - - - - - - - - - - 领取情况 cell- - - - - - - - - - - - - - - - - - - - - -
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXStoreMyCouponListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumLab;
@property (weak, nonatomic) IBOutlet UILabel *activityLab;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

NS_ASSUME_NONNULL_END
