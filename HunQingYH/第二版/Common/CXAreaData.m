//
//  CXAreaData.m
//  HunQingYH
//
//  Created by canxue on 2019/12/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXAreaData.h"
#import "FMDatabase.h"

static FMDatabase  *dataBase;
@interface CXAreaData ()

//@property (nonatomic, strong) FMDatabase  *dataBase;    // <#这里是个注释哦～#>

@end
@implementation CXAreaData

#pragma mark --------数据库-------
+ (void)moveToDBFile
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:FirstKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:FirstKEY];
        //1、获得数据库文件在工程中的路径——源路径。
       NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"region"ofType:@"db"];
       
       
       //2、获得沙盒中Document文件夹的路径——目的路径
       NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
       NSString *documentPath = [paths objectAtIndex:0];
       NSString *desPath = [documentPath stringByAppendingPathComponent:@"region.db"];
       //3、通过NSFileManager类，将工程中的数据库文件复制到沙盒中。
       NSFileManager *fileManager = [NSFileManager defaultManager];
       if (![fileManager fileExistsAtPath:desPath])
       {
           NSError *error ;
           if ([fileManager copyItemAtPath:sourcesPath toPath:desPath error:&error]) {
               NSLog(@"数据库移动成功");
           }
           else {
               NSLog(@"数据库移动失败");
           }
       }
    }else  {
        
        NSLog(@"你丫的走过了");
    }
}
//打开数据库
+ (void)openDataBase{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"region.db"];
    
    dataBase =[[FMDatabase alloc]initWithPath:dbFilePath];
    BOOL ret = [dataBase open];
    if (ret) {
        NSLog(@"打开数据库成功");
        
    }else{
        NSLog(@"打开数据库成功");
    }
    
}
//关闭数据库
+ (void)closeDataBase{
    BOOL ret = [dataBase close];
    if (ret) {
        NSLog(@"关闭数据库成功");
    }else{
        NSLog(@"关闭数据库失败");
    }
}

// MARK: - 查询
//查询数据库
+(NSString *)selectDataBaseWithCityInfo:(NSString *)cityInfo withParentId:(int)parentId {
    [CXAreaData openDataBase];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    NSLog(@"缓存城市为%@",huanCun);
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'AND PARENT_ID =%d",cityInfo,parentId];
    FMResultSet *set =[dataBase executeQuery:selectSql];
    while ([set next]) {
        int ID = [set intForColumn:@"REGION_ID"];
        
        NSString *idStr = [NSString stringWithFormat:@"%d",ID];
        return idStr;
    }
    [CXAreaData closeDataBase];
    
    return nil;
}


// 订婚宴、客源管理 使用此方法。查询数据库
+ (NSString *)selectDataBaseWithCityInfo:(NSString *)cityInfo {
    [CXAreaData openDataBase];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"city_name_new"];
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'",cityInfo];
    FMResultSet *set =[dataBase executeQuery:selectSql];
    while ([set next]) {
        int ID = [set intForColumn:@"REGION_ID"];
        NSString *idStr = [NSString stringWithFormat:@"%d",ID];
        return idStr;
    }
    [CXAreaData closeDataBase];
    return nil;
}

/**
 查询某市级所管辖的县/区
 */
+ (NSArray *)searchCityListWithParentId:(NSInteger )parentID {
    
    [CXAreaData openDataBase];
    NSMutableArray *areaArray = [[NSMutableArray alloc] init];
    
    NSString *selectSql4 =[NSString stringWithFormat:@"SELECT REGION_NAME FROM Region WHERE  PARENT_ID = %ld",(long)parentID];
    FMResultSet *set4 =[dataBase executeQuery:selectSql4];
    
    while ([set4 next]) {
        NSString *cityStr  = [set4 stringForColumn:@"REGION_NAME"];
        [areaArray addObject:cityStr];
        
    }
    [CXAreaData closeDataBase];
    [areaArray insertObject:@"全部区域" atIndex:0];
    return areaArray;
}



@end
