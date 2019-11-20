//
//  HRShareItemButton.h
//  HunQingYH
//
//  Created by Dikai on 2018/6/28.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRShareItemButton : UIButton
+ (instancetype)shareButton;
- (instancetype)initWithFrame:(CGRect)frame
                    ImageName:(NSString *)imageName
                     imageTag:(NSInteger)imageTAG
                        title:(NSString *)title
                    titleFont:(CGFloat)titleFont
                   titleColor:(UIColor *)titleColor;
@end
