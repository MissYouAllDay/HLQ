//
//  HRZXPrisentCell.m
//  HunQingYH
//
//  Created by Hiro on 2017/12/8.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRZXPrisentCell.h"

@implementation HRZXPrisentCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"HRZXPrisentCell" owner:self options:nil].lastObject;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lingquBtn.clipsToBounds =YES;
    self.lingquBtn.layer.cornerRadius =10;
}



@end
