//
//  CXInvitationFriendInfoView.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/17.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXInvitationFriendInfoView.h"

@implementation CXInvitationFriendInfoView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    self.mainBgView.backgroundColor = [UIColor whiteColor];
    self.mainBgView.layer.cornerRadius = 15;
    self.mainBgView.clipsToBounds = YES;
    
    [self.subBtn setBackgroundImage:[UIImage imageNamed:@"invitationSubBtn"] forState:UIControlStateNormal];
}

@end
