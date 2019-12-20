//
//  yhtorderPayAlertView.m
//  HunQingYH
//
//  Created by xl on 2019/6/23.
//  Copyright © 2019 xl. All rights reserved.
//

#import "yhtorderPayAlertView.h"

@implementation yhtorderPayAlertView
+(instancetype)initViewWithXib{
    yhtorderPayAlertView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"yhtorderPayAlertView" owner:nil options:nil]lastObject];
    }
    return view;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.cancleBtn.clipsToBounds =YES;
    self.cancleBtn.layer.cornerRadius =20;
    self.cancleBtn.layer.borderColor =LineColor.CGColor;
    self.cancleBtn.layer.borderWidth =1;
    
    self.sureBtm.clipsToBounds =YES;
    self.sureBtm.layer.cornerRadius =20;
    self.clipsToBounds =YES;
    self.layer.cornerRadius=10;
}
@end
