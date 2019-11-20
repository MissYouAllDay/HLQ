//
//  YPFADetailController.m
//  hunqing
//
//  Created by YanpengLee on 2017/7/10.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPFADetailController.h"

#import "YPFADetailDescCell.h"
#import "YPBLDetailHeaderImgCell.h"
#import "YPFATagCell.h"
#import "YPPlanInfoDetailed.h"
#import "YPPlanSoldInfo.h"

#import "DemoVC1Cell.h"
#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"
static NSString *const cellId = @"DemoVC1Cell";


#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAVIGATION_BAR_HEIGHT*2)
#define IMAGE_HEIGHT 200
@interface YPFADetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *backView;

///模型
@property (nonatomic, strong) YPPlanInfoDetailed *detailInfo;


@end

@implementation YPFADetailController{
    UIView *_navView;
    UIButton *_backBtn;
    UILabel *_titleLabel;

}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self PlanInfoDetailed];

    
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //    self.tableView.estimatedRowHeight = 80;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    //7.14 暂时隐藏 -- 接口没有
    //    UIButton *shoucang = [[UIButton alloc]init];
    //    [shoucang setTitle:@"收藏" forState:UIControlStateNormal];
    //    [shoucang setTitleColor:GrayColor forState:UIControlStateNormal];
    //    [shoucang setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //    [shoucang setImage:[UIImage imageNamed:@"收藏A"] forState:UIControlStateNormal];
    //    [shoucang setImage:[UIImage imageNamed:@"收藏B"] forState:UIControlStateSelected];
    //    [shoucang setBackgroundColor:WhiteColor];
    //    [shoucang addTarget:self action:@selector(shoucangClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [view addSubview:shoucang];
    //    [shoucang mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.left.bottom.mas_equalTo(view);
    //        make.width.mas_equalTo(ScreenWidth/2.0);
    //    }];
    //    if (self.isCollected == YES) {
    //        shoucang.selected = YES;
    //    }
   
    
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
    
    NSArray *arr = [self.detailInfo.Imgs componentsSeparatedByString:@","];
    if (self.detailInfo.Imgs.length > 0) {
        return 4 + arr.count;
    }else{
        return 4;
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
        title.text = self.detailInfo.PlanTitle;
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
        title.text = self.detailInfo.PlanKeyWord;
        title.font = kNormalFont;
        title.textColor = RGB(151, 160, 170);
        title.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(cell.contentView);
            make.top.mas_equalTo(cell.contentView).mas_offset(5);
            make.bottom.mas_equalTo(cell.contentView).mas_offset(-5);
        }];
        
        UILabel *count = [[UILabel alloc]init];
        count.text = [NSString stringWithFormat:@"%@积分",self.detailInfo.PlanIntegral];
        count.font = kNormalFont;
        count.textColor = [UIColor redColor];
        //        [cell.contentView addSubview:count];
        //        [count mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.mas_equalTo(-15);
        //            make.centerY.mas_equalTo(title);
        //            make.top.mas_greaterThanOrEqualTo(cell.contentView).mas_offset(5);
        //            make.bottom.mas_greaterThanOrEqualTo(cell.contentView).mas_offset(-5);
        //        }];
        return cell;
        
    }else if (indexPath.row == 2){
        YPFATagCell *cell = [YPFATagCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.detailInfo.AttState.length == 0) {
            
            cell.tag1.hidden = YES;
            cell.tag2.hidden = YES;
            cell.tag3.hidden = YES;
            cell.tag4.hidden = YES;
            
            cell.noLabel.hidden = NO;
            
            return cell;
        }else{
            
            cell.noLabel.hidden = YES;
            
            cell.planList = self.detailInfo;
            
            UIView *line = [[UIView alloc]init];
            line.backgroundColor = CHJ_bgColor;
            [cell.contentView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(cell.contentView);
                make.height.mas_equalTo(1);
            }];
            return cell;
        }
    }else if (indexPath.row == 3){
        YPFADetailDescCell *cell = [YPFADetailDescCell cellWithTableView:tableView];
        cell.descLabel.text = self.detailInfo.PlanContent;
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
        
        NSArray *arr = [self.detailInfo.Imgs componentsSeparatedByString:@","];
        NSString *str = arr[indexPath.row - 4];
        
        cell.imgStr =str;
        
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
        
        
        //        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //
        //
        //
        //        }];
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 60;
    }else if (indexPath.row==1){
        return 40;
    }else if (indexPath.row==2){
        return 40;
    }else if (indexPath.row==3){
        return [self getHeighWithTitle: self.detailInfo.PlanContent font:kFont(17) width:ScreenWidth]+50;
    }else{
        NSArray *arr = [self.detailInfo.Imgs componentsSeparatedByString:@","];
        NSString *str = arr[indexPath.row - 4];
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
        _titleLabel.text = self.detailInfo.PlanTitle;
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
- (void)PlanInfoDetailed{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/Corp/ ";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"EmployeeID"]  = UserId_New;
    params[@"PlanID"]      = self.planID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.detailInfo.PlanID          = [object valueForKey:@"PlanID"];
            self.detailInfo.EmployeeID      = [object valueForKey:@"EmployeeID"];
            self.detailInfo.CorpID          = [object valueForKey:@"CorpID"];
            self.detailInfo.EmployeeName    = [object valueForKey:@"EmployeeName"];
            self.detailInfo.CorpName        = [object valueForKey:@"CorpName"];
            self.detailInfo.PlanTitle       = [object valueForKey:@"PlanTitle"];
            self.detailInfo.PlanKeyWord     = [object valueForKey:@"PlanKeyWord"];
            self.detailInfo.ShowImg         = [object valueForKey:@"ShowImg"];
            self.detailInfo.PlanContent     = [object valueForKey:@"PlanContent"];
            self.detailInfo.Color           = [object valueForKey:@"Color"];
            self.detailInfo.Imgs            = [object valueForKey:@"Imgs"];
            self.detailInfo.PlanType        = [object valueForKey:@"PlanType"];
            self.detailInfo.PlanIntegral    = [object valueForKey:@"PlanIntegral"];
            self.detailInfo.Status          = [object valueForKey:@"Status"];
            self.detailInfo.RejectedWhy     = [object valueForKey:@"RejectedWhy"];
            self.detailInfo.AttID           = [object valueForKey:@"AttID"];
            self.detailInfo.CreateTime      = [object valueForKey:@"CreateTime"];
            self.detailInfo.Number          = [object valueForKey:@"Number"];
            self.detailInfo.NumPlanIntegral = [object valueForKey:@"NumPlanIntegral"];
            self.detailInfo.AttState        = [object valueForKey:@"AttState"];
            
            self.detailInfo.Data = [YPPlanSoldInfo mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [self.tableView reloadData];
            
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
        }
        
    } Failure:^(NSError *error) {
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    }];
    
}




#pragma mark - getter

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _backView;
}

- (YPPlanInfoDetailed *)detailInfo{
    if (!_detailInfo) {
        _detailInfo = [[YPPlanInfoDetailed alloc]init];
    }
    return _detailInfo;
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
