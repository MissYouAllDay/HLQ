//
//  messCanleView.h
//  HunQingYH
//
//  Created by Hiro on 2019/8/16.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface messCanleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *oneReasonLab;
@property (weak, nonatomic) IBOutlet UIButton *oneReasonBtn;
@property (weak, nonatomic) IBOutlet UILabel *twoReasonLab;
@property (weak, nonatomic) IBOutlet UIButton *twoReasonBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
+(instancetype)initViewWithXib;

@end

NS_ASSUME_NONNULL_END
