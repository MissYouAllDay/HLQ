//
//  CXMyWalletTableViewCell.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/19.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXMyWalletTableViewCell.h"

@implementation CXMyWalletTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.borderColor = [CXUtils colorWithHexString:@"#D9D9D9"].CGColor;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.cornerRadius = 15;
    
    CAGradientLayer *layer = [CXUtils gradientLayerWithFrame:self.sender.bounds withColors:@[(id)([CXUtils colorWithHexString:@"#F8626E"].CGColor),(id)([CXUtils colorWithHexString:@"#F82876"].CGColor)] withStartPoint:CGPointMake(0, 0) withEndPoint:CGPointMake(1, 0) withLocations:nil];
    [self.sender.layer addSublayer:layer];
    
    self.sender.layer.cornerRadius = self.sender.height/2;
    self.sender.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
