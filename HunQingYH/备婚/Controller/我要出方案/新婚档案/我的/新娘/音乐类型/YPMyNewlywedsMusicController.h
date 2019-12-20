//
//  YPMyNewlywedsMusicController.h
//  HunQingYH
//
//  Created by Else丶 on 2017/11/30.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPMyNewlywedsMusicDelegate <NSObject>

@optional
- (void)returnMusicType:(NSString *)type AndContent:(NSString *)content;

@end

@interface YPMyNewlywedsMusicController : UIViewController

@property (nonatomic, assign) id<YPMyNewlywedsMusicDelegate> musicDelegate;

@end
