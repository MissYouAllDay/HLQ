//
//  SliderMeViewController.m
//  HunQingYH
//
//  Created by xl on 2019/6/18.
//  Copyright © 2019 xl. All rights reserved.
//

#import "SliderMeViewController.h"
#import "slidermecell.h"
#import "YPGetUserInfo.h"
#import "YPPersonInfoController.h"
#import "YPSupplierPersonInfoController.h"
#import "YPSettingController.h"
#import "YPReFindController.h"//婚礼秀
#import "YPReMyWalletBaseController.h"//18-09-27 我的钱包重做
#import "YPKeYuan190513ViewController.h"
#import "YPMyAnliListController.h"
#import "YPChangeAccountController.h"//18-11-13 切换账号
#import "YPEDuBaseController.h"
@interface SliderMeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *thisTableView;
    UILabel *nameLab;
    UIImageView *headericonImageview;
}

@property (nonatomic, strong) YPGetUserInfo *userInfo;
@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *iconImgUrl;
@property (nonatomic, copy) NSString *professionID;
@end

@implementation SliderMeViewController
- (YPGetUserInfo *)userInfo{
    if (!_userInfo) {
        _userInfo = [[YPGetUserInfo alloc]init];
    }
    return _userInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=WhiteColor;
    [self addtopview];
    [self initUI];
     if (UserId_New) {
             [self GetUserFacilitatorInfo];
     }

}

-(void)addtopview{
    UIView *topview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth*0.75, 170)];
    topview.backgroundColor =MainColor;
    [self.view addSubview:topview];
    UILabel *qiehuanLab =[[UILabel alloc]init];
    qiehuanLab.textColor =WhiteColor;
    qiehuanLab.text=@"切换账号";
    qiehuanLab.font =[UIFont systemFontOfSize:15];
    qiehuanLab.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(qiehuanClick)];
    
    [qiehuanLab addGestureRecognizer:labelTapGestureRecognizer];

    [topview addSubview:qiehuanLab];
    [qiehuanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topview.mas_left).offset(18);
        make.top.mas_equalTo(topview.mas_top).offset(40);
    }];
    
    headericonImageview =[[UIImageView alloc]init];
    headericonImageview.clipsToBounds =YES;
    headericonImageview.image =[UIImage imageNamed:@"1024"];
    headericonImageview.layer.cornerRadius =30;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeaderIcon)];
    [headericonImageview addGestureRecognizer:tapGesture];
    headericonImageview.userInteractionEnabled = YES;
    [topview addSubview:headericonImageview];
    [headericonImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(qiehuanLab);
        make.centerX.mas_equalTo(topview);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    nameLab =[[UILabel alloc]init];
    nameLab.font =kFont(20);
    nameLab.text =@"点击登录";
    nameLab.textColor =WhiteColor;
    [topview addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(topview);
        make.top.mas_equalTo(headericonImageview.mas_bottom).offset(10);
    }];
}
-(void)initUI{
    thisTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 170, ScreenWidth*0.75, ScreenHeight-170-100)];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:thisTableView];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-100, ScreenWidth*0.75, 100)];
    bottomView.backgroundColor =WhiteColor;
    [self.view addSubview:bottomView];
    
    
    UIButton *shezhiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [shezhiBtn setBackgroundImage:[UIImage imageNamed:@"sl_shezhi"] forState:UIControlStateNormal];
    [shezhiBtn setTitle:@"" forState:UIControlStateNormal];
    [shezhiBtn addTarget:self action:@selector(shezhiclick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:shezhiBtn];
    [shezhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(23, 24));
        make.top.mas_equalTo(bottomView.mas_top).offset(10);
        make.left.mas_equalTo(bottomView.mas_left).offset(40);
    }];
    
    UILabel *shedesLab = [[UILabel alloc]init];
    shedesLab.text =@"设置";
    shedesLab.font =kFont(15);
    [bottomView addSubview:shedesLab];
    [shedesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(shezhiBtn.mas_bottom).offset(5);
        make.centerX.mas_equalTo(shezhiBtn);
    }];
    
    
    
    UIButton *fenxiangBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [fenxiangBtn setBackgroundImage:[UIImage imageNamed:@"sl_fenxiang"] forState:UIControlStateNormal];
    [fenxiangBtn setTitle:@"" forState:UIControlStateNormal];
    [fenxiangBtn addTarget:self action:@selector(fenclick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:fenxiangBtn];
    [fenxiangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(23, 24));
        make.top.mas_equalTo(bottomView.mas_top).offset(10);
        make.right.mas_equalTo(bottomView.mas_right).offset(-40);
    }];
    
    UILabel *fenxiangLab = [[UILabel alloc]init];
    fenxiangLab.text =@"分享APP";
    fenxiangLab.font =kFont(15);
    [bottomView addSubview:fenxiangLab];
    [fenxiangLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(fenxiangBtn.mas_bottom).offset(5);
        make.centerX.mas_equalTo(fenxiangBtn);
    }];
}

