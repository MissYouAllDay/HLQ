//
//  CXMyCouponDetailCodeCell.h
//  CXFrameWork
//
//  Created by canxue on 2019/12/18.
//  Copyright © 2019 canxue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXMyCouponDetailCodeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *codeNumLab;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImg;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLab;
@property (weak, nonatomic) IBOutlet UILabel *alertlab;

@end

NS_ASSUME_NONNULL_END
