//
//  YPUnqualifiedReasonView.h
//  hunqing
//
//  Created by Else丶 on 2018/3/19.
//  Copyright © 2018年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPUnqualifiedReasonView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

+ (instancetype)yp_unqualifiedReasonView;

@end