#pragma mark ------------------tableviewdatascource------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    slidermecell *cell =[slidermecell cellWithTableView:tableView];
    if (indexPath.row==0) {
        cell.imageView.image=[UIImage imageNamed:@"sl_hunlixiu"];
        cell.titleLab.text=@"婚礼秀";
    }else   if (indexPath.row==1) {
        cell.imageView.image=[UIImage imageNamed:@"sl_qianbao"];
        cell.titleLab.text=@"钱包";
    }else   if (indexPath.row==2) {
        cell.imageView.image=[UIImage imageNamed:@"sl_lipin"];
        cell.titleLab.text=@"领伴手礼";
    }else   if (indexPath.row==3) {
        cell.imageView.image=[UIImage imageNamed:@"yaoqing"];
        cell.titleLab.text=@"邀请新人";
    }else   {
        cell.imageView.image=[UIImage imageNamed:@"sl_Rectangle"];
        cell.titleLab.text=@"我的案例";
    }
    
    
    return cell;
}

#pragma mark--------------------tableviewdelegate--------------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==0) {
        NSLog(@"婚礼秀");
        [self dismissViewControllerAnimated:YES completion:nil];

        
        if (!UserId_New) {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"loginNoti" object:self];
       
            
        }else{
            YPReFindController *find = [[YPReFindController alloc]init];
            [self cw_pushViewController:find];
            
        }

    }else  if (indexPath.row==1) {
        NSLog(@"钱包");
        [self dismissViewControllerAnimated:YES completion:nil];

        
        if (!UserId_New) {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"loginNoti" object:self];
            
            
        }else{
            YPReMyWalletBaseController *base = [[YPReMyWalletBaseController alloc]init];
            [self cw_pushViewController:base];
            
        }
  
    }else  if (indexPath.row==2) {
        NSLog(@"领伴手礼");
        [self dismissViewControllerAnimated:YES completion:nil];
        
        if (!UserId_New) {
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"loginNoti" object:self];
            
            
        }else{
            YPEDuBaseController *edu = [[YPEDuBaseController alloc]init];
            edu.typeStr = @"0";//伴手礼
            [self cw_pushViewController:edu];
        }

    }else  if (indexPath.row==3) {
        NSLog(@"邀请新人");
        [self dismissViewControllerAnimated:YES completion:nil];

        if (!UserId_New) {
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"loginNoti" object:self];
            
            
        }else{
            //18-10-15 邀请结婚
            YPKeYuan190513ViewController *yaoqing =[YPKeYuan190513ViewController new];
            yaoqing.formIndex =1;
            [self cw_pushViewController:yaoqing];
         
        }
    }else {
        NSLog(@"我的案例");
        [self dismissViewControllerAnimated:YES completion:nil];
        
        if (!UserId_New) {
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"loginNoti" object:self];
            
            
        }else{
            YPMyAnliListController *anli = [[YPMyAnliListController alloc]init];
            [self cw_pushViewController:anli];
            
        }

    }
}
- (UIViewController *)getviewController {
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark------------------------target-----------------
-(void)qiehuanClick{
    [self dismissViewControllerAnimated:YES completion:nil];

    YPChangeAccountController *change = [[YPChangeAccountController alloc]init];
    [self cw_pushViewController:change];
}
-(void)shezhiclick{
    NSLog(@"设置");
    [self dismissViewControllerAnimated:YES completion:nil];

    if (!UserId_New) {
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"loginNoti" object:self];
        
        
    }else{
        YPSettingController *set = [[YPSettingController alloc]init];
        [self cw_pushViewController:set];
    }
}

