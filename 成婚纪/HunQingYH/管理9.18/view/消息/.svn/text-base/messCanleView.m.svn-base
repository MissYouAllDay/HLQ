//
//  messCanleView.m
//  HunQingYH
//
//  Created by Hiro on 2019/8/16.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "messCanleView.h"

@implementation messCanleView
+(instancetype)initViewWithXib{
    messCanleView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"messCanleView" owner:nil options:nil]lastObject];
    }
    return view;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.sureBtn.layer.masksToBounds =YES;
    self.sureBtn.layer.cornerRadius =20;
    self.sureBtn.layer.borderColor =MainColor.CGColor;
    self.sureBtn.layer.borderWidth =1;
}
@end
