//
//  HRBaoMIViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/29.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRBaoMIViewController.h"
//抽奖
#import "LuckView.h"
#import "YPPopCornGetHistoryController.h"//领取记录
#import "FLCountDownView.h"//倒计时
#import "QRCodeReaderViewController.h"
#import "HRCodeScanningVC.h"//扫一扫  6.14
#import "YPPopCornScanSucView.h"//扫描成功
#import "YPPopCornShareSucView.h"//分享成功
#import "YPGetAllPrizesList.h"
#import "YPLotteryPrizeView.h"//奖品view
#import "HRJiangListViewController.h"//我的奖品
//4-2 添加 -- shareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

@interface HRBaoMIViewController ()<UITableViewDelegate,UITableViewDataSource,QRCodeReaderDelegate>

/**表*/
@property(nonatomic,strong)UITableView  *thisTableView;

/**遮罩*/
@property (nonatomic, strong) UIControl *control;
/**扫描提示遮罩*/
@property (nonatomic, strong) UIControl *scanControl;
/**分享提示遮罩*/
@property (nonatomic, strong) UIControl *shareControl;

@property (nonatomic, strong) NSMutableArray<YPGetAllPrizesList *> *listMarr;

@property (nonatomic, strong) LuckView *luckView;

//************************* 资格model ***************************
/**下次领取时间*/
@property (nonatomic, copy) NSString *NextTime;
/**领取资格 1能领，0不能领*/
@property (nonatomic, copy) NSString *Qualification;
/**抽奖次数*/
@property (nonatomic, copy) NSString *LotteryQualification;
/**活动结束消息*/
@property (nonatomic, copy) NSString *ActivityEndTime;
/**奖品领取时间间隔
 时间为秒*/
@property (nonatomic, copy) NSString *ReceiveTimeinterval;
//************************* model ***************************

@end

@implementation HRBaoMIViewController{
    UIView *_navView;
    UIView *lotteryView;
    UIView *lotteryBgView;
    QRCodeReaderViewController *_reader;
    YPPopCornScanSucView *_sucView;
    YPPopCornShareSucView *_shareView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetDrawQualificationWithType:@""];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =CHJ_bgColor;
    [self setupNav];
    [self createUI];
    self.view.backgroundColor = CHJ_bgColor;
}
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"免费领爆米花";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    UIButton *ruleBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [ruleBtn  setTitle:@"规则" forState:UIControlStateNormal];
    [ruleBtn setTitleColor:TextNormalColor forState:UIControlStateNormal];
    [ruleBtn addTarget:self action:@selector(ruleClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:ruleBtn];
    [ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn);
    }];
}
-(void)createUI{
    if (!self.thisTableView) {
        self.thisTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
    }
    _thisTableView.delegate =self;
    _thisTableView.dataSource =self;
    _thisTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_thisTableView];
}

