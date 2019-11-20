//
//  hotelAddOnlyInputCell.h
//  HunQingYH
//
//  Created by xl on 2019/6/27.
//  Copyright © 2019 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface hotelAddOnlyInputCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

NS_ASSUME_NONNULL_END
