//
//  YPHYTHGiftImgListController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/18.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHGiftImgListController.h"
#import "YPHunJJSponsorImgCell.h"
#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"

@interface YPHYTHGiftImgListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YPHYTHGiftImgListController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    [self GetPreferentialCommodityInfo];
}

- (void)viewWillDisappear:(BOOL)animated{
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

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.left.mas_equalTo(_navView.mas_left).mas_offset(10);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imgArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPHunJJSponsorImgCell *cell = [YPHunJJSponsorImgCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *str = self.imgArr[indexPath.row];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = self.imgArr[indexPath.row];
    /**
     *  参数1:图片URL
     *  参数2:imageView 宽度
     *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
     */
    
    return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:200];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
