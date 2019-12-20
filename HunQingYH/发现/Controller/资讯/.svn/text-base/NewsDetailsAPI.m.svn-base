//
//  NewsDetailsAPI.m
//  HunQingYH
//
//  Created by Hiro on 2018/4/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "NewsDetailsAPI.h"

@implementation NewsDetailsAPI
- (void)loadDataWithNewsId:(NSString *)newsId ResultBlock:(void (^)(NewsDetailsModel *model))resultBlock{
    
    
    
    
    
    
    // 这里网络请求数据
    
    
    
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetInformationArticleInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"InformationArticleID"] =newsId;
    params[@"GetType"] = @"1";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"资讯详情：%@",object);
            
            
            NewsDetailsModel * model = [[NewsDetailsModel alloc] init];
            model.newsId = newsId;
            model.newsTitle =[object objectForKey:@"Title"];
            
            
            model.newsHtml = [object objectForKey:@"Content"];
            
            
            // 模拟加载完成后 添加到缓存
            
            [NewsDetailsModel setCache:model forNewsId:model.newsId];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (resultBlock) resultBlock(model);
            });
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
    
    
    dispatch_async(dispatch_queue_create("requestQueue", DISPATCH_QUEUE_CONCURRENT), ^{
        
        // 请求时可以考虑判断网络状态 如果无网络时 可以使用缓存
        
//        if ([YYReachability reachability].isReachable) {
//            
//            // 有网络 模拟请求
//            
//            NewsDetailsModel * model = [[NewsDetailsModel alloc] init];
//            
//            model.newsId = newsId;
//            model.newsTitle =@"标题标题标题";
//          
//            
//            model.newsHtml = @"";
//            
//           
//            // 模拟加载完成后 添加到缓存
//            
//            [NewsDetailsModel setCache:model forNewsId:model.newsId];
//            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
//                if (resultBlock) resultBlock(model);
//            });
//            
//        } else {
//            
//            // 无网络 使用缓存
//            
//            NewsDetailsModel *model = [NewsDetailsModel cacheForNewsId:newsId];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                if (resultBlock) resultBlock(model);
//            });
//            
//        }
        
    });
    
}
@end
