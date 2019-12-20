//
//  CXMyWalletTableViewCell.h
//  CXFrameWork
//
//  Created by canxue on 2019/12/19.
//  Copyright © 2019 canxue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXMyWalletTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *storeTypeImg;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *sender;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

NS_ASSUME_NONNULL_END
