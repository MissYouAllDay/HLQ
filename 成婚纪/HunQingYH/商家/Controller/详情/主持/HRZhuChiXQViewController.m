//
//  HRZhuChiXQViewController.m
//  HunQingYH
//
//  Created by DiKai on 2017/8/22.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRZhuChiXQViewController.h"
#import "LEECoolButton.h"
#import "HRZhuChi01Cell.h"
#import "HRZhuChi02Cell.h"
#import "FL_Button.h"
#import "YPMyAnliDetailController.h"
@interface HRZhuChiXQViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *navView;
    UITableView *thisTableView;
    LEECoolButton *starButton;
    NSInteger isShouCangRequest;//1 需要请求收藏接口 其他数字不需要
    NSString *shoucangType;// 0 没有收藏 1已经收藏
}
@property(nonatomic,strong)NSMutableArray *anLiArr;
@end

@implementation HRZhuChiXQViewController
-(NSMutableArray *)anLiArr{
    if (!_anLiArr) {
        _anLiArr =[NSMutableArray array];
    }
    return _anLiArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self getXQRequest];
    [self createMainUI];
    [self createBottomView];
    
}
- (void)createNav {
    navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor = WhiteColor;
    [self.view addSubview:navView];
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(navView.mas_left);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-10);
    }];
    
   
    
}
-(void)createMainUI{
    self.view.backgroundColor =bgColor;
    thisTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50)];
    thisTableView.dataSource =self;
    thisTableView.delegate =self;
    thisTableView.estimatedRowHeight = 150;//
    thisTableView.tableHeaderView =[self addHeaderView];
    thisTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:thisTableView];
    
}
-(UIView*)addHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    UIImageView *iconImageView = [[UIImageView alloc]init];
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:self.Headportrait] placeholderImage:[UIImage imageNamed:@"占位图"]];
    [headerView addSubview: iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerView);
        make.top.mas_equalTo(headerView);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.textColor =[UIColor blackColor];
    nameLab.font =kFont(18);
    nameLab.text  =self.Name;
    nameLab.textAlignment =NSTextAlignmentCenter;
    [headerView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(iconImageView);
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(200, 15));
    }];
    UIButton *zhiyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhiyeBtn setBackgroundColor:RGB(146, 194, 57)];
    zhiyeBtn.titleLabel.font =kFont(13);
    [zhiyeBtn setTitle:self.zhiyeName forState:UIControlStateNormal];
    zhiyeBtn.clipsToBounds =YES;
    zhiyeBtn.layer.cornerRadius =2;
    [zhiyeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headerView addSubview:zhiyeBtn];
    [zhiyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerView);
        make.top.mas_equalTo(nameLab.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    return headerView;
}
-(void)createBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth,50)];
    bottomView.backgroundColor =WhiteColor;
    
    [self.view addSubview:bottomView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor =bgColor;
    [bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(2, 30));
        
    }];
    
    
//    LEECoolButton *starButton = [LEECoolButton coolButtonWithImage:[UIImage imageNamed:@"star"] ImageFrame:CGRectMake(10, 10, 20, 20)];
      starButton = [LEECoolButton coolButtonWithImage:[UIImage imageNamed:@"star"] ImageFrame:CGRectMake((ScreenWidth/2-31)/2-45, 3, 20, 20)WithTitle:@"收藏" TitleColor:[UIColor colorWithRed:136/255.0f green:153/255.0f blue:166/255.0f alpha:1.0f]];
    
    starButton.frame = CGRectMake(15, 10, ScreenWidth/2-31, 30);
    
    [starButton addTarget:self action:@selector(starButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:starButton];
//     [starButton mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.centerY .mas_equalTo(bottomView);
//         make.left.mas_equalTo(bottomView);
//         make.right.mas_equalTo(lineView);
//         make.height.mas_equalTo(bottomView.mas_height);
//     }];
    
    
    
   FL_Button *phoneBtn = [FL_Button fl_shareButton];
    [phoneBtn setBackgroundColor:[UIColor whiteColor]];
    [phoneBtn setImage:[UIImage imageNamed:@"手机"] forState:UIControlStateNormal];
    [phoneBtn setTitle:@" 电话" forState:UIControlStateNormal];
   
    [phoneBtn setTitleColor:[UIColor colorWithRed:136/255.0f green:153/255.0f blue:166/255.0f alpha:1.0f] forState:UIControlStateNormal];
    phoneBtn.status = FLAlignmentStatusNormal;
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    phoneBtn.frame = CGRectMake(ScreenWidth/2+1,10, ScreenWidth/2-31, 30);
    [bottomView addSubview:phoneBtn];
   
    
    

}

