//
//  YPInviteFriendsWedNormalController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/15.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPInviteFriendsWedNormalController.h"
#import "YPHunJJSponsorImgCell.h"
#import "YPInviteFriendsWedInputCell.h"
#import "YPInviteFriendsWedPhoneInputCell.h"//18-11-12 改手机号
#import "YPInviteFriendsWedNormalThreeBtnCell.h"
#import "YPInviteFriendsWedShouYiCell.h"
#import "YPInviteFriendsWedNormalRecordController.h"//邀请记录
#import "YPInviteFriendsWedNormalSucController.h"//提交成功
#import "YPInviteFriendsWedOpenVIPController.h"//开通VIP
#import "YPInviteFriendsWedNormalFace2FaceController.h"//面对面邀请扫码
#import "YPInviteFriendsWedNormalShareView.h"

#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"
#import "BRDatePickerView.h"
#import "CJAreaPicker.h"//地址选择
#import <ASGradientLabel.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

@interface YPInviteFriendsWedNormalController ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic, strong) UIControl *control;

/**新人姓名*/
@property (nonatomic, strong) UITextField *nameTF;
/**新人手机*/
@property (nonatomic, strong) UITextField *phoneTF;
/**新人婚期*/
@property (nonatomic, copy) NSString *dateStr;
/***********************************地址选择*****************************************/
/**经纬度坐标*/
@property (strong, nonatomic) NSString *coordinates;
/**缓存城市*/
@property (strong, nonatomic) NSString *cityInfo;
/**缓存城市parentid*/
@property (assign, nonatomic) NSInteger parentID;
/**地区ID*/
@property (strong, nonatomic) NSString *areaid;
/***********************************地址选择*****************************************/
 
@end

@implementation YPInviteFriendsWedNormalController{
    UIView *_navView;
    //数据库
    FMDatabase *dataBase;
    YPInviteFriendsWedNormalShareView *_shareView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    [self GetWeChatActivityList];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    [self setupUI];
    [self setupNav];
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -STATUS_BAR_HEIGHT, ScreenWidth, ScreenHeight+STATUS_BAR_HEIGHT) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
}

