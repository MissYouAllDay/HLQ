//
//  slidermecell.h
//  HunQingYH
//
//  Created by Hiro on 2019/6/21.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface slidermecell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImgeVIEW;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
