//
//  HRTransitions.h
//  tongchenghuiMem
//
//  Created by DiKai on 16/8/11.
//  Copyright © 2016年 DiKai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HRTransitions : NSObject <UIViewControllerAnimatedTransitioning>

-(instancetype) initWithTransitionDuration:(NSTimeInterval)transitionDuration StartingAlpha:(CGFloat)startingAlpha isPush:(BOOL)isPush;



@end
