//
//  CXDataManager.m
//  HunQingYH
//
//  Created by apple on 2019/9/27.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXDataManager.h"

@implementation CXDataManager

+ (void)savaUserInfo:(NSDictionary *)object {
    //登录->存储本地信息 2018-07-31
    [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"UserId"] forKey:@"UserId_New"];
    [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"Name"] forKey:@"Name_New"];
    [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"Headportrait"] forKey:@"Headportrait_New"];
    [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"Profession"] forKey:@"Profession_New"];
    [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"Phone"] forKey:@"Phone_New"];
    [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"FacilitatorId"] forKey:@"FacilitatorId_New"];
    [CXDataManager checkUserProfession:Profession_New];
    //18-08-19 修改
    NSString *str = [object valueForKey:@"region"];
    if (str.length > 0) {
        [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"region"] forKey:@"region_New"];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:@"1740" forKey:@"region_New"];
    }
    
    if ([object objectForKey:@"regionname"]) {
        [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"regionname"] forKey:@"regionname_New"];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:@"黄岛区" forKey:@"regionname_New"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[object objectForKey:@"WeChatName"] forKey:@"WeChatName_New"];
    [[NSUserDefaults standardUserDefaults] setObject:[object objectForKey:@"WeChatType"] forKey:@"WeChatType_New"];
    [[NSUserDefaults standardUserDefaults] setObject:[object objectForKey:@"Wedding"] forKey:@"Wedding_New"];
}

+ (NSString *)checkUserProfession:(NSString *)profession {
    NSString *professionName = @"  无职业  ";   // 职业名称
    if (profession.length > 0) {
        if (JiuDian(profession)) {
            professionName = @"  酒店  ";
        }else if (HunChe(profession)) {
            professionName = @"  婚车  ";
        }else if (ZhuChi(profession)) {
            professionName = @"  主持人  ";
        }else if (SheXiang(profession)) {
            professionName = @"  摄像师  ";
        }else if (SheYing(profession)) {
            professionName = @"  摄影师  ";
        }else if (HuaZhuang(profession)) {
            professionName = @"  化妆师  ";
        }else if (YanYi(profession)) {
            professionName = @"  演艺  ";
        }else if (HunSha(profession)) {
            professionName = @"  婚纱  ";
        }else if (DuDao(profession)) {
            professionName = @"  督导师  ";
        }else if (HuaYi(profession)) {
            professionName = @"  花艺师  ";
        }else if (DongGuang(profession)) {
            professionName = @"  灯光师  ";
        }else if (YongHu(profession)) {
            professionName = @"  用户  ";
        }else if (CheShou(profession)) {
            professionName = @"  车手  ";
        }else if (HunQing(profession) || YuanGong(profession)) {
            professionName = @"  婚庆  ";
        }else if (DaPingMu(profession)) {
            professionName = @"  大屏幕  ";
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:professionName forKey:@"Profession_Name_New"];
    return professionName;
}

+ (void)hiddenKeyBoard{
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIView * firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [firstResponder resignFirstResponder];
    });
}

+ (BOOL)checkTelPhoneNum:(NSString *)number {
    
    number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *regex = @"^1+[345789]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:number];
}

+ (BOOL)checkNumInputShouldNumber:(NSString *)number {
    
    /** 1 */
    if (number.length == 0) { return NO; }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:number];
    
    /** 2 */
    return @([number integerValue]).stringValue.length;
    
    /**  3 */
    NSScanner* scan = [NSScanner scannerWithString:number];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
    /** 4 */
    NSString *checkedNumString = [number stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    return checkedNumString.length;
}

@end
