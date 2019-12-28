//
//  CXUtils.m
//  GlobeVisa
//
//  Created by 盟仕乐 on 2017/4/11.
//  Copyright © 2017年 MSLiOS. All rights reserved.
//

#import "CXUtils.h"

#import <CoreText/CoreText.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "UIColor+JXAdd.h"

@interface CXUtils ()<CLLocationManagerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/** 验证码计时器 */
@property (nonatomic, strong) NSTimer *markCodeTime;

/** 定位 */
@property (nonatomic, strong) CLLocationManager *locationManager;

/** 定位block */
@property (nonatomic, copy) LocationBlock cityNameBlock;

@end

@implementation CXUtils

+ (id)shareCXUtils {
    
    static CXUtils *utils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        utils = [[CXUtils alloc] init];
    });
    return utils;
}

//计算某个时间后的日期
+ (NSDate *)datewithEndDay:(NSString *)dayNUm withStartDate:(NSDate *)startDate {

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:startDate];
    NSDateComponents* adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    int intString = [dayNUm intValue];
    [adcomps setDay:intString];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:startDate options:0];

    return newdate;
}

+ (NSInteger)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [gregorian setFirstWeekday:2];
    
    //去掉时分秒信息
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:serverDate];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    
    return dayComponents.day;
}

//计算两个日期之间的天数
+ (NSInteger)daysFromBeginDate:(NSDate *)beginDate endDate:(NSString *)endDate {
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *end = [dateFormatter dateFromString:endDate];

    NSTimeInterval time=[end timeIntervalSinceDate:beginDate];
    
    return ((int)time)/(3600*24);
}

// 文本两端对齐
+ (void)changeAlignmentRightandLeft:(UILabel *)label {
    
    CGRect textSize = [label.text boundingRectWithSize:CGSizeMake(label.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : label.font} context:nil];
    
    CGFloat margin = (label.frame.size.width - textSize.size.width) / (label.text.length - 1);
    
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:label.text];
    [attributeString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, label.text.length - 1)];
    label.attributedText = attributeString;
}

// 输入框提示文本
+ (void)changePlaceHolder:(UITextField *)textfield withText:(NSString *)placeholder{

    NSAttributedString *placeAtt = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName:Font(13)}];
    textfield.attributedPlaceholder = placeAtt;
}

/// 颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color {
   
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//手机号验证
+ (BOOL)checkTelNumber:(NSString *)telNumber {
    
    NSString *pattern = @"^1+[34578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

//邮箱验证
+ (BOOL)checkEmail:(NSString *)email {
    
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:email];
    return isMatch;
}

//日期验证
+ (int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay {
    
    //0 时间一样  1.后来的时间大  -1 前面时间小
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateA = [dateFormatter dateFromString:oneDay];
    NSDate *dateB = [dateFormatter dateFromString:anotherDay];
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedAscending) {
        return 1;   // a > b
    }
    else if (result == NSOrderedDescending){
        return -1; // a < b
    }
    return 0;
}

//判断是否为纯数字
+ (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

+ (BOOL)isMoney:(NSString *)money {
    
    NSString *reg = @"^(([1-9][0-9]*)|(([0]\\.\\d{1,2}|[1-9][0-9]*\\.\\d{1,2})))$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [pred evaluateWithObject:money];
}

#pragma mark - - - - - - - - - - - - -   弹窗 样式 - - - - - - - - - - - - - - -

/**
 提示框 取消 确定 同时存在
 
 @param titler  标题
 @param message 提示信息
 @param cancel  取消按钮文字  默认为 “取消”
 @param sure    确定按钮文字  默认为 “确定”
 @param cancelBlock  取消回调
 @param successBlock 确认回调
 @param completion   弹窗之后 回调
 */
+ (void)showAlertDouble:(NSString *)titler withMessage:(NSString *)message withCancelText:(NSString *)cancel withSuccessText:(NSString *)sure withVC:(UIViewController *)vc withCancelBlock:(void(^)(void))cancelBlock withSuccessBlock:(void(^)(void))successBlock withCompletion:(void(^)(void))completion {
    
    if (cancel == nil) {  cancel = @"取消";  }
    if (sure   == nil) {  sure   = @"确定";  }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titler message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sure style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        successBlock();
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:sureAction];
    [vc presentViewController:alert animated:YES completion:^{  }];
}

