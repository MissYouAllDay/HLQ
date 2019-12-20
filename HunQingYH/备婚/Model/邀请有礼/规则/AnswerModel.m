//
//  AnswerModel.m
//  HunQingYH
//
//  Created by Hiro on 2017/12/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "AnswerModel.h"

@implementation AnswerModel

+ (instancetype)answerWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
