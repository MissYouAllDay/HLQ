//
//  manageTopView.m
//  HunQingYH
//
//  Created by xl on 2019/6/15.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "manageTopView.h"

@implementation manageTopView
+(instancetype)initViewWithXib{
    manageTopView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"manageTopView" owner:nil options:nil]lastObject];
    }
    return view;
}
@end