/**
 提示框 只有确定按钮
 
 @param titler  标题
 @param message 提示信息
 @param sure    确定按钮文字  默认为 “确定”
 @param successBlock 确认回调
 @param completion   弹窗之后 回调
 */
+ (void)showAlertSigle:(NSString *)titler withMessage:(NSString *)message withSuccessText:(NSString *)sure withVC:(UIViewController *)vc withSuccessBlock:(void(^)(void))successBlock withCompletion:(void(^)(void))completion {
    
    if (sure   == nil) {  sure   = @"确定";  }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titler message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sure style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        successBlock();
    }];
    [alert addAction:sureAction];
    [vc presentViewController:alert animated:YES completion:^{ completion(); }];
}


#pragma mark - - - - - - - - - - - - -   相机相册 权限 - - - - - - - - - - - - - - -

//da
+ (BOOL)openLocationPhoto:(UIViewController *)vc {
   
    CXUtils *utils = [CXUtils shareCXUtils];

    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; // 内容类型
    picker.delegate = utils; // 设置代理
    picker.allowsEditing = YES; // 是否可以编辑
    [vc presentViewController:picker animated:YES completion:nil]; // 跳到相册
    
    return YES;
    
    if ([CXUtils checkPhotoAuthen:vc]) {
        
       
    }
    
    return  NO;
}

+ (BOOL)openCamera:(UIViewController *)vc {
    [CXUtils checkCameraAnthen:vc];
    CXUtils *utils = [CXUtils shareCXUtils];
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = utils;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [vc presentViewController:picker animated:YES completion:nil];
    
    return YES;
}

/**
 相册权限
 */
+ (BOOL)checkPhotoAuthen:(UIViewController *)vc {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    // [CXUtils showPhotoAlert:vc]; break;
    switch (status) {
        case PHAuthorizationStatusDenied:
        case PHAuthorizationStatusNotDetermined:
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusAuthorized: return YES;
        default:  break;
    }
    return NO;
}

/**
 *  点击相册的取消按钮
 *
 *  @param picker 相册
 */
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  选择图片后
 *
 *  @param picker 相册
 *  @param info 图片信息
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    // 获取文件类型
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断是不是图片
    if ([type isEqualToString:@"public.image"]) {
        
        UIImage *OriginaImage = info[@"UIImagePickerControllerOriginalImage"];
        
        UIImage *EditedImage = info[@"UIImagePickerControllerEditedImage"];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectPhoto:withOriImg:)]) {
            
            [self.delegate selectPhoto:EditedImage withOriImg:OriginaImage];
        }

        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}



#pragma mark - - - - - - - - - - - - -   相机权限 - - - - - - - - - - - - - - -

/**
 调用摄像头
 */
+ (BOOL)checkCameraAnthen:(UIViewController *)vc {

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [CXUtils showAlertSigle:nil withMessage:@"由于您的设备暂不支持摄像头，您无法使用该功能!" withSuccessText:nil withVC:vc withSuccessBlock:nil withCompletion:nil];
        return NO;
    }
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        
        [CXUtils showCameraAlert:vc];
       
        return NO;
    }
    
    return YES;
}

#pragma mark - - - - - - - - - - - - -   相册 相机权限提示 - - - - - - - - - - - - - - -

/**
 修改相册权限提示
 */
+ (void)showPhotoAlert:(UIViewController *)vc {
    
    [CXUtils showAlertDouble:nil withMessage:@"您还没有开启相册权限，请到设置->隐私中开启本程序相册权限" withCancelText:nil withSuccessText:@"去设置" withVC:vc
             withCancelBlock:nil withSuccessBlock:^{
                 NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                 
                 if([[UIApplication sharedApplication] canOpenURL:url]) {
                     
                     NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                     
                     [[UIApplication sharedApplication] openURL:url];
                 }
                 
             } withCompletion:nil];
    
}

/**
 修改相机权限提示
 */
+ (void)showCameraAlert:(UIViewController *)vc  {
    
    [CXUtils showAlertDouble:nil withMessage:@"对不起，您没有开启调用相机权限，是否前往 设置-隐私-相机 中设置" withCancelText:nil withSuccessText:@"去设置" withVC:vc withCancelBlock:nil withSuccessBlock:^{
        
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            [[UIApplication sharedApplication] openURL:url];
        }
        
    } withCompletion:nil];
}


#pragma mark - - - - - - - - - - - - -   相机相册END - - - - - - - - - - - - - - -