#pragma mark ------tableViewdatascource ----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.anLiArr.count+2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        HRZhuChi01Cell *cell = [HRZhuChi01Cell cellWithTableView:tableView];
        cell.titleLab.text =@"简介";
        cell.desLab.text =self.BriefinTroduction;
        return cell;
    }else if(indexPath.row ==1){
        HRZhuChi01Cell *cell = [HRZhuChi01Cell cellWithTableView:tableView];
        cell.titleLab.text =@"地址";
        cell.desLab.text =self.Adress;
        return cell;
    }else{
        HRZhuChi02Cell *cell = [HRZhuChi02Cell cellWithTableView:tableView];
        cell.model =self.anLiArr[indexPath.row-2];
        if (indexPath.row ==2) {
            cell.titleLab.hidden =NO;
            cell.numLab.hidden =NO;
            cell.numLab.text =[NSString stringWithFormat:@"%zd",self.anLiArr.count];
            cell.titleLab.text =@"案例";
        }else{
            cell.titleLab.hidden =YES;
            cell.numLab.hidden =YES;
        }
        return cell;
    }
    
}
#pragma mark -------tableViewDelegate -----------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        return self.rowhight+30;
    }else if (indexPath.row ==1){
        return 50;
    }else{
        return 180;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        
    }else if (indexPath.row ==1){
        
    }else{
        YPMyAnliDetailController *detailVC = [YPMyAnliDetailController new];
        detailVC.SupplierID =self.SupplierID;
        HRAnLiModel *model =self.anLiArr[indexPath.row-2];
        detailVC.CaseID =[NSString stringWithFormat:@"%zd",model.CaseID];
        [self.navigationController pushViewController:detailVC animated:YES];
    }

}
#pragma mark -------target-------
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)starButtonAction:(LEECoolButton *)sender{
    
    
    if (sender.selected) {
        
        //未选中状态
        
        [sender deselect];
        
        
    } else {
        
        //选中状态
        
        [sender select];
    }
    NSLog(@"%zd",isShouCangRequest);
    if (isShouCangRequest ==1) {
        isShouCangRequest =0;
    }else{
        
        self.IsCollection =!_IsCollection;
        isShouCangRequest =0;
        //        NSLog(@"%zd",self.IsCollection);
        if (self.IsCollection ==1){
            [self shouCangRequest];
            
        }else{
            [self shouCangRequest];
            //            [self QXshouCangRequest];
        }
    }
    
    

    
}
-(void)phoneBtnClick{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",kefuTel];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)getXQRequest{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/User/GetSupplierInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserID"]   = myID;
    params[@"SupplierID"] =[NSString stringWithFormat:@"%zd",self.SupplierID];
    if (self.SupplierID ==[mySupplierID integerValue]) {
        params[@"Type"]  = @"1"; //0、用户获取供应商1、供应商获取自己
    }else{
        params[@"Type"]  = @"0"; //0、用户获取供应商1、供应商获取自己
    }
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"详情%@",object);
            self.BriefinTroduction =[object objectForKey:@"BriefinTroduction"];
            self.SupplierID =[[object objectForKey:@"SupplierID"]integerValue];
            self.RummeryID =[[object objectForKey:@"RummeryID"]integerValue];
            self.PhoneNo =[object objectForKey:@"PhoneNo"];
            self.anLiArr  =[HRAnLiModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            self.IsCollection =[[object objectForKey:@"IsCollection"]integerValue];
             self.CollectionID =[[object objectForKey:@"CollectionID"]integerValue];
            self.rowhight =[self getHeighWithTitle:self.BriefinTroduction font:[UIFont systemFontOfSize:15] width:ScreenWidth-60];
            self.CorpID =[[object objectForKey:@"CorpID"]integerValue];
            [thisTableView reloadData];
            //处理收藏按钮
            if (self.IsCollection ==1) {
                //已经收藏 只需要改变收藏按钮样式，无需请求接口
                isShouCangRequest =1;
                shoucangType =@"1";
                [self starButtonAction:starButton];
            }else{
                shoucangType =@"0";
            }
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
            
        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
    
}

-(void)shouCangRequest{
    NSLog(@"收藏状态%zd",self.IsCollection);
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/User/AddAndDelCollectionInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"CollectionType"]   = @"0";//0供应商、1方案、2宴会
    if ([self.Name isEqualToString:@"婚庆"]){
        params[@"TypeID"] =[NSString stringWithFormat:@"%zd",self.CorpID];//除酒店传酒店ID、婚庆公司传婚庆ID、其他传供应商ID
    }else{
        params[@"TypeID"] =[NSString stringWithFormat:@"%zd",self.SupplierID];//除酒店传酒店ID、婚庆公司传婚庆ID、其他传供应商ID
    }
    
    params[@"CollectorsType"]  = @"0";//0用户端、1公司端
    params[@"CollectorsID"]   = myID;
    if ([shoucangType isEqualToString:@"0"]) {
        params[@"Start"]   = @"0";//0添加、1删除
    }else{
        params[@"Start"]   = @"1";//0添加、1删除
    }
    
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"%@",object);
            
            if ([shoucangType isEqualToString:@"0"]) {
                shoucangType =@"1";
                [EasyShowTextView showText:@"收藏成功"];
            }else{
                shoucangType =@"0";
                [EasyShowTextView showText:@"取消收藏成功"];
            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
            
        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

//动态计算label高度
- (CGFloat )getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
    
}

@end
