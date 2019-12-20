//
//  WXApiManager.m
//  SDKSample
//
//  Created by Jeason on 15/7/14.
//
//

#import "WXApi.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "DataMD5.h"

@implementation WXApiRequestHandler

#pragma mark - Public Methods



+ (BOOL)jumpToBizWebviewWithAppID:(NSString *)appID
                      Description:(NSString *)description
                        tousrname:(NSString *)tousrname
                           ExtMsg:(NSString *)extMsg {
    [WXApi registerApp:appID withDescription:description];
    JumpToBizWebviewReq *req = [[JumpToBizWebviewReq alloc]init];
    req.tousrname = tousrname;
    req.extMsg = extMsg;
    req.webType = WXMPWebviewType_Ad;
    return [WXApi sendReq:req];
}


+ (NSString *)jumpToBizPay:(NSString *)tno{

    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString *urlString   = [NSString stringWithFormat:@"%@?ordernum=%@",Interface_WeChatPay,tno];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];


            NSError *error;
        //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

        if ( response != nil) {
            NSMutableDictionary *dict = NULL;
            //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
            dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
            
            NSLog(@"url:%@ json %@",urlString,dict);
            if(dict != nil){
                NSMutableString *retcode = [[dict objectForKey:@"message"] objectForKey:@"code"];
                if (retcode.intValue == 200){
                    NSMutableDictionary *message=[dict objectForKey:@"message"];
                    
                    //调起微信支付
                    PayReq* req             = [[PayReq alloc] init];
                    req.partnerId           = [message objectForKey:@"partnerid"];
                    req.prepayId            = [message objectForKey:@"prepayid"];
                    req.nonceStr            = [message objectForKey:@"noncestr"];
                 
                    req.package             = @"Sign=WXPay";//[message objectForKey:@"package"];
             
                    
                    NSDate *datenow = [NSDate date];
                    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
                    UInt32 timeStamp =[timeSp intValue];
                    req.timeStamp= timeStamp;
                    DataMD5 *md5 = [[DataMD5 alloc] init];
                    req.sign=[md5 createMD5SingForPay:[message objectForKey:@"appid"] partnerid:req.partnerId prepayid:req.prepayId package:req.package noncestr:req.nonceStr timestamp:req.timeStamp];
                    [WXApi sendReq:req];
                    //日志输出
                    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[message objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                    return @"";
                }else{
                    return [dict objectForKey:@"retmsg"];
                }
            }else{
                return @"服务器返回错误，未获取到json对象";
            }
        }else{
            return @"服务器返回错误";
        }
}
@end