+ (UIImage *)resizeUIImage:(UIImage *)image towidth:(CGFloat)width height:(CGFloat)height{
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [image drawInRect:CGRectMake(0.0f, 0.0f, width, height)];
    UIImage *newImage =[[UIImage alloc]init];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 获取当前时间

 @return 当前时间
 */
+ (NSString *)getCurrentDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}


/**
 文件保存路径

 @return 用户数据保存路径
 */
+ (NSString *)fileNameWithLocationData {
    
//    NSString *userNum  = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NUM];
//    NSString *userTel = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TEL];
//    NSString *fileName = [NSString stringWithFormat:@"%@_%@",userTel,userID];
//    return userNum;
    return @"";
}

#pragma mark - - - - - - - - - - - - -   定位 - - - - - - - - - - - - - - -

-(void)startLocation {
    
    if ([CLLocationManager locationServicesEnabled]) {
       _locationManager = [[CLLocationManager alloc]init];
        
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locationManager.distanceFilter = 100.0f;
        _locationManager.delegate = self;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>8.0) {
        
            [_locationManager requestWhenInUseAuthorization];
        }
        
        [_locationManager startUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    [_locationManager stopUpdatingLocation];
    
    CLGeocoder * geoCoder =[[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:manager.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary * test = [placemark addressDictionary];
            NSMutableString *state ;
            NSMutableString *city = [[NSMutableString alloc] initWithString:[test objectForKey:@"City"]];   // 青岛市
            
            if ([[test allKeys] containsObject:@"State"]) {
//                state = [[NSMutableString alloc] initWithString:[test objectForKey:@"State"]];// 山东省
                
            }else {
                
//                state = [[NSMutableString alloc] initWithString:city]; // 山东省
                
            }
            NSMutableString *subLoca = [[NSMutableString alloc] initWithString:[test objectForKey:@"SubLocality"]]; //  黄岛区
            NSMutableString *name = [[NSMutableString alloc] initWithString:[test objectForKey:@"Name"]];
            
            NSNumber *latNum = [NSNumber numberWithDouble:placemark.location.coordinate.latitude];
            NSNumber *lonNum = [NSNumber numberWithDouble:placemark.location.coordinate.longitude];
            [[NSUserDefaults standardUserDefaults] setObject:[latNum stringValue] forKey:@"locationLat"];
            [[NSUserDefaults standardUserDefaults] setObject:[lonNum stringValue] forKey:@"locationLon"];
                    
            if (self.cityNameBlock) {
                self.cityNameBlock(subLoca,name,test,placemark.location.coordinate);
                self.latitude = placemark.location.coordinate.latitude;
                self.longitude = placemark.location.coordinate.longitude;
            }
        }
    }];
}

- (void)getCityName:(LocationBlock)cityInfo {
    
    _cityNameBlock = cityInfo;
}

