 //
//  NetworkTool.m
//  Huiyuetongcheng
//
//  Created by YanpengLee on 16/10/24.
//  Copyright © 2016年 YanpengLee. All rights reserved.
//

#import "NetworkTool.h"
#import "NSString+Hash.h"//MD5
#import "JSONKit.h"//字典转JSON字符串

@interface NetworkTool ()

@property (nonatomic, strong) NSDictionary *params;

@end

@implementation NetworkTool

+ (instancetype)shareManager{
    static NetworkTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc]initWithBaseURL:[NSURL URLWithString:Base_URL]];

#pragma mark - 支持HTTPS所需要修改的地方
//       AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//        [securityPolicy setValidatesDomainName:YES];
//        tool.securityPolicy = securityPolicy;
//        tool.responseSerializer = [AFHTTPResponseSerializer serializer];
#pragma mark -
        
        tool.requestSerializer = [AFJSONRequestSerializer serializer];
        tool.responseSerializer = [AFJSONResponseSerializer serializer];

        [tool.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [tool.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [tool .requestSerializer setTimeoutInterval:TIMEOUT];
        tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    });
    return tool;
}

- (void)requestNetwork:(HTTPRequestType)type withUrlStr:(NSString *)urlStr withParams:(NSDictionary *)params Success:(SuccessBlock)successBlock Failure:(FailureBlock)failureBlock{
    
//-------------------- 加密 -----------------------
    NSString *paramStr = [params JSONString];//字典转JSON字符串
    
    NSString *mStr = [NSMutableString stringWithFormat:@"hqoaapp002=(*$=UpQ4OBRP)=$*):%@",paramStr];
    
//    NSLog(@"part1  %@",mStr);
    
    mStr = [mStr md5String];
    mStr = [NSString stringWithFormat:@"hqoaapp002:%@",mStr];
    
//    NSLog(@"part2 - md5 %@",mStr);
    
    NSData *data = [mStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    
    NSString *result = [NSString stringWithFormat:@"Basic %@",base64String];
//    NSLog(@"part3 - result %@",result);
//-------------------- 加密 -----------------------
    
    //设置请求头
    NetworkTool *tool = [NetworkTool shareManager];
    [tool.requestSerializer setValue:result forHTTPHeaderField:@"Authorization"];

    
//    if (type == HTTPRequestTypeGET) {
//        
//        [[NetworkTool shareManager] GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            successBlock(responseObject);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            failureBlock(error);
//        }];
//
//    }else {
        [[NetworkTool shareManager] POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"**********。  %@",urlStr);
            
//            if ([urlStr containsString:@"/api/HQOAApi/GetPreferentialCommodityList"]) {
//                NSLog(@"%@",urlStr);
//            }
            
//            NSLog(@"success -- %@",responseObject);
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(error);
            NSLog(@"--%@",error);
        }];
//    }
}

#pragma mark - 通用方法
- (void)requestWithUrlStr:(NSString *)urlStr withParams:(NSDictionary *)params Success:(SuccessBlock)successBlock Failure:(FailureBlock)failureBlock{
    
    [[NetworkTool shareManager] requestNetwork:HTTPRequestTypePOST withUrlStr:urlStr withParams:params Success:^(id object) {
        successBlock(object);
    } Failure:^(NSError *error) {
        failureBlock(error);
    }];
}

@end