#pragma mark ---------tableviewDatascource ------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*660/375)];
        bgImageView.image =[UIImage imageNamed:@"up"];
        [cell.contentView addSubview:bgImageView];
        
        //我的奖品按钮
        UIButton *jiangpinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [jiangpinBtn setImage:[UIImage imageNamed:@"jilu"] forState:UIControlStateNormal];
        [cell.contentView addSubview:jiangpinBtn];
        [jiangpinBtn addTarget:self action:@selector(jiangpinBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [jiangpinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.right.mas_equalTo(cell.contentView.mas_right).offset(-10);
            make.top.mas_equalTo(cell.contentView.mas_top).offset(150);
        }];
        
        //位置按钮
        UIButton *localBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [localBtn setImage:[UIImage imageNamed:@"site"] forState:UIControlStateNormal];
        [cell.contentView addSubview:localBtn];
        [localBtn addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
        [localBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.right.mas_equalTo(cell.contentView.mas_right).offset(-10);
            make.top.mas_equalTo(jiangpinBtn.mas_bottom).offset(10);
        }];
        
        //领取记录按钮
        
        
        UIButton *jiluBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [jiluBtn setImage:[UIImage imageNamed:@"lingRule"] forState:UIControlStateNormal];
        [cell.contentView addSubview:jiluBtn];
        [jiluBtn addTarget:self action:@selector(jiluClick) forControlEvents:UIControlEventTouchUpInside];
        [jiluBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.right.mas_equalTo(cell.contentView.mas_right).offset(-10);
            make.top.mas_equalTo(localBtn.mas_bottom).offset(10);
        }];
        
        
        UILabel *desLab = [[UILabel alloc]init];
        desLab.text =@"距离下次领取还有";
        desLab.textAlignment =NSTextAlignmentCenter;
        desLab.textColor =MainColor;
        desLab.font =kFont(15);
        desLab.frame =CGRectMake(0, ScreenWidth*454/373, ScreenWidth, 40);
        [cell.contentView addSubview:desLab];
        //        [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.bottom.mas_equalTo(cell.contentView.mas_bottom).offset(-150);
        //            make.centerX.mas_equalTo(cell.contentView);
        //            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 20));
        //        }];
        //
        
        //倒计时
        //        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //        //然后创建日期对象
        //        NSDate *date1 = [dateFormatter dateFromString:self.NextTime];
        //        NSDate *date = [NSDate date];
        //        //计算时间间隔（单位是秒）
        //        NSTimeInterval time = [date1 timeIntervalSinceDate:date];
        //        if (time < 0) {
        //            time = 0.0;
        //        }
        
        FLCountDownView *countDown      = [FLCountDownView fl_countDown];
        countDown.frame                 = CGRectMake(ScreenWidth/2-120, CGRectGetMaxY(desLab.frame)+10, 240, 20);
        //        countDown.timestamp             = 864000;
        countDown.timestamp             = [self.ReceiveTimeinterval integerValue];
        countDown.backgroundImageName   = @"";
        [cell.contentView addSubview:countDown];
        
        //领取按钮
        UIButton *lingquBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lingquBtn.frame =CGRectMake(ScreenWidth/2-90, CGRectGetMaxY(countDown.frame)+10, 180, 50);
        [lingquBtn setImage:[UIImage imageNamed:@"button_01"] forState:UIControlStateNormal];
        [lingquBtn setImage:[UIImage imageNamed:@"button_02"] forState:UIControlStateDisabled];
        [lingquBtn addTarget:self action:@selector(lingquClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView  addSubview:lingquBtn];
        
        //4-2 判断领取资格
        if ([self.Qualification integerValue] == 1) {//1能领，0不能领
            lingquBtn.enabled = YES;
        }else if ([self.Qualification integerValue] == 0){
            lingquBtn.enabled = NO;
        }
        
        countDown.timerStopBlock        = ^{
            NSLog(@"时间停止");
            lingquBtn.enabled = YES;
        };
        
        //时间描述
        UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lingquBtn.frame)+10, ScreenWidth, 20)];
        //        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        //        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //        NSDate *nextDate = [format dateFromString:self.NextTime];
        //        timeLab.text = [NSString stringWithFormat:@"活动持续时间：至 %@",[format stringFromDate:nextDate]];
        timeLab.text = self.ActivityEndTime;
        timeLab.textAlignment =NSTextAlignmentCenter;
        timeLab.font =kFont(13);
        timeLab.textColor =MainColor;
        [cell.contentView addSubview:timeLab];
        return cell;
        
    }else{
        
        //MARK: 抽奖
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        lotteryBgView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
        [cell.contentView addSubview:lotteryBgView];
        lotteryBgView.backgroundColor=[UIColor redColor];
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:lotteryBgView.bounds];
        bgImageView.image =[UIImage imageNamed:@"yellow_bg"];
        [lotteryBgView addSubview:bgImageView];
        
        UIImageView *bgImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth-20, ScreenWidth -20)];
        bgImageView2.image =[UIImage imageNamed:@"outlineborder"];
        [lotteryBgView addSubview:bgImageView2];
        
        
        lotteryView=[[UIView alloc] initWithFrame:CGRectMake(20, 20, ScreenWidth-40, ScreenWidth-40)];
        lotteryView.clipsToBounds =YES;
        lotteryView.layer.cornerRadius =10;
        [lotteryBgView addSubview:lotteryView];
        lotteryView.backgroundColor=RGB(250, 175, 16);
        
        NSMutableArray *imgMarr = [NSMutableArray array];
        NSMutableArray *titleMarr = [NSMutableArray array];
        
        for (YPGetAllPrizesList *list in self.listMarr) {
            [imgMarr addObject:list.Imgurl];
            [titleMarr addObject:list.PrizeName];
        }
        
        [lotteryView addSubview:self.luckView];
        self.luckView.LotteryQualification = self.LotteryQualification;
        if (imgMarr.count > 0 && titleMarr.count > 0) {
            self.luckView.titleArray = titleMarr.copy;
            self.luckView.imageArray = imgMarr.copy;
        }
        
        //block用法获取结果
        [self.luckView getLuckResult:^(NSInteger result) {
            NSLog(@"抽到了第%ld个",(long)result);
            [self GetDrawQualificationWithType:@"111"];
        }];
        //block用法监听点击
        [self.luckView getLuckBtnSelect:^(UIButton *btn) {
            NSLog(@"点击了数组中的第%ld个元素",(long)btn.tag);
        }];
        
        return cell;
        
    }
    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return nil;
    }else{
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
        
        UIImageView *bg1ImageView = [[UIImageView alloc]initWithFrame:headerView.bounds];
        bg1ImageView.image = [UIImage imageNamed:@"yellow_bg"];
        [headerView addSubview:bg1ImageView];
        UIImageView *bg2ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 10, ScreenWidth-100, 80)];
        bg2ImageView.image = [UIImage imageNamed:@"choutitle"];
        [headerView addSubview:bg2ImageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bg2ImageView.frame)+20, ScreenWidth, 40)];
        label.text = [NSString stringWithFormat:@"当前剩余抽奖次数 %zd 次",[self.LotteryQualification integerValue]];
        label.textColor = [UIColor colorWithRed:0.90 green:0.35 blue:0.04 alpha:1.00];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:20];
        [headerView addSubview:label];
        return headerView;
    }
}
#pragma  mark ---------tableviewDelegate -------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        
        return ScreenWidth*620/375;
        
    }else{
        
        return ScreenWidth;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 0;
    }else{
        return 150;
    }
    
}