-(void)fenclick{
    NSLog(@"分享");
    [self showShareSDK];
    
}
-(void)showShareSDK{
    
    [HRShareView showShareViewWithPublishContent:@{@"title":@"送您一份新婚礼，快去婚礼桥APP领取！",
                                                   @"text" :@"婚庆、婚纱，全部花多少返多少！婚礼对戒等更多豪礼速来领！",
                                                   @"image":@"http://121.42.156.151:93/FileGain.aspx?fi=b73de463-b243-4ac3-bfd2-37f40df12274&it=0",
                                                   //                                                   @"url"  :@"http://www.chenghunji.com/Redbag/index"}
                                                   @"url"  :@"https://itunes.apple.com/cn/app/id1289565288?mt=8"}//FIXME: 18-08-18 修改成跳App Store
                                          Result:^(SSDKResponseState state, SSDKPlatformType type) {
                                              switch (state) {
                                                  case SSDKResponseStateSuccess:
                                                  {
                                                      if (type == SSDKPlatformSubTypeWechatTimeline) {
                                                          
                                                          
                                                          [EasyShowTextView showSuccessText:@"朋友圈分享成功"];
                                                      }
                                                      if (type == SSDKPlatformSubTypeWechatSession) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"微信好友分享成功"];
                                                          [EasyShowTextView showSuccessText:@"分享成功"];
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
-(void)clickHeaderIcon{
    [self dismissViewControllerAnimated:YES completion:nil];

    if (!UserId_New) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"loginNoti" object:self];
        
    }else{

        //18-08-11 修改 用户直接进个人资料
        if (CheShou(self.professionID) || YongHu(self.professionID)){//车手 新人-用户
            //个人资料
            YPPersonInfoController *person = [[YPPersonInfoController alloc]init];
            [self cw_pushViewController:person];
            
        }else{//供应商选择进入个人资料/供应商资料(两种资料都有)
            
            //18-11-30 供应商只有供应商资料
            //供应商个人资料
            YPSupplierPersonInfoController *person = [[YPSupplierPersonInfoController alloc]init];
            [self cw_pushViewController:person];
            //        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑个人资料",@"编辑商家资料", nil];
            //        [sheet showInView:self.view];
            
        }
        
    }


}
#pragma mark - 网络请求
#pragma mark 获取个人/供应商信息
- (void)GetUserFacilitatorInfo{
    
    NSString *url = @"/api/HQOAApi/GetUserFacilitatorInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = UserId_New;//18-08-11 用户ID-徐
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        NSLog(@"我的返回：%@",object);
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.userInfo.UserId = [object valueForKey:@"UserId"];
            self.userInfo.Phone = [object valueForKey:@"Phone"];
            self.userInfo.Name = [object valueForKey:@"Name"];
            self.userInfo.Profession = [object valueForKey:@"Profession"];
            self.userInfo.Headportrait = [object valueForKey:@"Headportrait"];
            self.userInfo.FacilitatorId = [object valueForKey:@"FacilitatorId"];
            self.userInfo.ModelID = [object valueForKey:@"ModelID"];
            self.userInfo.Address = [object valueForKey:@"Address"];
            
            self.userInfo.IsMotorcade = [object valueForKey:@"IsMotorcade"];
            self.userInfo.CaptainID = [object valueForKey:@"CaptainID"];
            self.userInfo.IsNews = [object valueForKey:@"IsNews"];
            
            self.userInfo.Abstract = [object valueForKey:@"Abstract"];
            
            //5-29
            self.userInfo.FollowNumber = [[object valueForKey:@"FollowNumber"] integerValue];
            self.userInfo.FansNumber = [[object valueForKey:@"FansNumber"] integerValue];
            
            self.userInfo.region = [object valueForKey:@"region"];
            self.userInfo.regionname = [object valueForKey:@"regionname"];
            self.userInfo.StatusType = [object valueForKey:@"StatusType"];
            
            self.iconImgUrl = self.userInfo.Headportrait;
            self.titleName = self.userInfo.Name;
            self.professionID = self.userInfo.Profession;
            
            //18-08-16
            self.userInfo.WeChatName = [object valueForKey:@"WeChatName"];
            self.userInfo.WeChatType = [object valueForKey:@"WeChatType"];
            
            //18-11-02 婚期
            self.userInfo.Wedding = [object valueForKey:@"Wedding"];
            
            //保存信息
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.UserId forKey:@"UserId_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.Name forKey:@"Name_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.Headportrait forKey:@"Headportrait_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.Profession forKey:@"Profession_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.Phone forKey:@"Phone_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.FacilitatorId forKey:@"FacilitatorId_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.WeChatName forKey:@"WeChatName_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.WeChatType forKey:@"WeChatType_New"];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo.Wedding forKey:@"Wedding_New"];
            
//            [thisTableView reloadData];
            
            nameLab.text =self.userInfo.Name;
            [headericonImageview sd_setImageWithURL:[NSURL URLWithString:self.userInfo.Headportrait]];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}


@end
