//
//  NetworkTool.h
//  Huiyuetongcheng
//
//  Created by YanpengLee on 16/10/24.
//  Copyright © 2016年 YanpengLee. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger,HTTPRequestType) {
    HTTPRequestTypeGET = 0,
    HTTPRequestTypePOST
};

typedef void(^SuccessBlock) (NSDictionary *object);
typedef void(^FailureBlock) (NSError *error);
typedef void(^UploadSuccessBlock) (NSDictionary *object);

@interface NetworkTool : AFHTTPSessionManager

+ (instancetype)shareManager;

#pragma mark - 通用方法
- (void)requestWithUrlStr:(NSString *)urlStr withParams:(NSDictionary *)params Success:(SuccessBlock)successBlock Failure:(FailureBlock)failureBlock;

@end