#pragma mark -------target--------
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)lingquClick{
    NSLog(@"领取爆米花");
    
//    NSArray *types = @[AVMetadataObjectTypeQRCode];
//    _reader = [QRCodeReaderViewController readerWithMetadataObjectTypes:types];
//
//    // Using delegate methods
//    _reader.delegate = self;
//
//    [self presentViewController:_reader animated:YES completion:NULL];
    HRCodeScanningVC *scanVC = [HRCodeScanningVC new];
    scanVC.fromType =@"1";
    scanVC.callBackBlock = ^(NSString *text) {
        
        
        NSString *str1 = [text substringFromIndex:41];
//        NSLog(@"截取数据：%@",str1);//type=1&objectId=100000000
     NSArray *array = [str1 componentsSeparatedByString:@"&"];
//        NSString *strType = [array[0] substringFromIndex:5];
         NSString *strID = [array[1] substringFromIndex:9];
        
//        NSLog(@"截取数据：%@ ---%@",strType,strID);
        [self PeopleReceivePopcornWithShopID:strID];
    };
    [self.navigationController pushViewController:scanVC animated:YES];
    
    
}

-(void)jiluClick{
    NSLog(@"领取记录");
    
    YPPopCornGetHistoryController *history = [[YPPopCornGetHistoryController alloc]init];
    [self.navigationController pushViewController:history animated:YES];
}

-(void)ruleClick{
    NSLog(@"领取规则");
    
    [self.view addSubview:self.control];
    
}
-(void)jiangpinBtnClick{
     NSLog(@"我的奖品");
    HRJiangListViewController *jiangVC = [HRJiangListViewController new];
    [self.navigationController pushViewController:jiangVC animated:YES];
}
-(void)locationClick{
    NSLog(@"领取地点");
    HRWebViewController *webVC =[HRWebViewController new];
    
    NSString *area = areaID_New;
    if (area.length > 0) {
        webVC.webUrl =[NSString stringWithFormat:@"http://www.chenghunji.com/Map/Index?regionId=%@",areaID_New];
    }else{
        webVC.webUrl =[NSString stringWithFormat:@"http://www.chenghunji.com/Map/Index?regionId=%@",@"0"];//没值传0 -- 18-08-15 窦
    }
    webVC.isShareBtn =NO;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)controlClick:(UIControl *)sender{
    
    [sender removeFromSuperview];
}

