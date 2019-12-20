//
//  CXInvitationFriendInfoView.h
//  CXFrameWork
//
//  Created by canxue on 2019/12/17.
//  Copyright © 2019 canxue. All rights reserved.
//

// - - - - - - - - - - - - - - 推荐好友 推荐人信息- - - - - - - - - - - - - - - - - - - - - -
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXInvitationFriendInfoView : UIView
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *telTF;
@property (weak, nonatomic) IBOutlet UITextField *hunqiTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UIButton *hunYanBtn;
@property (weak, nonatomic) IBOutlet UIButton *hunLiBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;

@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@property (weak, nonatomic) IBOutlet UIView *mainBgView;

@end

NS_ASSUME_NONNULL_END