- (void)setupNav{
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    backBtn.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    backBtn.layer.cornerRadius = 16;
    backBtn.clipsToBounds = YES;
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.left.mas_equalTo(_navView.mas_left).mas_offset(10);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UIButton *recordBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [recordBtn setTitle:@"邀请记录" forState:UIControlStateNormal];
    [recordBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    recordBtn.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    recordBtn.layer.cornerRadius = 16;
    recordBtn.clipsToBounds = YES;
    [recordBtn addTarget:self action:@selector(recordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:recordBtn];
    [recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(88, 32));
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.profitModel.EndBanner.length == 0) {
        return 8;
    }else{
        NSArray *arr = [self.profitModel.EndBanner componentsSeparatedByString:@","];
        return 8+arr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        YPHunJJSponsorImgCell *cell = [YPHunJJSponsorImgCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *str = self.profitModel.TopBanner;

        cell.imgStr = str;
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str]  placeholderImage:[UIImage imageNamed:@"图片占位"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            /**
             *  缓存image size
             */
            [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                
                //reload row
                if(result && (self.isViewLoaded && self.view.window))  {
                    
                    [tableView  xh_reloadRowAtIndexPath:indexPath forURL:imageURL];
                }else{
                    
                }
                
            }];
        }];
        
        return cell;
    }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
        
        YPInviteFriendsWedInputCell *cell = [YPInviteFriendsWedInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 1) {
            YPInviteFriendsWedPhoneInputCell *cell = [YPInviteFriendsWedPhoneInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"新人姓名";
            cell.inputTF.placeholder = @"请输入新人姓名";
            cell.inputTF.keyboardType = UIKeyboardTypeDefault;
            cell.inputTF.enabled = YES;
            self.nameTF = cell.inputTF;
            [cell.addressBook addTarget:self action:@selector(addressBookClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
        }else if (indexPath.row == 2){
            
            cell.titleLabel.text = @"新人手机";
            cell.inputTF.placeholder = @"请输入新人手机";
            cell.inputTF.keyboardType = UIKeyboardTypePhonePad;
            cell.inputTF.enabled = YES;
            self.phoneTF = cell.inputTF;
            
        }else if (indexPath.row == 3){
            cell.titleLabel.text = @"新人婚期";
            cell.inputTF.placeholder = @"请输入选择新人婚期";
            cell.inputTF.enabled = NO;
            if (self.dateStr.length > 0) {
                cell.inputTF.text = self.dateStr;
            }else{
                cell.inputTF.text = @"";
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 4){
            cell.titleLabel.text = @"所在区域";
            cell.inputTF.placeholder = @"请输入选择所在区域";
            cell.inputTF.enabled = NO;
            if (self.cityInfo.length > 0) {
                cell.inputTF.text = self.cityInfo;
            }else{
                cell.inputTF.text = @"";
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }else if (indexPath.row == 5){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *submitBtn = [[UIButton alloc]init];
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [submitBtn setBackgroundImage:[self gradientImageWithBounds:CGRectMake(0, 0, ScreenWidth-36, 48) andColors:@[RGBA(255, 163, 89, 1),RGBA(255, 93, 118, 1)] andGradientType:1] forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.layer.cornerRadius = 4;
        submitBtn.clipsToBounds = YES;
        [cell.contentView addSubview:submitBtn];
        [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(12);
            make.left.mas_equalTo(18);
            make.right.mas_equalTo(-18);
            make.bottom.mas_equalTo(-12);
            make.height.mas_equalTo(48);
        }];
        return cell;
    }else if (indexPath.row == 6){
        YPInviteFriendsWedNormalThreeBtnCell *cell = [YPInviteFriendsWedNormalThreeBtnCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameArr = @[@{@"name":@"分享给好友",@"img":@"inviteFriendsWed_Share"},@{@"name":@"面对面邀请",@"img":@"inviteFriendsWed_Face2Face"},@{@"name":@"开通VIP邀请",@"img":@"inviteFriendsWed_VIP"}];
        cell.colCellClick = ^(NSString *sectionName, NSIndexPath *indexPath) {
            if (!UserId_New) {
                
                //2-11 修改 登录判断
                YPReLoginController *first = [[YPReLoginController alloc]init];
                UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
                [self presentViewController:firstNav animated:YES completion:nil];
                
            }else{
                NSLog(@"sectionName -- %@",sectionName);
                if ([sectionName isEqualToString:@"开通VIP邀请"]) {
                    YPInviteFriendsWedOpenVIPController *open = [[YPInviteFriendsWedOpenVIPController alloc]init];
                    [self.navigationController pushViewController:open animated:YES];
                }else if ([sectionName isEqualToString:@"分享给好友"]){
                    [self showShareSDKWithURL:[NSString stringWithFormat:@"http://www.chenghunji.com/Capital/BeiHun?UserId=%@",UserId_New] Title:@"送您一份新婚礼，快去成婚纪APP领取！" Text:@"婚庆、婚纱，全部花多少返多少！婚礼对戒等更多豪礼速来领！"];
                }else if ([sectionName isEqualToString:@"面对面邀请"]){
                    
                    YPInviteFriendsWedNormalFace2FaceController *code = [[YPInviteFriendsWedNormalFace2FaceController alloc]init];
                    [self.navigationController pushViewController:code animated:YES];
                    
                }
            }
        };
        return cell;
    }else if (indexPath.row == 7){
        YPInviteFriendsWedShouYiCell *cell = [YPInviteFriendsWedShouYiCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //文字渐变
        ASGradientLabel *priceLabel = [[ASGradientLabel alloc]init];
        priceLabel.text = [NSString stringWithFormat:@"%zd",self.profitModel.Money.integerValue];
        priceLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightHeavy];
        priceLabel.colors = @[(id)RGBA(255, 163, 89, 1).CGColor, (id)RGBA(255, 93, 118, 1).CGColor];
        priceLabel.startPoint = CGPointMake(0, 0);
        priceLabel.endPoint = CGPointMake(1, 0);
        priceLabel.locations = @[@0 ,@1];
        [cell.contentView addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(48);
            make.left.mas_equalTo(18);
        }];
        ASGradientLabel *rmbLabel = [[ASGradientLabel alloc]init];
        rmbLabel.text = @"¥";
        rmbLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightHeavy];
        rmbLabel.colors = @[(id)RGBA(255, 163, 89, 1).CGColor, (id)RGBA(255, 93, 118, 1).CGColor];
        rmbLabel.startPoint = CGPointMake(0, 0);
        rmbLabel.endPoint = CGPointMake(1, 0);
        rmbLabel.locations = @[@0 ,@1];
        [cell.contentView addSubview:rmbLabel];
        [rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(priceLabel);
            make.left.mas_equalTo(priceLabel.mas_right).mas_offset(3);
        }];
        [cell.showBtn addTarget:self action:@selector(showBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else {
        YPHunJJSponsorImgCell *cell = [YPHunJJSponsorImgCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *arr = [self.profitModel.EndBanner componentsSeparatedByString:@","];
        
        NSString *str = arr[indexPath.row-8];
        
        cell.imgStr = str;
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str]  placeholderImage:[UIImage imageNamed:@"图片占位"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            /**
             *  缓存image size
             */
            [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                
                //reload row
                if(result && (self.isViewLoaded && self.view.window))  {
                    
                    [tableView  xh_reloadRowAtIndexPath:indexPath forURL:imageURL];
                }else{
                    
                }
                
            }];
        }];
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
//        NSDictionary *dict = self.imgMarr[indexPath.row];
        NSString *str = self.profitModel.TopBanner;
        /**
         *  参数1:图片URL
         *  参数2:imageView 宽度
         *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
         */
        
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:200];
    }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
        return 54;
    }else if (indexPath.row == 5){
        return 72;
    }else if (indexPath.row == 6){
        return 90;
    }else if (indexPath.row == 7){
        return 92;
    }else {
        NSArray *arr = [self.profitModel.EndBanner componentsSeparatedByString:@","];
        
        NSString *str = arr[indexPath.row-8];
        /**
         *  参数1:图片URL
         *  参数2:imageView 宽度
         *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
         */
        
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:200];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {//婚期
        
        [BRDatePickerView showDatePickerWithTitle:@"请选择新人婚期" dateType:BRDatePickerModeDate defaultSelValue:@"" resultBlock:^(NSString *selectValue) {
            self.dateStr = selectValue;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
    }else if (indexPath.row == 4) {//区域
        //地区
        CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
        picker.delegate = self;
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
        [self presentViewController:navc animated:YES completion:nil];
        
    }
}

#pragma mark - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID = parentID;
    
    //6-5 除首页 其他选择地址不保存到本地
    //    [[NSUserDefaults standardUserDefaults]setObject:address forKey:@"locationOfSubcity"];
    //    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"];
    NSLog(@"缓存城市设置为%@",address);
    self.cityInfo = address;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self selectDataBase];
    
}

- (void)areaPicker:(CJAreaPicker *)picker didClickCancleWithAddress:(NSString *)address parentID:(NSInteger)parentID{
    
}

#pragma mark --------数据库-------
-(void)moveToDBFile
{       //1、获得数据库文件在工程中的路径——源路径。
    NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"region"ofType:@"db"];
    
    NSLog(@"sourcesPath %@",sourcesPath);
    //2、获得沙盒中Document文件夹的路径——目的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSLog(@"documentPath %@",documentPath);
    
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
    
}
//打开数据库
- (void)openDataBase{
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
- (void)closeDataBase{
    BOOL ret = [dataBase close];
    if (ret) {
        NSLog(@"关闭数据库成功");
    }else{
        NSLog(@"关闭数据库失败");
    }
}
//查询数据库
-(void)selectDataBase{
    [self openDataBase];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"];
    NSLog(@"缓存城市为%@",huanCun);
    NSLog(@"_cityInfo*$#$#$##$$%@",self.cityInfo);
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'AND PARENT_ID =%ld",self.cityInfo,_parentID];
    FMResultSet *set =[dataBase executeQuery:selectSql];
    while ([set next]) {
        int ID = [set intForColumn:@"REGION_ID"];
        NSLog(@"==*****%d",ID);
        NSString *idStr = [NSString stringWithFormat:@"%d",ID];
        
        //6-5
        //        [[NSUserDefaults standardUserDefaults]setObject:idStr forKey:@"areaid"];
        //        NSLog(@"areaid ------- %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"areaid"]);
        self.areaid =idStr;
    }
    [self closeDataBase];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"~~~~~~ huanCun:%@ cityInfo:%@ areaid:%@ ",huanCun,self.cityInfo,self.areaid);
    
}

