//
//  CXSmallTestMainView.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/9.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXSmallTestMainView.h"

@implementation CXSmallTestMainView


- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.mainBgView.backgroundColor = [UIColor colorWithHexString:@"#FD5A4A"];
    self.inputBgView.backgroundColor = [UIColor whiteColor];
    self.inputBgView.layer.borderColor = [UIColor yellowColor].CGColor;
    self.inputBgView.layer.borderWidth = 5;
    self.inputBgView.layer.cornerRadius = 15;
    self.inputBgView.clipsToBounds = YES;
    
//    self.backgroundColor = [UIColor colorWithHexString:@"#FD5A4A"];
    [self.mainBgView round:25 RectCorners:(UIRectCornerTopRight | UIRectCornerTopRight )];
    self.SubBtn.layer.cornerRadius = self.SubBtn.height/2;
    self.backgroundColor = [UIColor clearColor];
}

@end