- (void)getBtnClick{
    NSLog(@"share");
    
    [self showShareSDK];
}

//- (void)lotteryBtnClick:(UIButton *)sender{
//
//    if (sender.isSelected) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请先扫码领取爆米花在进行抽奖" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }else{
//
//        [self UserGetPrizes];
//
//    }
//}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@", result);
        /*
         {
         "type": "1",
         "objectId": "6000001"
         }
         */
        NSError *err;
        NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        if(!err) {
            if ([dict[@"type"] integerValue] == 1) {//1 爆米花
                NSLog(@"验证成功 -- %@",dict[@"objectId"]);
                //                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"验证成功 -- %@",dict[@"objectId"]] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                //                [alert show];
                
                [self PeopleReceivePopcornWithShopID:dict[@"objectId"]];
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"扫码失败,请重试!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
        }else{
            NSLog(@"json解析失败：%@",err);
        }
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - getter
- (UIControl *)control{
    if (!_control) {
        _control = [[UIControl alloc]initWithFrame:self.view.frame];
        _control.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;
        view.layer.cornerRadius = 10;
        view.clipsToBounds = YES;
        [_control addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_control);
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(-50);
            make.height.mas_equalTo([self getHeighWithTitle:@"抽奖规则: \n\t· 每领取四次爆米花获得一次抽奖机会, 可多次抽奖\n\n奖品发送: \n\t· 现金红包, 及时到账, 可随时提现\n\t· 爆米花可到所有活动指定地点领取\n\t· 美体内衣在\"我的奖品\"里领取填写收货地址、联系人、联系电话后七个工作日内发送完毕" font:kBigFont width:ScreenWidth-100-30]+50);
        }];
        UILabel *label = [[UILabel alloc]init];
        label.text = @"抽奖规则: \n\t· 每领取四次爆米花获得一次抽奖机会, 可多次抽奖\n\n奖品发送: \n\t· 现金红包, 及时到账, 可随时提现\n\t· 爆米花可到所有活动指定地点领取\n\t· 美体内衣在\"我的奖品\"里领取填写收货地址、联系人、联系电话后七个工作日内发送完毕";
        label.textColor = RGB(255, 124, 52);
        label.numberOfLines = 0;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(25);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-25);
        }];
        UILabel *endLabel = [[UILabel alloc]init];
        endLabel.text = @"×";
        endLabel.font = [UIFont boldSystemFontOfSize:50];
        endLabel.textColor = WhiteColor;
        [_control addSubview:endLabel];
        [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(view.mas_bottom).mas_offset(30);
            make.centerX.mas_equalTo(view);
        }];
    }
    [_control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
    return _control;
}

- (UIControl *)scanControl{
    if (!_scanControl) {
        _scanControl = [[UIControl alloc]initWithFrame:self.view.frame];
        _scanControl.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    }
    [_scanControl addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
    return _scanControl;
}

- (UIControl *)shareControl{
    if (!_shareControl) {
        _shareControl = [[UIControl alloc]initWithFrame:self.view.frame];
        _shareControl.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    }
    [_shareControl addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
    return _shareControl;
}

- (NSMutableArray<YPGetAllPrizesList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (LuckView *)luckView{
    if (!_luckView) {
        _luckView = [[LuckView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-40, ScreenWidth-40)];
    }
    return _luckView;
}

#pragma mark - 动态计算label高度
- (CGFloat )getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
    
}

#pragma mark - shareSDK
- (void)showShareSDK{
    
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"分享图标"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSString *str = @"http://www.chenghunji.com/map/baomihuafenxiang";
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"在这和你相遇，2018天天有惊喜！最高可享100元现金福利哦！还有更多福利，尽在婚礼桥！"
                                         images:imageArray
                                            url:[NSURL URLWithString:str]
                                          title:@"分享赢取大桶爆米花"
                                           type:SSDKContentTypeAuto];
        
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:@[
                                         @(SSDKPlatformSubTypeWechatTimeline),
                                         ]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               [EasyShowTextView showSuccessText:@"分享成功"];
                               
                               [self PeopleReceiveBigPopcorn];
                               
                               break;
                           }
                           case SSDKResponseStateCancel:
                               
                           {
                               [EasyShowTextView showText:@"取消分享"];
                               
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               [EasyShowTextView showErrorText:@"分享失败"];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
    }
    
}

