//
//  HRAnLiModel.h
//  HunQingYH
//
//  Created by DiKai on 2017/9/5.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRAnLiModel : NSObject
/**案例ID*/
@property(nonatomic,copy)NSString  *CaseID;
/**封面图*/
@property(nonatomic,copy)NSString  *CoverMap;
/**标题*/
@property(nonatomic,copy)NSString  *LogTitle;
/**创建时间*/
@property(nonatomic,copy)NSString  *CreateTime;
@end