#pragma mark - 渐变色Image
- (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(int)gradientType{
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(bounds.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    
    CGPoint start;
    CGPoint end;
    
    switch (gradientType) {
        case 0://纵向渐变
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, bounds.size.height);
            break;
        case 1://横向渐变
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(bounds.size.width, 0.0);
            break;
        default:
            start = CGPointZero;
            end = CGPointZero;
            break;
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 通讯录
- (void)addressBookClick{
    YPAddressBookTool *tool = [YPAddressBookTool yp_shareAddressBookTool];
    tool.vc = self;
    [tool JudgeAddressBookPower];
    tool.successBlock = ^(NSDictionary * _Nonnull object) {
        NSLog(@"[YPAddressBookTool yp_shareAddressBookTool] -- %@--%@",object[@"name"],object[@"phone"]);
        NSMutableString *phone = [object[@"phone"] stringByReplacingOccurrencesOfString:@"-" withString:@""].mutableCopy;
        phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""].mutableCopy;
        phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""].mutableCopy;
        phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""].mutableCopy;
        self.nameTF.text = object[@"name"];
        self.phoneTF.text = phone.copy;
    };
}

#pragma mark - shareSDK
- (void)showShareSDKWithURL:(NSString *)url Title:(NSString *)title Text:(NSString *)text{
    
     [HRShareView showShareViewWithPublishContent:@{@"title":title,
                                                    @"text" :text,
                                                    @"image":@"http://121.42.156.151:93/FileGain.aspx?fi=b73de463-b243-4ac3-bfd2-37f40df12274&it=0",
                                                    @"url"  :url}
                                           Result:^(SSDKResponseState state, SSDKPlatformType type) {
                                               switch (state) {
                                                   case SSDKResponseStateSuccess:
                                                   {
                                                       if (type == SSDKPlatformSubTypeWechatTimeline) {
                                                           
                                                           
                                                           [EasyShowTextView showSuccessText:@"朋友圈分享成功"];
                                                       }
                                                       if (type == SSDKPlatformSubTypeWechatSession) {
                                                           
                                                           [EasyShowTextView showSuccessText:@"微信好友分享成功"];
                                                       }
                                                       if (type == SSDKPlatformSubTypeQQFriend) {
                                                           
                                                           [EasyShowTextView showSuccessText:@"QQ分享成功"];
                                                       }
                                                       if (type == SSDKPlatformTypeCopy) {
                                                           
                                                           [EasyShowTextView showSuccessText:@"链接复制成功"];
                                                       }
                                                       
                                                   }
                                                       break;
                                                   case SSDKResponseStateFail:
                                                   {
                                                       
                                                       [EasyShowTextView showErrorText:@"分享失败"];
                                                   }
                                                       break;
                                                   case SSDKResponseStateCancel:
                                                   {
                                                       
                                                       [EasyShowTextView showText:@"取消分享"];
                                                   }
                                                       break;
                                                   default:
                                                       break;
                                               }
                                               
                                           }];

}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)recordBtnClick{
    NSLog(@"recordBtnClick");
    
    YPInviteFriendsWedNormalRecordController *record = [[YPInviteFriendsWedNormalRecordController alloc]init];
    [self.navigationController pushViewController:record animated:YES];
}