#pragma mark - - - - - - - - - - - - -   数据库存储 - - - - - - - - - - - - - - -
//根据存储的信息转为对应的变量类型
+ (id)getIDVariableValueTypesWithString:(NSString *)string
{
    NSString *idValueType = [[string componentsSeparatedByString:@":"] lastObject];
    NSString *idValue = [string stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@":%@",idValueType] withString:@""];
    
    if ([idValueType isEqualToString:@"NSNumber"]) {
        return [NSNumber numberWithInteger:[idValue integerValue]];
    } else if ([idValueType isEqualToString:@"NSNumberChar"]) {
        return [NSNumber numberWithChar:[idValue intValue]];
    } else if ([idValueType isEqualToString:@"NSNumberFloat"]) {
        return [NSNumber numberWithFloat:[idValue floatValue]];
    } else if ([idValueType isEqualToString:@"NSNumberDouble"]) {
        return [NSNumber numberWithDouble:[idValue doubleValue]];
    } else if ([idValueType isEqualToString:@"NSNumberShort"]) {
        return [NSNumber numberWithShort:[idValue intValue]];
    } else if ([idValueType isEqualToString:@"NSNumberInt"]) {
        return [NSNumber numberWithInt:[idValue doubleValue]];
    } else if ([idValueType isEqualToString:@"NSNumberLong"]) {
        return [NSNumber numberWithLong:[idValue floatValue]];
    } else if ([idValueType isEqualToString:@"NSNumberLongLong"]) {
        return [NSNumber numberWithLongLong:[idValue longLongValue]];
    } else if ([idValueType isEqualToString:@"NSNumberNSInteger"]) {
        return [NSNumber numberWithInteger:[idValue integerValue]];
    } else if ([idValueType isEqualToString:@"NSNumberNSUInteger"]) {
        return [NSNumber numberWithUnsignedInteger:[idValue integerValue]];
    } else if ([idValueType isEqualToString:@"NSNumberBOOL"]) {
        return [NSNumber numberWithBool:[idValue boolValue]];
    } else if ([idValueType isEqualToString:@"UIView"]) {
        return NSClassFromString(idValue);
    } else if ([idValueType isEqualToString:@"NSString"]) {
        return idValue;
    }
    return @"";
}
//根据id变量类型转化为对应string以供存储
+ (NSString *)setIDVariableToString:(id)varialeValue
{
    //NSString类型
    if ([varialeValue isKindOfClass:[NSString class]]) {
        return varialeValue?[NSString stringWithFormat:@"%@:NSString",varialeValue]:@"";
    }
    //BOOL类型
    else if ([[NSString stringWithFormat:@"%@",[varialeValue class]] isEqualToString:@"__NSCFBoolean"]) {
        return varialeValue?[NSString stringWithFormat:@"%@:NSNumberBOOL",varialeValue]:@"";
    }
    //NSSNumber类型
    else if ([varialeValue isKindOfClass:[NSNumber class]]) {
        
        NSString *memberValueType = @":NSNumber";
        
        if (strcmp([varialeValue objCType], @encode(char)) == 0 ||
            strcmp([varialeValue objCType], @encode(unsigned char)) == 0) {
            memberValueType = @":NSNumberChar";
        } else if (strcmp([varialeValue objCType], @encode(short)) == 0 ||
                   strcmp([varialeValue objCType], @encode(unsigned short)) == 0) {
            memberValueType = @":NSNumberShort";
        } else if (strcmp([varialeValue objCType], @encode(int)) == 0 ||
                   strcmp([varialeValue objCType], @encode(unsigned int)) == 0) {
            memberValueType = @":NSNumberInt";
        } else if (strcmp([varialeValue objCType], @encode(long)) == 0 ||
                   strcmp([varialeValue objCType], @encode(unsigned long)) == 0) {
            memberValueType = @":NSNumberLong";
        } else if (strcmp([varialeValue objCType], @encode(long long)) == 0 ||
                   strcmp([varialeValue objCType], @encode(unsigned long long)) == 0) {
            memberValueType = @":NSNumberLongLong";
        } else if (strcmp([varialeValue objCType], @encode(float)) == 0) {
            memberValueType = @":NSNumberFloat";
        } else if (strcmp([varialeValue objCType], @encode(double)) == 0) {
            memberValueType = @":NSNumberDouble";
        } else if (strcmp([varialeValue objCType], @encode(NSInteger)) == 0) {
            memberValueType = @":NSNumberNSInteger";
        } else if (strcmp([varialeValue objCType], @encode(NSUInteger)) == 0) {
            memberValueType = @":NSNumberNSUInteger";
        }
        
        return varialeValue?[NSString stringWithFormat:@"%@%@",varialeValue,memberValueType]:@"";
    }
    //UIView类型
    else if ([[varialeValue class] isSubclassOfClass:[UIView class]] || [[varialeValue class] isKindOfClass:[UIView class]]) {
        return varialeValue?[NSString stringWithFormat:@"%@:UIView",varialeValue]:@"";
    }
    
    return varialeValue?[NSString stringWithFormat:@"%@:id",varialeValue]:@"";
}

//json转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//字典转json
+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


#pragma mark - - - - - - - - - - - - -   创建项目中所需要的文件夹 - - - - - - - - - - - - - - -
// 创建文件
- (void)createSysFile {
//
//    NSString *userPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",USER_NUM]];
//
//    NSString *chatRecode = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/chatRecode",USER_NUM]];
//
//    NSArray *fileArr = @[userPath,chatRecode];
//
//    for (NSString *path in fileArr) {
//
//        [self createFile:path];
//    }
}

