//
//  YPYHTDetailController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/3.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPYHTDetailController.h"
#import "YPYHTDetailTextCell.h"
#import "YPHotelTingImgsCell.h"
#import "YPGetHotelBanquetlInfo.h"
#import "YPAddYanHuiTingController.h"
#import "HRAddYanHuiTingController.h"

@interface YPYHTDetailController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YPGetHotelBanquetlInfo *infoModel;

@end

@implementation YPYHTDetailController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetHotelBanquetlInfo];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
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
    titleLab.text = @"宴会厅管理";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo( backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
  
    
    //设置导航栏右边
    UIButton *addBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"三个点"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        YPYHTDetailTextCell *cell = [YPYHTDetailTextCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"宴会厅名";
            cell.descLabel.text = self.infoModel.BanquetHallName;
        }else if (indexPath.row == 1) {
            cell.titleLabel.text = @"最低价位";
            cell.descLabel.text = [NSString stringWithFormat:@"%@",self.infoModel.FloorPrice];
        }else if (indexPath.row == 2) {
            cell.titleLabel.text = @"容纳桌数";
            cell.descLabel.text = [NSString stringWithFormat:@"%@",self.infoModel.MaxTableCount];
        }
        return cell;
        
    }else if (indexPath.section == 1){
        
        NSMutableArray *marr = [NSMutableArray array];
        for (YPGetFacilitatorInfoImgData *img in self.infoModel.Data) {
            [marr addObject:img.ImgUrl];
        }
        
        if (marr.count > 0) {
            YPHotelTingImgsCell *cell = [YPHotelTingImgsCell cellWithTableView:tableView];
        
            cell.imgArr = marr.copy;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.textLabel.text = @"当前没有图片";
            return cell;
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBtnClick{
    NSLog(@"addBtnClick");
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑",@"删除", nil];
    [sheet showInView:self.view];

}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"编辑");
        HRAddYanHuiTingController *addVC = [HRAddYanHuiTingController new];
        addVC.leixingStr =@"2";
        addVC.tingName =self.infoModel.BanquetHallName;
        addVC.lowestPrice =[self.infoModel.FloorPrice floatValue];
        addVC.tableNum =[self.infoModel.MaxTableCount integerValue];
        addVC.BanquetID =self.infoModel.BanquetID ;
        
             NSLog(@"%@",self.infoModel);
        NSMutableArray *fmarr = [NSMutableArray array];
        NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.infoModel.HotelLogo]];
        UIImage* resultImage = [UIImage imageWithData: imageData];
        [fmarr addObject:resultImage];
        addVC.upfmArray =fmarr;
   
        if (self.infoModel.Data.count > 0) {//有图
            NSMutableArray *xiangcearr = [NSMutableArray array];
            
            for (YPGetFacilitatorInfoImgData *img in self.infoModel.Data) {
                NSData* imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:img.ImgUrl]];
                UIImage* resultImage2 = [UIImage imageWithData: imageData2];
                [xiangcearr addObject:resultImage2];
            }
            
            addVC.upXCArray =xiangcearr;
        }
        

        [self.navigationController presentViewController:addVC animated:YES completion:nil];
        
    }else if (buttonIndex == 1){
        NSLog(@"删除");
        
        [self DeleteHotelBanquetl];
    }
}

#pragma mark - 网络请求
#pragma mark 根据宴会厅id获取宴会厅详情
- (void)GetHotelBanquetlInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetHotelBanquetlInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.BanquetID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.infoModel.BanquetID = [object objectForKey:@"BanquetID"];
            self.infoModel.BanquetHallName = [object objectForKey:@"BanquetHallName"];
            self.infoModel.FloorPrice = [object objectForKey:@"FloorPrice"];
            self.infoModel.MaxTableCount = [object objectForKey:@"MaxTableCount"];
            self.infoModel.HotelLogo = [object objectForKey:@"HotelLogo"];
            self.infoModel.FacilitatorId = [object objectForKey:@"FacilitatorId"];
            
            //18-11-19
            self.infoModel.Data = [YPGetFacilitatorInfoImgData mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark 删除宴会厅
- (void)DeleteHotelBanquetl{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/DeleteHotelBanquetl";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.BanquetID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"删除宴会厅成功!"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark - getter
- (YPGetHotelBanquetlInfo *)infoModel{
    if (!_infoModel) {
        _infoModel = [[YPGetHotelBanquetlInfo alloc]init];
    }
    return _infoModel;
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
