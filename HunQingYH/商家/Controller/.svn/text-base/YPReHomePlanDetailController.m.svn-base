//
//  YPReHomePlanDetailController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomePlanDetailController.h"
#import "YPFADetailDescCell.h"
#import "YPBLDetailHeaderImgCell.h"
#import "YPGetPlanInfo.h"//方案详情模型

#import "DemoVC1Cell.h"
#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"
static NSString *const cellId = @"DemoVC1Cell";


#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAVIGATION_BAR_HEIGHT*2)
#define IMAGE_HEIGHT 200

@interface YPReHomePlanDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

/**
 首页 热门方案 - 1-8
 */
@property (nonatomic, strong) YPGetPlanInfo *planInfo;

@end

@implementation YPReHomePlanDetailController{
    UIView *_navView;
    UIButton *_backBtn;
    UILabel *_titleLabel;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetPlanInfo];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    [[UIApplication sharedApplication] keyWindow].backgroundColor = WhiteColor;
    
    [self setupNav];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //    self.tableView.estimatedRowHeight = 80;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.backgroundColor = bgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    [self.view addSubview:self.tableView];
    
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor =  WhiteColor;
    [self.view addSubview:_navView];
    //设置导航栏左边通知
    _backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    _titleLabel  = [[UILabel alloc]init];
    _titleLabel.text = @"";
    _titleLabel.textColor = WhiteColor;
    [_titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_backBtn);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *arr = [self.planInfo.Imgs componentsSeparatedByString:@","];
    if (self.planInfo.Imgs.length > 0) {
        return 3 + arr.count;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        UILabel *title = [[UILabel alloc]init];
        if (self.planInfo.PlanTitle.length > 0) {
            title.text = self.planInfo.PlanTitle;
        }else{
            title.text = @"当前无标题";
        }
        title.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
        title.textColor = BlackColor;
        title.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(cell.contentView);
            make.top.mas_equalTo(cell.contentView).mas_offset(30);
            make.bottom.mas_equalTo(cell.contentView).mas_offset(-10);
        }];
        return cell;
        
    }else if (indexPath.row == 1) {
        
        UILabel *title = [[UILabel alloc]init];
        if (self.planInfo.PlanKeyWord.length > 0) {
            title.text = self.planInfo.PlanKeyWord;
        }else{
            title.text = @"当前无关键字";
        }
        title.font = kNormalFont;
        title.textColor = RGB(151, 160, 170);
        title.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(cell.contentView);
            make.top.mas_equalTo(cell.contentView).mas_offset(5);
            make.bottom.mas_equalTo(cell.contentView).mas_offset(-5);
        }];
        
        return cell;
        
    }else if (indexPath.row == 2){
        
        YPFADetailDescCell *cell = [YPFADetailDescCell cellWithTableView:tableView];
        if (self.planInfo.PlanContent.length > 0) {
            cell.descLabel.text = self.planInfo.PlanContent;
        }else{
            cell.descLabel.text = @"当前无内容";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        //
        //        YPBLDetailHeaderImgCell *cell = [YPBLDetailHeaderImgCell cellWithTableView:tableView];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        NSArray *arr = [self.detailInfo.Imgs componentsSeparatedByString:@","];
        //        NSString *str = arr[indexPath.row - 4];
        //        [cell.backImgV sd_setImageWithURL:[NSURL URLWithString:str]];
        //        cell.imgStr = str;
        //        return cell;
        
        DemoVC1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell)
        {
            cell = [[DemoVC1Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        NSArray *arr = [self.planInfo.Imgs componentsSeparatedByString:@","];
        NSString *str = arr[indexPath.row - 3];
        
        cell.imgStr =str;
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str]  placeholderImage:[UIImage imageNamed:@"图片占位图"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            /**
             *  缓存image size
             */
            [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {

                //reload row
                if(result)  [tableView  xh_reloadRowAtIndexPath:indexPath forURL:imageURL];

            }];
        }];
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 60;
    }else if (indexPath.row==1){
        return 40;
    }else if (indexPath.row==2){
        //        return 40;
        //    }else if (indexPath.row==3){
        return [self getHeighWithTitle: self.planInfo.PlanContent font:kFont(17) width:ScreenWidth]+50;
    }else{
        NSArray *arr = [self.planInfo.Imgs componentsSeparatedByString:@","];
        NSString *str = arr[indexPath.row - 3];
        /**
         *  参数1:图片URL
         *  参数2:imageView 宽度
         *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
         */

        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width-16 estimateHeight:200];
    }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAVIGATION_BAR_HEIGHT;
        _navView.backgroundColor = NavBarColor;
        [_backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
        _navView.alpha = alpha;
//        _titleLabel.text = self.planList.PlanTitle;
    }
    else
    {
        _titleLabel.text = @"";
        _navView.backgroundColor = WhiteColor;
        [_backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
        _navView.alpha = 1.0;
    }
}

#pragma mark - 网络请求
#pragma mark 查看方案详细信息
- (void)GetPlanInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/User/GetPlanInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PlanID"] = self.planID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            self.planInfo.PlanID        = [object objectForKey:@"PlanID"];
            self.planInfo.PlanTitle     = [object objectForKey:@"PlanTitle"];
            self.planInfo.PlanKeyWord   = [object objectForKey:@"PlanKeyWord"];
            self.planInfo.ShowImg       = [object objectForKey:@"ShowImg"];
            self.planInfo.PlanContent   = [object objectForKey:@"PlanContent"];
            self.planInfo.Color         = [object objectForKey:@"Color"];
            self.planInfo.Imgs          = [object objectForKey:@"Imgs"];
            
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
- (YPGetPlanInfo *)planInfo{
    if (!_planInfo) {
        _planInfo = [[YPGetPlanInfo alloc]init];
    }
    return _planInfo;
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