- (void)createFile:(NSString *)path {
    
    NSFileManager *manager = [[NSFileManager alloc] init];
    BOOL isHave = [manager fileExistsAtPath:path isDirectory:nil];
    
    if (!isHave) {
        BOOL res=[manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (!res) {
//            MyLog(@"创建用户文件夹失败")
        }
    }
}


#pragma mark - - - - - - - - - - - - -   时间转换 - - - - - - - - - - - - - - -
//时间显示内容
+ (NSString *)getMessageListDateDisplayString:(long long) mliSeconds {
    
    NSTimeInterval seconds = mliSeconds;
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[ NSDate date ]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:myDate];
    
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init ];
    
    //2. 指定日历对象,要去取日期对象的那些部分.
    NSDateComponents *comp =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:myDate];
    
    if (nowCmps.year != myCmps.year) {
        dateFmt.dateFormat = @"yyyy-MM-dd hh:mm";
    } else {
        if (nowCmps.day==myCmps.day) {
            dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
            dateFmt.dateFormat = @"aaa hh:mm";
            
        } else if((nowCmps.day-myCmps.day)==1) {
            dateFmt.dateFormat = @"昨天";
        } else {
            if ((nowCmps.day-myCmps.day) <=7) {
                switch (comp.weekday) {
                    case 1:
                        dateFmt.dateFormat = @"星期日";
                        break;
                    case 2:
                        dateFmt.dateFormat = @"星期一";
                        break;
                    case 3:
                        dateFmt.dateFormat = @"星期二";
                        break;
                    case 4:
                        dateFmt.dateFormat = @"星期三";
                        break;
                    case 5:
                        dateFmt.dateFormat = @"星期四";
                        break;
                    case 6:
                        dateFmt.dateFormat = @"星期五";
                        break;
                    case 7:
                        dateFmt.dateFormat = @"星期六";
                        break;
                    default:
                        break;
                }
            }else {
                dateFmt.dateFormat = @"MM-dd hh:mm";
            }
        }
    }
    return [dateFmt stringFromDate:myDate];
}

//时间显示内容
+ (NSString *)getChatListDateDisplayString:(long long) miliSeconds{
    
    NSTimeInterval seconds = miliSeconds;
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[ NSDate date ]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:myDate];
    
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init ];
    
    //2. 指定日历对象,要去取日期对象的那些部分.
    NSDateComponents *comp =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:myDate];
    
    if (nowCmps.year != myCmps.year) {
        dateFmt.dateFormat = @"yyyy-MM-dd hh:mm";
    } else {
        if (nowCmps.day==myCmps.day) {
            dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
            dateFmt.dateFormat = @"aaa hh:mm";
            
        } else if((nowCmps.day-myCmps.day)==1) {
            dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
            dateFmt.dateFormat = @"昨天 aaahh:mm";
            
        } else {
            if ((nowCmps.day-myCmps.day) <=7) {
                
                dateFmt.AMSymbol = @"上午";
                dateFmt.PMSymbol = @"下午";
                
                switch (comp.weekday) {
                    case 1:
                        dateFmt.dateFormat = @"星期日 aaahh:mm";
                        break;
                    case 2:
                        dateFmt.dateFormat = @"星期一 aaahh:mm";
                        break;
                    case 3:
                        dateFmt.dateFormat = @"星期二 aaahh:mm";
                        break;
                    case 4:
                        dateFmt.dateFormat = @"星期三 aaahh:mm";
                        break;
                    case 5:
                        dateFmt.dateFormat = @"星期四 aaahh:mm";
                        break;
                    case 6:
                        dateFmt.dateFormat = @"星期五 aaahh:mm";
                        break;
                    case 7:
                        dateFmt.dateFormat = @"星期六 aaahh:mm";
                        break;
                    default:
                        break;
                }
            }else {
                dateFmt.dateFormat = @"MM-dd hh:mm";
            }
        }
    }
    return [dateFmt stringFromDate:myDate];
}

// 返回用户m默认头像
+ (UIImage *)userLogoDefaImage {
    
    int i = arc4random()%6;
    NSString *name = [[NSString alloc] initWithFormat:@"2%d.jpg",i];
    return [UIImage imageNamed:name];
}

/**
 将GBK 格式的 数据流 转换为 需要的数据
 
 @param responseObject GBK 格式的 数据流
 @return 需要的数据
 */
