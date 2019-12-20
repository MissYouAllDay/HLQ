//
//  CXMyWalletDetailLogCell.h
//  CXFrameWork
//
//  Created by canxue on 2019/12/19.
//  Copyright © 2019 canxue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXMyWalletDetailLogCell : UITableViewCell

@property (nonatomic, weak)  IBOutlet UILabel  *storeNameLab;    // 名称
@property (nonatomic, weak)  IBOutlet UILabel  *timeLab;    // 名称
@property (nonatomic, weak)  IBOutlet UILabel  *moneyLab;    // 名称
@property (nonatomic, weak)  IBOutlet UIView   *bgView;    // 名称

@end

NS_ASSUME_NONNULL_END