- (void)submitBtnClick{
    NSLog(@"submitBtnClick");
    
    if (self.nameTF.text.length == 0) {
        [EasyShowTextView showText:@"请输入新人姓名" inView:self.tableView];
    }else if (self.phoneTF.text.length == 0){
        [EasyShowTextView showText:@"请输入新人手机号" inView:self.tableView];
    }else if (self.dateStr.length == 0){
        [EasyShowTextView showText:@"请选择新人婚期" inView:self.tableView];
    }else{
        [self CeaterInvitationRecord];
    }
}

- (void)showBtnClick{
    NSLog(@"showBtnClick");
    
    [self showShareSDKWithURL:[NSString stringWithFormat:@"http://www.chenghunji.com/Capital/WeddInvitation?UserId=%@",UserId_New] Title:[NSString stringWithFormat:@"赚钱也太快了，我已经赚了%@元！你也来试试？",self.profitModel.Money] Text:@"邀新人用成婚纪，赚80-10000元现金，可提现！"];
}

//- (void)controlClick{
//    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        _shareView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 200);
//    } completion:^(BOOL finished) {
//        [self.control removeFromSuperview];
//    }];
//}

#pragma mark - 网络请求
#pragma mark 提交邀请
- (void)CeaterInvitationRecord{
    
    NSString *url = @"/api/HQOAApi/CeaterInvitationRecord";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Name"] = self.nameTF.text;
    params[@"Phone"] = self.phoneTF.text;
    params[@"MarriagePeriod"] = self.dateStr;
    params[@"AreaId"] = self.areaid;
    params[@"PredefinedType"] = @"";//0婚庆,1酒店,2其他
    params[@"RefereeStatus"] = @"0";//0普通用户,1VIP
    params[@"RecommendId"] = UserId_New;
    params[@"MealMark"] = @"";
    params[@"TableNumber"] = @"";
    params[@"Budget"] = @"";
    params[@"WeddingCeremony"] = @"";

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSString *rank = [object valueForKey:@"Ranking"];
            
            self.nameTF.text = @"";
            self.phoneTF.text = @"";
            self.dateStr = @"";
            
            YPInviteFriendsWedNormalSucController *suc = [[YPInviteFriendsWedNormalSucController alloc]init];
            suc.rankStr = rank;
            [self.navigationController pushViewController:suc animated:YES];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark - getter
-(NSString *)areaid{
    if (!_areaid) {
        self.areaid = [[NSUserDefaults standardUserDefaults]objectForKey:@"region_New"];
    }
    return _areaid;
}
-(NSString *)cityInfo{
    if (!_cityInfo) {
        self.cityInfo = @"黄岛区";
    }
    return _cityInfo;
}

//- (UIControl *)control{
//    if (!_control) {
//        _control = [[UIControl alloc]initWithFrame:self.view.frame];
//        _control.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
//        if (!_shareView) {
//            _shareView = [YPInviteFriendsWedNormalShareView yp_InviteFriendsWedNormalShareView];
//            [_shareView.wechatBtn addTarget:self action:@selector(wechatBtnClick) forControlEvents:UIControlEventTouchUpInside];
//            [_shareView.cancleBtn addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
//        }
//    }
//    _shareView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 200);
//
//    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        _shareView.frame = CGRectMake(0, ScreenHeight-200, ScreenWidth, 200);
//        [_control addSubview:_shareView];
//    } completion:nil];
//    [_control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
//    return _control;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
