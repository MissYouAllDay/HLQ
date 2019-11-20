//
//  BasicWebViewVC.m
//  LYLWKWebView
//
//  Created by Rainy on 2018/5/7.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "BasicWebViewVC.h"
#import "WebChatPayH5VIew.h"


@interface BasicWebViewVC ()<WKNavigationDelegate>



@end

@implementation BasicWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)initWebViewWithFrame:(CGRect)frame withUrl:(NSString *)URLString{
    _webViewManager = [[LYLWKWebView alloc] initWithFrame:frame];
    _webViewManager.webView.navigationDelegate = self;
    [self.view addSubview:_webViewManager];
    [self.webViewManager.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLString]]];
}

//- (void)webViewloadRequestWithURLString:(NSString *)URLSting
//{
//    [self.webViewManager.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLSting]]];
//}

#pragma mark - <WKNavigationDelegate>
- (void)webView:(WKWebView*)webView decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler{
    
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];


//    if ([urlString containsString:@"weixin://wap/pay?"]) {
//        decisionHandler(WKNavigationActionPolicyCancel);
//        //解决wkwebview weixin://无法打开微信客户端的处理
//        NSURL *url = [NSURL URLWithString:urlString];
//        [[UIApplication sharedApplication]openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
//        }];
//    }
//     else {
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
    
    NSString *url = navigationAction.request.URL.absoluteString;
    if ([url containsString:@"https://wx.tenpay.com/cgi-bin/mmpayweb-bin/checkmweb?"]) {
#warning 微信支付链接不要拼接redirect_url，如果拼接了还是会返回到浏览器的
        //传入的是微信支付链接：https://wx.tenpay.com/cgi-bin/mmpayweb-bin/checkmweb?prepay_id=wx201801291021026cb304f9050743178155&package=3456576571
        //这里把webView设置成一个像素点，主要是不影响操作和界面，主要的作用是设置referer和调起微信
        WebChatPayH5VIew *h5View = [[WebChatPayH5VIew alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        //url是没有拼接redirect_url微信h5支付链接
        [h5View loadingURL:url withIsWebChatURL:NO];
        [self.view addSubview:h5View];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }

    
}





- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    //"webViewDidStartLoad"
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    //"webViewDidFinishLoad"
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loadFinished" object:self ];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    //"webViewDidFailLoad"
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //"webViewWillLoadData"
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    //"webViewWillAuthentication"
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling , nil);
}

//#pragma mark - lazy
//-(LYLWKWebView *)webViewManager
//{
//    if (!_webViewManager) {
//
//        _webViewManager = [[LYLWKWebView alloc] initWithFrame:self.view.bounds];
//        _webViewManager.webView.navigationDelegate = self;
//        [self.view addSubview:_webViewManager];
//    }
//    return _webViewManager;
//}


@end
