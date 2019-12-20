//
//  YPRegistStep2View.h
//  hunqing
//
//  Created by YanpengLee on 2017/5/12.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPRegistStep2View : UIView

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UITextField *surePswTF;
@property (weak, nonatomic) IBOutlet UITextField *licenceTF;
@property (weak, nonatomic) IBOutlet UIButton *addImgBtn;

+ (YPRegistStep2View *)registStep2View;

@end
