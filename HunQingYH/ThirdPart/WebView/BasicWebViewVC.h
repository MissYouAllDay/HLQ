//
//  BasicWebViewVC.h
//  LYLWKWebView
//
//  Created by Rainy on 2018/5/7.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLWKWebView.h"
@interface BasicWebViewVC : UIViewController

@property(nonatomic,strong)LYLWKWebView *webViewManager;

-(void)initWebViewWithFrame:(CGRect)frame withUrl:(NSString *)URLString;
//- (void)webViewloadRequestWithURLString:(NSString *)URLSting;

@end
