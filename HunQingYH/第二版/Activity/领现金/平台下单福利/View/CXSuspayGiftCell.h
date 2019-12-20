//
//  CXSuspayGiftCell.h
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - 平台下单福利Cell- - - - - - - - - - - - - - - - - - - - - -

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXSuspayGiftCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *mainBgView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UIImageView *leftImg;
@property (weak, nonatomic) IBOutlet UILabel *alertLab;
@property (weak, nonatomic) IBOutlet UILabel *clickLab;

@end

NS_ASSUME_NONNULL_END
