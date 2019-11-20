//
//  YPEDuApplyGiftController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/4/17.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SubmitDoneBlock)();

@interface YPEDuApplyGiftController : UIViewController

@property (nonatomic, copy) SubmitDoneBlock submitBlock;

@end
