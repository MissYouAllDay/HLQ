//
//  CXInviteHotelStayLogCell.h
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - 邀请酒店记录cell- - - - - - - - - - - - - - - - - - - - - -
#import <UIKit/UIKit.h>
#import "CXInviteHotelListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CXInviteHotelStayLogCell : UITableViewCell

@property (nonatomic, strong) CXInviteHotelListModel  *model;    // <#这里是个注释哦～#>
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UITextField *shopNameTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *canbiaoTF;
@property (weak, nonatomic) IBOutlet UITextField *tingNumTF;
@property (weak, nonatomic) IBOutlet UITextField *resultTF;
@property (weak, nonatomic) IBOutlet UIView *mainBgView;

@end

NS_ASSUME_NONNULL_END
