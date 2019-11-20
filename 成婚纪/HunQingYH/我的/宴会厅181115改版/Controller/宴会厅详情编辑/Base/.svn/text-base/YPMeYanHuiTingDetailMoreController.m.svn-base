//
//  YPMeYanHuiTingDetailMoreController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/20.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPMeYanHuiTingDetailMoreController.h"
#import "YPGetHotelBanquetlInfo.h"
#import "YPMeTingDetailMoreInfoCell.h"
#import "YPMeTingDetailMoreImgsCell.h"
#import "YPMeTingInfoEditController.h"//信息编辑
#import "YPMeTingImgsEditController.h"//相册编辑
#import "YPInviteFriendsWedNormalShareView.h"

@interface YPMeYanHuiTingDetailMoreController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIControl *control;

@property(nonatomic,strong) NSMutableArray *mImages;//图片
@property (nonatomic, strong) YPGetHotelBanquetlInfo *infoModel;

@end

@implementation YPMeYanHuiTingDetailMoreController{
    UIView *_navView;
    YPInviteFriendsWedNormalShareView *_shareView;
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
    [backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"宴会厅详情";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setImage:[UIImage imageNamed:@"三个点"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn);
    }];
    
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        YPMeTingDetailMoreInfoCell *cell = [YPMeTingDetailMoreInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.infoModel.BanquetHallName.length > 0) {
            cell.tingName.text = self.infoModel.BanquetHallName;
        }else{
            cell.tingName.text = @"无名称";
        }
        cell.tableCount.text = [NSString stringWithFormat:@"最多容纳%zd桌",self.infoModel.MaxTableCount.integerValue];
        cell.mianji.text = [NSString stringWithFormat:@"%.2f㎡",self.infoModel.Acreage.floatValue];
        cell.cenggao.text = [NSString stringWithFormat:@"%.2fm",self.infoModel.Height.floatValue];
        cell.whLabel.text = [NSString stringWithFormat:@"%.2fm·%.2fm",self.infoModel.Length.floatValue,self.infoModel.Width.floatValue];
        [cell.editBtn addTarget:self action:@selector(infoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        YPMeTingDetailMoreImgsCell *cell = [YPMeTingDetailMoreImgsCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imgArr = self.mImages.copy;
        cell.imgCount.text = [NSString stringWithFormat:@"(%zd)",self.mImages.count];
        [cell.editBtn addTarget:self action:@selector(imgsBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"moreBtnClick");
    [self.view addSubview:self.control];
}

- (void)infoBtnClick{
    YPMeTingInfoEditController *info = [[YPMeTingInfoEditController alloc]init];
    info.BanquetID = self.BanquetID;
    info.infoModel = self.infoModel;
    [self.navigationController pushViewController:info animated:YES];
}

- (void)imgsBtnClick{
    YPMeTingImgsEditController *imgs = [[YPMeTingImgsEditController alloc]init];
    imgs.BanquetID = self.BanquetID;
    NSMutableArray *imgsMarr = [NSMutableArray array];
    for (NSString *img in self.mImages) {
        NSData* imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
        UIImage* resultImage2 = [UIImage imageWithData: imageData2];
        [imgsMarr addObject:resultImage2];
    }
    imgs.upfmArray = imgsMarr;
    [self.navigationController pushViewController:imgs animated:YES];
}

- (void)controlClick{
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _shareView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 160);
    } completion:^(BOOL finished) {
        [self.control removeFromSuperview];
    }];
}

- (void)deleteBtnClick{
    [self DeleteHotelBanquetl];
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
            
            self.infoModel.MinTableCount = [object objectForKey:@"MinTableCount"];
            self.infoModel.Acreage = [object objectForKey:@"Acreage"];
            self.infoModel.Length = [object objectForKey:@"Length"];
            self.infoModel.Width = [object objectForKey:@"Width"];
            self.infoModel.Height = [object objectForKey:@"Height"];
            self.infoModel.TypeContent = [object objectForKey:@"TypeContent"];
            self.infoModel.HotelName = [object objectForKey:@"HotelName"];
            
            [self.mImages removeAllObjects];
            for (YPGetFacilitatorInfoImgData *img in self.infoModel.Data) {
                [self.mImages addObject:img.ImgUrl];
            }
            
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

- (NSMutableArray *)mImages{
    if (!_mImages) {
        _mImages = [NSMutableArray array];
        
    }
    return _mImages;
}

- (UIControl *)control{
    if (!_control) {
        _control = [[UIControl alloc]initWithFrame:self.view.frame];
        _control.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        if (!_shareView) {
            _shareView = [YPInviteFriendsWedNormalShareView yp_InviteFriendsWedNormalShareView];
            _shareView.backgroundColor = WhiteColor;
            [_shareView.btnImgV setImage:[UIImage imageNamed:@"ting_delete"]];
            _shareView.btnLabel.text = @"删除宴会厅";
            [_shareView.wechatBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [_shareView.cancleBtn addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    _shareView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 160);

    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _shareView.frame = CGRectMake(0, ScreenHeight-160-HOME_INDICATOR_HEIGHT, ScreenWidth, 160);
        [_control addSubview:_shareView];
    } completion:nil];
    [_control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    return _control;
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
