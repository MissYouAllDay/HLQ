//
//  YPDetailRulerView.h
//  hunqing
//
//  Created by Else丶 on 2017/11/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPDetailRulerView : UIView

@property (weak, nonatomic) IBOutlet UILabel *ruler1;
@property (weak, nonatomic) IBOutlet UILabel *ruler2;
@property (weak, nonatomic) IBOutlet UILabel *ruler3;
@property (weak, nonatomic) IBOutlet UILabel *ruler4;
@property (weak, nonatomic) IBOutlet UILabel *ruler5;
@property (weak, nonatomic) IBOutlet UILabel *ruler6;
@property (weak, nonatomic) IBOutlet UILabel *ruler7;

+ (instancetype)detailRulerView;

@end
