//
//  CXMyCouponDetailShopCell.h
//  CXFrameWork
//
//  Created by canxue on 2019/12/18.
//  Copyright © 2019 canxue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXMyCouponDetailShopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLab;
@property (weak, nonatomic) IBOutlet UILabel *shopAdressLab;
@property (weak, nonatomic) IBOutlet UIButton *phoneTel;
@property (weak, nonatomic) IBOutlet UILabel *shopActivityLab;

@end

NS_ASSUME_NONNULL_END
