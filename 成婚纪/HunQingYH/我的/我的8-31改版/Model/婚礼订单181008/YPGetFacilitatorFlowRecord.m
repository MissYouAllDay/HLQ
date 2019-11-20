//
//  YPGetFacilitatorFlowRecord.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/8.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPGetFacilitatorFlowRecord.h"

@implementation YPGetFacilitatorFlowRecord

+ (BOOL)checkoutData:(YPGetFacilitatorFlowRecord *)model {
    
    model.Phone =  [model.Phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (ISEMPTY(model.UserName)) {
        
        [EasyShowTextView showText:@"请填写新人姓名"];
        return NO;
    }
    if (ISEMPTY(model.Phone)) {
        
        [EasyShowTextView showText:@"请填写新人手机号"];
        return NO;
    }
    if (model.Phone.length != 11) {
        [EasyShowTextView showText:@"手机号填写不正确"];
        return NO;
    }
    
    if (ISEMPTY(model.WeddingDate)) {
        
        [EasyShowTextView showText:@"请填写婚期"];
        return NO;
    }
    if (ISEMPTY(model.TablesNumber)) {
        
        [EasyShowTextView showText:@"请填写桌数"];
        return NO;
    }
    if (ISEMPTY(model.MealMark)) {
        
        [EasyShowTextView showText:@"请填写餐标"];
        return NO;
    }
    if (ISEMPTY(model.Money)) {
        
        [EasyShowTextView showText:@"请填写缴纳金额"];
        return NO;
    }
    return YES;
}

+ (BOOL)checkouUserSubData:(YPGetFacilitatorFlowRecord *)model {
    
    model.Phone =  [model.Phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (ISEMPTY(model.UserName)) {
        
        [EasyShowTextView showText:@"请填写新人姓名"];
        return NO;
    }
    if (ISEMPTY(model.Phone)) {
        
        [EasyShowTextView showText:@"请填写新人手机号"];
        return NO;
    }
    if (model.Phone.length != 11) {
        [EasyShowTextView showText:@"手机号填写不正确"];
        return NO;
    }
    
    if (ISEMPTY(model.WeddingDate)) {
        
        [EasyShowTextView showText:@"请选择婚期"];
        return NO;
    }
    if (ISEMPTY(model.TablesNumber)) {
        
        [EasyShowTextView showText:@"请选择桌数"];
        return NO;
    }
    if (ISEMPTY(model.MealMark)) {
        
        [EasyShowTextView showText:@"请填写餐标"];
        return NO;
    }
    if (ISEMPTY(model.Meno)) {
        
        [EasyShowTextView showText:@"请填写意向酒店"];
        return NO;
    }
    return YES;
}

+ (NSDictionary *)changeInputInfoToSubData:(YPGetFacilitatorFlowRecord *)model {
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    param[@"Name"] = model.UserName;
    param[@"phone"] = model.Phone;
    param[@"Weddtime"] = model.WeddingDate;
    param[@"TablesNumber"] = model.TablesNumber;
    param[@"MealMark"] = model.MealMark;
    param[@"Meno"] = model.Meno;
    param[@"IdentityId"] = model.IdentityId;
    return param;
}

@end
