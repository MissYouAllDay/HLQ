//
//  YPMyCarController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/16.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMyCarController.h"
#import "YPMyCarTextCell.h"
#import "YPMyCarJianJieImgCell.h"
#import "YPEditMyCarController.h"//修改资料
#import "YPGetCarModel.h"

@interface YPMyCarController ()<UITableViewDelegate,UITableViewDataSource,YPEditMyCarDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImage *iconImg;

@property (nonatomic, copy) NSString *carBrand;
@property (nonatomic, copy) NSString *carType;
@property (nonatomic, copy) NSString *carColor;
@property (nonatomic, copy) NSString *carBrandID;
@property (nonatomic, copy) NSString *carTypeID;

@property (nonatomic, strong) YPGetCarModel *dataModel;

@end

@implementation YPMyCarController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
    
    [self GetCarModel];
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"我的车辆";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.mas_equalTo(_navView).mas_offset(15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"修改" forState:UIControlStateNormal];
    [moreBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        YPMyCarJianJieImgCell *cell = [YPMyCarJianJieImgCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"展示";
        
//        if (!self.iconImg) {
//            cell.iconImgV.image = [UIImage imageNamed:@"占位图"];
//        }else{
//            cell.iconImgV.image = self.iconImg;
//        }

        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.dataModel.CarImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
        
//        if (self.dataModel.CarImg.length > 0) {
//            self.iconImg = cell.iconImgV.image;
//        }
        
        return cell;
        
    }else{
        
        YPMyCarTextCell *cell = [YPMyCarTextCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"品牌";
            if (self.carBrand.length > 0) {
                cell.descLabel.text = self.carBrand;
            }else{
                cell.descLabel.text = @"未选择品牌";
            }
        }else if (indexPath.row == 2) {
            cell.titleLabel.text = @"型号";
            if (self.carType.length > 0) {
                cell.descLabel.text = self.carType;
            }else{
                cell.descLabel.text = @"未选择型号";
            }
        }else if (indexPath.row == 3) {
            cell.titleLabel.text = @"颜色";
            if (self.carColor.length > 0) {
                cell.descLabel.text = self.carColor;
            }else{
                cell.descLabel.text = @"未选择颜色";
            }
        }
        
        return cell;
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
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
    NSLog(@"修改");
    
    YPEditMyCarController *edit = [[YPEditMyCarController alloc]init];
    edit.editDelegate = self;
    if (self.iconImg) {
        [edit.iconImgs addObject:self.iconImg];
    }
    if (self.carBrand.length > 0) {
        edit.carBrand = self.carBrand;
        edit.carBrandID = self.carBrandID;
    }
    if (self.carType.length > 0) {
        edit.carType = self.carType;
        edit.carTypeID = self.carTypeID;
    }
    if (self.carColor.length > 0) {
        edit.carColor = self.carColor;
    }
    [self.navigationController yp_pushViewController:edit animated:YES];
}

#pragma mark - YPEditMyCarDelegate
//- (void)editMyCarWithImg:(UIImage *)img Pinpai:(NSString *)pinpai PinPaiID:(NSString *)pinpaiID Xinghao:(NSString *)xinghao XingHaoID:(NSString *)xinghaoID Color:(NSString *)color{
//    
//    NSLog(@"%@-%@-%@-%@-%@-%@",img,pinpai,xinghao,pinpaiID,xinghaoID,color);
//    
//    self.iconImg = img;
//    self.carBrand = pinpai;
//    self.carBrandID = pinpaiID;
//    self.carType = xinghao;
//    self.carTypeID = xinghaoID;
//    self.carColor = color;
//    
//    [self.tableView reloadData];
//    
//}

- (void)editMyCarWithCarModelID:(NSString *)carModelID{
    
    self.carModelID = carModelID;
    
    [self GetCarModel];
}

#pragma mark - 网络请求
#pragma mark 获取品牌/型号
- (void)GetCarModel{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetCarModel";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSLog(@"modelid -- %@",self.carModelID);
    params[@"CarModelID"] = self.carModelID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            self.dataModel.BrandID = [object valueForKey:@"BrandID"];
            self.dataModel.BrandName = [object valueForKey:@"BrandName"];
            self.dataModel.Name = [object valueForKey:@"Name"];
            self.dataModel.CarImg = [object valueForKey:@"CarImg"];
            self.dataModel.Color = [object valueForKey:@"Color"];
            
            self.dataModel.ID = [object valueForKey:@"ID"];//新加

            self.carColor = self.dataModel.Color;
            NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.dataModel.CarImg]];
            self.iconImg = [UIImage imageWithData: imageData];
            self.carType = self.dataModel.Name;//型号
            self.carBrand = self.dataModel.BrandName;
            
            self.carBrandID = self.dataModel.BrandID;
            
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

#pragma mark - getter
- (YPGetCarModel *)dataModel{
    if (!_dataModel) {
        _dataModel = [[YPGetCarModel alloc]init];
    }
    return _dataModel;
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
