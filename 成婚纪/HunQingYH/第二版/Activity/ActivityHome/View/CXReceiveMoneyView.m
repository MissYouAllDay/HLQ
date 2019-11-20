//
//  CXReceiveMoneyView.m
//  HunQingYH
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXReceiveMoneyView.h"

@implementation CXReceiveMoneyView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushVC)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushVC)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushVC)];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushVC)];
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushVC)];
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushVC)];

    [self.reviceMoney         addGestureRecognizer:tap1];
    [self.testImg                  addGestureRecognizer:tap2];
    [self.backCustomerImg  addGestureRecognizer:tap3];
    [self.shareImg               addGestureRecognizer:tap4];
    [self.shareToFriendsImg addGestureRecognizer:tap5];
    [self.firstOrderimg         addGestureRecognizer:tap6];
    
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    layer.frame = self.reviceMoneyBtn.bounds;
    layer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0].CGColor];
    [self.reviceMoneyBtn.layer addSublayer:layer];

    UIBezierPath *maskPath;
     maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                      byRoundingCorners:(UIRectCornerAllCorners )
                                            cornerRadii:CGSizeMake(-self.reviceMoneyBtn.height/2, -self.reviceMoneyBtn.height/2)];
     CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
     maskLayer.frame = self.bounds;
     maskLayer.path = maskPath.CGPath;
     self.reviceMoneyBtn.layer.mask = maskLayer;
}

- (void)pushVC {
    
    
}

@end
