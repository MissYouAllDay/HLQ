//
//  CXMyWalletMoneyVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/19.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXMyWalletMoneyVC.h"

@interface CXMyWalletMoneyVC ()

@end

@implementation CXMyWalletMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self defaSetting];
}

- (void)defaSetting {
 
    CAGradientLayer *layer = [CXUtils gradientLayerWithFrame:self.rechargeBtn.bounds withColors:@[(id)([CXUtils colorWithHexString:@"#F8626E"].CGColor),(id)([CXUtils colorWithHexString:@"#F82876"].CGColor)] withStartPoint:CGPointMake(0, 0) withEndPoint:CGPointMake(1, 0) withLocations:nil];
    
    [self.rechargeBtn.layer addSublayer:layer];
    
    self.rechargeBtn.layer.cornerRadius = 3;
    self.rechargeBtn.layer.masksToBounds = YES;
    
    self.cashBtn.layer.borderColor = [CXUtils colorWithHexString:@"#F83275"].CGColor;
    self.cashBtn.layer.borderWidth = 1;
    self.cashBtn.layer.cornerRadius = 3;
    
    [self.cashBtn setTitleColor:[CXUtils colorWithHexString:@"#F83674"] forState:UIControlStateNormal];
}


@end
