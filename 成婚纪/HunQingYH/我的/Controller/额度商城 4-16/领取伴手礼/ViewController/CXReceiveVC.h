//
//  CXReceiveVC.h
//  HunQingYH
//
//  Created by apple on 2019/9/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXReceiveVC : UIViewController

@end


@interface CXSetMenuSectionHeader : UIView

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIButton *reviceBtn;
/** 右侧按钮是否隐藏 */
@property (nonatomic, assign) BOOL rightViewHidden;

@end

NS_ASSUME_NONNULL_END
