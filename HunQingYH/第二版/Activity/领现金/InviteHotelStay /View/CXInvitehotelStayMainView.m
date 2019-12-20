//
//  CXInvitehotelStayMainView.m
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXInvitehotelStayMainView.h"

@implementation CXInvitehotelStayMainView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.mainBgView.layer.cornerRadius = 10;
    self.mainBgView.clipsToBounds = YES;
    self.subBtn.layer.cornerRadius = self.subBtn.height/2;
    
}
@end