+ (id)changeGBKdataToUTF8:(NSData *)responseObject {
    
    //定义GBK编码格式
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //GBK格式接收数据并进行转换
    NSString * retStr = [[NSString alloc]initWithData:responseObject encoding:enc];
    
    NSData * jsonData = [retStr dataUsingEncoding:enc];
    
    NSString * jsonStr = [[NSString alloc]initWithData:jsonData encoding:enc];
    //将数据转为UTF-8
    NSData * data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    //解析
    NSDictionary * dicJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return dicJson;
}


/**
 银行卡 认证

 @param cardNumber 银行卡
 @return 是否是否正确
 */
+ (BOOL) IsBankCard:(NSString *)cardNumber {
    
    if(cardNumber.length==0)
    {
        return NO;
    }
    
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

/**
 身份证 检测

 @param userID  身份证号
 @return 是否有有效
 */
+ (BOOL)checkUserID:(NSString *)userID {
    
    //长度不为18的都排除掉
    if (userID.length!=18) { return NO; }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}
// 在图片上画文字   文字转换成图片
- (UIImage *)createShareImage:(NSString *)imageName Context:(NSString *)text
{
    UIImage *sourceImage = [UIImage imageNamed:imageName];
    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextDrawPath(context, kCGPathStroke);
    
    /* - - - - - - - - - - - - - - - - - - - - -
     // 将备注打开就是  文字转图片
     //    CGRect rect=CGRectMake(0, 0, imageSize.width, imageSize.height);
     //    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
     //    CGContextRef ref=UIGraphicsGetCurrentContext();
     //    CGContextSetFillColorWithColor(ref, [UIColor grayColor].CGColor);
     //    CGContextFillRect(ref, rect);
     - - - - - - - - - - - - - - - - - - - - - */
    [text drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0f],NSForegroundColorAttributeName:[UIColor redColor]}];
    UIImage * newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


/**
 文字转图片

 @param size 图片大小
 @param bgColor 背景颜色
 @param context 文字
 @param font 文字大小
 @param textColor 文字y颜色
 @return 图片
 */
+ (UIImage *)createTextImg:(CGSize)size backColor:(UIColor *)bgColor withText:(NSString *)context withTextFont:(UIFont *)font withTextColor:(UIColor *)textColor {
    
    CGRect rect=CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGContextRef ref=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ref, bgColor.CGColor);
    CGContextFillRect(ref, rect);
    
    
    CGSize textSize = [context sizeWithAttributes:@{NSFontAttributeName:font}];
    [context drawInRect:CGRectMake((size.width - textSize.width)/2, (size.height - textSize.height)/2, textSize.width, textSize.height) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor}];
    UIImage * newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/// 将16进制颜色转换为UICOLOR
