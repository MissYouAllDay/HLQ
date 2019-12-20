//
//  YPInviteFriendsWedVIPRecordView.h
//  HunQingYH
//
//  Created by Else丶 on 2018/10/15.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPInviteFriendsWedVIPRecordView : UIView

@property (nonatomic, assign) BOOL isOpen;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImgV;
@property (weak, nonatomic) IBOutlet UIButton *showBtn;

+ (instancetype)yp_InviteFriendsWedVIPRecordView;

@end

NS_ASSUME_NONNULL_END
