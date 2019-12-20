//
//  Upload_touxiang.m
//  LanTuZG
//
//  Created by zrsoft on 14/10/23.
//  Copyright (c) 2014年 zrsoft. All rights reserved.
//

#import "Upload.h"
//#import "NetWebServiceRequest.h"

#import "RequestPostUploadHelper.h"

@implementation Upload
+(NSString *)getUUID
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyMMddHHmmss"];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    int randomValue =arc4random() %100000;
    
    NSString *unique = [NSString stringWithFormat:@"%@%d",dateString,randomValue];
    return unique;
}

+(void)upload:(UIImage *)image
         GUID:(NSString *)guid type:(NSString *)typeValue{
//    @try {
        NSMutableDictionary * dir=[NSMutableDictionary dictionaryWithCapacity:3];
        [dir setValue:@"0" forKey:@"ot"];
        if (!UserId_New) {//注册时 id为空 此时传0
            [dir setValue:@"0" forKey:@"oi"];
        }else{
            [dir setValue:UserId_New forKey:@"oi"];
        }
        [dir setValue:typeValue forKey:@"t"];
    
//    if ([typeValue intValue]==1||[typeValue intValue]==2) {
//        [dir setValue:myname forKey:@"userphone"];
//    }
        NSString *url=@"http://121.42.156.151:93/FileStorage.aspx" ;
//    参数说明：
//    ot：对象类型（0用户图、1商家图）
//    oi：对象ID（如用户ID、商家ID）
//    t：图片类型（用户图片类型：0 头像、1相册、2 约会、3 微博；商户图片类型：0商家代表图、1营业执照图、2环境图、3商品图、4团购图、5图文详情图）
//
//http://121.42.156.151:91/FileStorage.aspx?ot=xxx&oi=xxx&t=xxx
    
//        [MBProgressHUD wj_showActivityLoading:@"图片正在上传中,请稍候..." toView:nil];
    
        [RequestPostUploadHelper postRequestWithURL:url postParems:dir picFilePath:image picFileName:guid];
    
    
//    }
//    @catch (NSException *exception) {
//    }
}

+(void)uploaddata:(NSData *)filedata
             GUID:(NSString *)filename type:(NSString *)typeValue
{
    
 
    NSString *url=@"http://121.42.156.151:93/upload.aspx" ;
    NSMutableDictionary * dir=[NSMutableDictionary dictionaryWithCapacity:1];
    [dir setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"] forKey:@"oi"];
    [dir setValue:typeValue forKey:@"t"];
      [dir setValue:@"0" forKey:@"ot"];
    [RequestPostUploadHelper postRequestDataWithURL:url postParems:dir picFilePath:filedata picFileName:filename];
}
+(void)newupload:(UIImage *)image
         GUID:(NSString *)guid type:(NSString *)typeValue{
    //    @try {
    
   
    NSMutableDictionary * dir=[NSMutableDictionary dictionaryWithCapacity:2];
//    [dir setValue:myname forKey:@"phonenumber"];
 
    [dir setValue:guid  forKey:@"oi"];
    
    NSString *url=@"http://121.42.156.151:93/FileStorage.aspx" ;
    
    
    [RequestPostUploadHelper postRequestWithURL:url postParems:dir picFilePath:image picFileName:guid];
    
    
    //    }
    //    @catch (NSException *exception) {
    //    }
}
//未修改
+(void)newupload2:(UIImage *)image
             GUID:(NSString *)guid type:(NSString *)typeValue url:(NSString *)houzhui{
    //    @try {
    NSMutableDictionary * dir=[NSMutableDictionary dictionaryWithCapacity:2];
    
    
    
//    [dir setValue:UserId_New forKey:@"phonenumber"];
    
    [dir setValue:guid  forKey:@"photoname"];
    
    NSString *url=[NSString stringWithFormat: @"http://121.42.156.151:8091/upload_image/%@",houzhui ] ;
    
    
    [RequestPostUploadHelper postRequestWithURL:url postParems:dir picFilePath:image picFileName:guid];
    
    
    //    }
    //    @catch (NSException *exception) {
    //    }
}
//+(void)upload_touxiang:(NSString*)type
//GUID:(NSString *)guid{
//    @try {
//        NSString *soapMessage = [NSString stringWithFormat:
//                                 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
//                                 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
//                                 "<soap:Body>\n"
//                                 "<Personal_Edit xmlns=\"http://tempuri.org/\">\n"
//                                 "<userid>%@</userid>\n"
//                                 "<password>%@</password>\n"
//                                 "<type>%@</type>\n"
//                                 "<newContent>%@</newContent>\n"
//                                 "</Personal_Edit>\n"
//                                 "</soap:Body>\n"
//                                 "</soap:Envelope>\n", [Sqldata getsqldata_user:@"user_id"],[Sqldata getsqldata_user:@"password"],@"5",[guid stringByAppendingString:@".jpg"]];
//        //请求发送到的路径
//        NSString *url = [[Sqldata getsqldata_user:@"address"] stringByAppendingString:@"/WebService/LouPanService.asmx"];
//        NSString *soapActionURL = @"http://tempuri.org/Personal_Edit";
//        NetWebServiceRequest *request = [NetWebServiceRequest serviceRequestUrl:url SOAPActionURL:soapActionURL ServiceMethodName:@"getMobileCodeInfo" SoapMessage:soapMessage];
//        [request startAsynchronous];
//        [NSThread sleepForTimeInterval:0.1];
//    }
//    @catch (NSException *exception) {
//    }
//}
@end
