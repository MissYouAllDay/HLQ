//
//  yhtorderPayAlertView.h
//  HunQingYH
//
//  Created by xl on 2019/6/23.
//  Copyright © 2019 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface yhtorderPayAlertView : UIView
+(instancetype)initViewWithXib;
@property (weak, nonatomic) IBOutlet UIButton *sureBtm;

@property (weak, nonatomic) IBOutlet UITextField *inputTextView;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@end

NS_ASSUME_NONNULL_END