/// @param color 16进制颜色
+ (UIColor *) colorWithHexString: (NSString *)color {
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

/**
 切圆角

 @param view 视图
 @param size 圆角大小
 @param corners 圆角的位置
 @return layer
 */
+ (CAShapeLayer *)maskRoundCornes:(UIView *)view withRadi:(CGSize)size withCorners:(UIRectCorner)corners {
    
    UIBezierPath *maskPath=[UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer*maskLayer=[[CAShapeLayer alloc]init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
    
}

/**
 计算jk距离

 @param lat1 坐标1 lat
 @param lat2 坐标2 lat
 @param lng1 坐标1 lng
 @param lng2 坐标2 lng
 @return   k距离
 */
+ (double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2 {
    
    CLLocation *curLocation = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    
    double  distance  = [curLocation distanceFromLocation:otherLocation];
    
    return  distance;
    
}

#pragma mark - - - - - - - - - - - - -  价格计算 - - - - - - - - - - - - - - -
/** 将  分  换算为 元    */
+ (NSString *)changeRMBUnitFTY:(NSString *)price {
    
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *priceDec = [NSDecimalNumber decimalNumberWithString:price];
    NSDecimalNumber *rateDec = [NSDecimalNumber decimalNumberWithString:@"100"];
    NSDecimalNumber *endPrice = [priceDec decimalNumberByDividingBy:rateDec withBehavior:roundUp];
    
    if ([endPrice isEqualToNumber:NSDecimalNumber.notANumber]) {
        
        endPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    return [NSString stringWithFormat:@"%@",endPrice];
}

/**
将 元 换算 为 分

 @param oriRMB 传入的人民币金额    单位  元
 @return       返回的r人民币金额   单位  分
 */
+ (NSString *)changeRMBUnitYTF:(NSString *)oriRMB {
    
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *oriRMBDec = [NSDecimalNumber decimalNumberWithString:oriRMB];
    NSDecimalNumber *rateDec = [NSDecimalNumber decimalNumberWithString:@"100"];
    
    NSDecimalNumber *priceNum = [oriRMBDec decimalNumberByMultiplyingBy:rateDec withBehavior:roundUp];
    return [NSString stringWithFormat:@"%@",priceNum];
}

// 乘法
+ (NSDecimalNumber *)decimalNumber:(NSDecimalNumber *)oneDec ByMultiplyingBy:(NSDecimalNumber *)twoDec {
    
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *priceNum = [oneDec decimalNumberByMultiplyingBy:twoDec withBehavior:roundUp];
    
    return priceNum;
}
// c除法
+ (NSDecimalNumber *)decimalNumber:(NSDecimalNumber *)oneDec ByDividingBy:(NSDecimalNumber *)twoDec {
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *priceNum = [oneDec decimalNumberByDividingBy:twoDec withBehavior:roundUp];
    
    return priceNum;
    
}
/**
 加法

 @param onePrice 金额1
 @param towPrice 金额2
 @return 总金额
 */
+ (NSString *)decimalAddPrice:(NSString *)onePrice withSecondprice:(NSString *)towPrice {
    
    NSDecimalNumber *onePriceDec = [NSDecimalNumber decimalNumberWithString:onePrice];
    NSDecimalNumber *twoPriceDec = [NSDecimalNumber decimalNumberWithString:towPrice];
    
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *allPrice = [onePriceDec decimalNumberByAdding:twoPriceDec withBehavior:roundUp];
    return [NSString stringWithFormat:@"%@",allPrice];
}

/**
 *减法
 * @param onePrice 减数
 * @param towPrice 被减数
 * @return 总金额
 */
+ (NSString *)decimalSubPrice:(NSString *)onePrice withSecondprice:(NSString *)towPrice {
    
    NSDecimalNumber *onePriceDec = [NSDecimalNumber decimalNumberWithString:onePrice];
    NSDecimalNumber *twoPriceDec = [NSDecimalNumber decimalNumberWithString:towPrice];
    
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *allPrice = [onePriceDec decimalNumberBySubtracting:twoPriceDec withBehavior:roundUp];
    
    return [NSString stringWithFormat:@"%@",allPrice];
}



/**
 获取html中的imgURL
 
 @param webString html
 @return imgURL 的数组
 */
+ (NSArray *)getImageurlFromHtml:(NSString *)webString {
    
    NSMutableArray * imageurlArray = [NSMutableArray arrayWithCapacity:1];
    
    //标签匹配
    
    NSString *parten = @"<img(.*?)>";
    
    NSError* error = NULL;
    
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:0 error:&error];
    
    NSArray* match = [reg matchesInString:webString options:0 range:NSMakeRange(0, [webString length] - 1)];
    if (match.count==0) {
        return nil;
    }
    for (NSTextCheckingResult * result in match) {
        
        //获取数组中的标签
        NSRange range = [result range];
        
        NSString * subString = [webString substringWithRange:range];
        
        //从图片中的标签中提取ImageURL
        
        NSRegularExpression *subReg = [NSRegularExpression regularExpressionWithPattern:@"http://(.*?)\"" options:0 error:NULL];
        
        NSArray* match = [subReg matchesInString:subString options:0 range:NSMakeRange(0, [subString length] - 1)];
        
        NSTextCheckingResult * subRes = match[0];
        
        NSRange subRange = [subRes range];
        
        subRange.length = subRange.length -1;
        
        NSString * imagekUrl = [subString substringWithRange:subRange];
        
        //将提取出的图片URL添加到图片数组中
        
        [imageurlArray addObject:imagekUrl];
        
    }
    
    return imageurlArray;
    
}

/** 阿拉伯数字转汉子数字 */
+(NSString *)translationArabicNum:(NSInteger)arabicNum {
    
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            
            [sums addObject:sum];
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}
// 拨打电话
+ (void)phoneAction:(UIViewController *)viewController withTel:(NSString *)tel {
    
    NSString *telString= [NSString stringWithFormat:@"tel:%@",tel];
    
    UIWebView *callWebView = [[UIWebView alloc] init];
    
    NSURL *telURL = [NSURL URLWithString:telString];
    
    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    
    [viewController.view addSubview:callWebView];
    
}

// 输入金额规范
+ (NSString *)checkInputMoney:(NSString *)money{
    
    if ([CXUtils isMoney:money]) {
        
        return money;
    }
    
    if ([money hasPrefix:@"."]) { return money = @"0."; }
    
    NSArray *arr = [money componentsSeparatedByString:@"."];
    if (arr.count >= 3) {
        return [money substringToIndex:money.length - 1];
    }
    
    NSString *last = [money substringWithRange:NSMakeRange(money.length - 1, 1)];

    if ([last isEqualToString:@"."]) {
        return money;
    }
    
    if (![CXUtils haveValue:money]) {
        return @"";
    }
    if ([money isEqualToString:@"0"]) {
        return money;
    }
    //TODO: 金额较大处理
   return  [money substringToIndex:money.length - 1];
}
// 输入的数字规范
+ (NSString *)checkInputNum:(NSString *)member {
    
    if (![CXUtils haveValue:member]) { return @""; }
    
    return [CXUtils isNum:member] ? member : [member substringToIndex:member.length - 1];
}


+ (CGFloat)interpolationFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent
{
    percent = MAX(0, MIN(1, percent));
    return from + (to - from)*percent;
}

//获取渐变颜色
+ (UIColor *)interpolationColorFrom:(UIColor *)fromColor to:(UIColor *)toColor percent:(CGFloat)percent
{
    CGFloat red = [self interpolationFrom:fromColor.jx_red to:toColor.jx_red percent:percent];
    CGFloat green = [self interpolationFrom:fromColor.jx_green to:toColor.jx_green percent:percent];
    CGFloat blue = [self interpolationFrom:fromColor.jx_blue to:toColor.jx_blue percent:percent];
    CGFloat alpha = [self interpolationFrom:fromColor.jx_alpha to:toColor.jx_alpha percent:percent];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

// 获取图片的主体颜色
-(UIColor *)mainColorOfImage:(UIImage *)image{

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1

    int bitmapInfo =kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;

#else

    int bitmapInfo = kCGImageAlphaPremultipliedLast;

#endif

    //第一步：先把图片缩小，加快计算速度，但越小结果误差可能越大

    CGSize thumbSize=CGSizeMake(50,50);

    CGColorSpaceRef colorSpace =CGColorSpaceCreateDeviceRGB();

    CGContextRef context =CGBitmapContextCreate(NULL,thumbSize.width,thumbSize.height,8,//bits per component
thumbSize.width*4,colorSpace,bitmapInfo);

    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);

    CGContextDrawImage(context, drawRect, image.CGImage);

    CGColorSpaceRelease(colorSpace);

    //第二步：取每个点的像素值

    unsigned char* data =CGBitmapContextGetData (context);

        if (data == NULL)return nil;

    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];

    for (int x=0; x<thumbSize.width; x++) {

        for (int y=0; y<thumbSize.height; y++) {

            int offset = 4*(x*y);

            int red = data[offset];

            int green = data[offset+1];

            int blue = data[offset+2];

            int alpha = data[offset+3];



            NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];

            [cls addObject:clr];

        }

    }

    CGContextRelease(context);

    //第三步：找到出现次数最多的那个颜色

    NSEnumerator *enumerator = [cls objectEnumerator];

    NSArray *curColor = nil;

    NSArray *MaxColor=nil;

    NSUInteger MaxCount=0;

    while ( (curColor = [enumerator nextObject]) != nil ){

        NSUInteger tmpCount = [cls countForObject:curColor];

        if (tmpCount < MaxCount) continue;

        MaxCount=tmpCount;

        MaxColor=curColor;

    }

    return [UIColor colorWithRed:([MaxColor[0]intValue]/255.0f)green:([MaxColor[1]intValue]/255.0f)blue:([MaxColor[2]intValue]/255.0f)alpha:([MaxColor[3]intValue]/255.0f)];

}

+(BOOL)haveValue:(id)value
{
   
    if ([value isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if (value==nil||value==[NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSString *string= [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (string.length==0) {
            return NO;
        }
    }
    return YES;
}

+ (CAGradientLayer *)gradientLayerWithFrame:(CGRect)rect withColors:(NSArray *)colors withStartPoint:(CGPoint)startPoint withEndPoint:(CGPoint)endPoint withLocations:(NSArray *)locations {
    
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = rect;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.locations = locations;//渐变点
    [gradientLayer setColors:colors];//渐变数组
    return gradientLayer;
}
@end
