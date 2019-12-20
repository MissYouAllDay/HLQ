//
//  ProblemTitleModel.m
//  HunQingYH
//
//  Created by Hiro on 2017/12/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "ProblemTitleModel.h"
#import "AnswerModel.h"

@implementation ProblemTitleModel

+ (instancetype)friendGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (int i =0; i<_Rule.count ; i++) {
            AnswerModel *answer;
            answer.answer =_Rule[i];
             [tempArray addObject:answer];
        }
        
//        for (NSDictionary *dict in _Rule) {
//            
//            AnswerModel *answer = [AnswerModel answerWithDict:dict];
//            [tempArray addObject:answer];
//        }
        _Rule = tempArray;
    }
    return self;
}
@end
