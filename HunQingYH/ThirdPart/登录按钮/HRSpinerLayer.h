//
//  HRSpinerLayer.h
//  tongchenghuiMem
//
//  Created by DiKai on 16/8/11.
//  Copyright © 2016年 DiKai. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface HRSpinerLayer : CAShapeLayer
- (instancetype)initWithFrame:(CGRect)frame;

- (void)beginAnimation;

- (void)stopAnimation;

@end
