//
//  manageTopView.h
//  HunQingYH
//
//  Created by xl on 2019/6/15.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface manageTopView : UIView
@property (weak, nonatomic) IBOutlet UIButton *danjianbtn;
@property (weak, nonatomic) IBOutlet UIButton *jiudianBtn;

@property (weak, nonatomic) IBOutlet UIButton *yanhuitingbtn;
+(instancetype)initViewWithXib;
@end

NS_ASSUME_NONNULL_END