#pragma mark - 网络请求
#pragma mark 获取用户领取资格
- (void)GetDrawQualificationWithType:(NSString *)str{
    
    NSString *url = @"/api/HQOAApi/GetDrawQualification";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.NextTime               = [object valueForKey:@"NextTime"];
            self.Qualification          = [object valueForKey:@"Qualification"];//1能领，0不能领
            self.LotteryQualification   = [object valueForKey:@"LotteryQualification"];
            self.ActivityEndTime        = [object valueForKey:@"ActivityEndTime"];
            self.ReceiveTimeinterval    = [object valueForKey:@"ReceiveTimeinterval"];
            
            if ([str isEqualToString:@"111"]) {//扫码领取后刷新整个
                
                [self.thisTableView reloadData];
                
            }else{//其他刷新第一组
                
                [self.thisTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                
            }
            
            [self GetAllPrizesList];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 用户领取爆米花
- (void)PeopleReceivePopcornWithShopID:(NSString *)shopID{
    
    NSString *url = @"/api/HQOAApi/PeopleReceivePopcorn";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    params[@"ShopId"] = shopID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.view addSubview:self.scanControl];
            if (!_sucView) {
                _sucView = [YPPopCornScanSucView yp_popCornScanSucView];
            }
            [self.scanControl addSubview:_sucView];
            [_sucView.getBtn addTarget:self action:@selector(getBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [_sucView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.view);
                make.left.mas_equalTo(40);
                make.right.mas_equalTo(-40);
                make.height.mas_equalTo(380);
            }];
            UILabel *endLabel = [[UILabel alloc]init];
            endLabel.text = @"ⓧ";
            endLabel.font = [UIFont boldSystemFontOfSize:40];
            endLabel.textColor = WhiteColor;
            [self.scanControl addSubview:endLabel];
            [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_sucView.mas_bottom).mas_offset(20);
                make.centerX.mas_equalTo(_sucView);
                //            make.size.mas_equalTo(CGSizeMake(40, 40));
            }];
            
            [self GetDrawQualificationWithType:@"111"];//重新获取下次领取时间
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 用户分享领取大桶爆米花
- (void)PeopleReceiveBigPopcorn{
    
    NSString *url = @"/api/HQOAApi/PeopleReceiveBigPopcorn";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.view addSubview:self.shareControl];
            if (!_shareView) {
                _shareView = [YPPopCornShareSucView yp_popCornShareSucView];
            }
            [self.shareControl addSubview:_shareView];
            [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.view);
                make.left.mas_equalTo(40);
                make.right.mas_equalTo(-40);
                make.height.mas_equalTo(380);
            }];
            UILabel *endLabel = [[UILabel alloc]init];
            endLabel.text = @"ⓧ";
            endLabel.font = [UIFont boldSystemFontOfSize:40];
            endLabel.textColor = WhiteColor;
            [self.shareControl addSubview:endLabel];
            [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_shareView.mas_bottom).mas_offset(20);
                make.centerX.mas_equalTo(_shareView);
                //            make.size.mas_equalTo(CGSizeMake(40, 40));
            }];
            
            [self GetDrawQualificationWithType:@"111"];//重新获取下次领取时间
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 获取全部爆米花奖品列表
- (void)GetAllPrizesList{
    
    NSString *url = @"/api/HQOAApi/GetAllPrizesList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.listMarr removeAllObjects];
            
            self.listMarr = [YPGetAllPrizesList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            //            for (int i = 0; i < 10; i ++) {
            //
            //                YPGetAllPrizesList *list = [[YPGetAllPrizesList alloc]init];
            //                list.PrizeName = [NSString stringWithFormat:@"奖品 - %zd",i+1];
            //                list.Imgurl = @"http://121.42.156.151:93/FileGain.aspx?fi=b408efe6-bcd9-4f5c-8049-63b39e90bf1b&it=1";
            //                [self.listMarr addObject:list];
            //            }
            
            //            [self UserGetPrizes];//获取奖品列表时同步获取抽中的礼品
            
            [self.thisTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
