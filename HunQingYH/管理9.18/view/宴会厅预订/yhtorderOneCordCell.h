//
//  yhtorderOneCordCell.h
//  HunQingYH
//
//  Created by xl on 2019/6/23.
//  Copyright © 2019 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface yhtorderOneCordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *contentview;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *desLab;
+(instancetype)cellWithTableView:(UITableView *)tableView;


@end

NS_ASSUME_NONNULL_END
