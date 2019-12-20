//
//  YPHYTHRefundController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/14.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHRefundController.h"
#import "YPHYTHRefundOrderInfoCell.h"
#import "YPAddRemarkController.h"//申请原因
#import "YPHYTHRefundSucController.h"

@interface YPHYTHRefundController ()<UITableViewDelegate,UITableViewDataSource,YPAddRemarkDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *remark;

@end

@implementation YPHYTHRefundController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    [self GetPreferentialOrderDetailsInfo];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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

#pragma mark - UI
- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50-HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = ClearColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    [self createBottomView];
    
}

- (void)createBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50-HOME_INDICATOR_HEIGHT, ScreenWidth,50)];
    bottomView.backgroundColor = WhiteColor;
    [self.view addSubview:bottomView];
    
    UIView *colorView = [[UIView alloc] init];
    [colorView setFrame:CGRectMake(ScreenWidth-125,0, 125, 50)];
    [bottomView addSubview:colorView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = colorView.bounds;
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.colors = @[(__bridge id)[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0].CGColor];
    [colorView.layer addSublayer:gradient];
    
    UIButton *submitBtn = [[UIButton alloc]init];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.frame = colorView.frame;
    [bottomView addSubview:submitBtn];
    
}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
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
    titleLab.text = @"退款";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        YPHYTHRefundOrderInfoCell *cell = [YPHYTHRefundOrderInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        if (self.Name.length > 0) {
            cell.tingName.text = self.Name;
        }else{
            cell.tingName.text = @"无名称";
        }
        cell.canbiao.text = [NSString stringWithFormat:@"¥%@/桌起",self.MealAmount];
        cell.tableCount.text = [NSString stringWithFormat:@"%@桌",self.TableNumber];
        cell.realMoney.text = [NSString stringWithFormat:@"¥%@",self.PaymentAmount];
        return cell;
    }else if (indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = RGBA(245, 245, 245, 1);
        [cell.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(18);
            make.right.bottom.mas_equalTo(-18);
            make.height.mas_equalTo(120);
        }];
        UILabel *remark = [[UILabel alloc]init];
        CGFloat height = [self getHeighWithTitle:@"请描述申请退款服务的具体原因…" font:[UIFont systemFontOfSize:13] width:ScreenWidth-36*2];
        if (self.remark.length > 0) {
            remark.text = self.remark;
            remark.textColor = RGBS(51);
            height = [self getHeighWithTitle:self.remark font:[UIFont systemFontOfSize:13] width:ScreenWidth-36*2] > (120-36) ? (120-36) : [self getHeighWithTitle:self.remark font:[UIFont systemFontOfSize:13] width:ScreenWidth-36*2];
        }else{
            remark.text = @"请描述申请退款服务的具体原因…";
            remark.textColor = RGBS(199);
        }
        remark.font = kFont(13);
        remark.numberOfLines = 0;
        remark.lineBreakMode = NSLineBreakByCharWrapping;
        [view addSubview:remark];
        [remark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(18);
            make.right.mas_equalTo(-18);
            //            make.height.mas_equalTo(height);
            make.bottom.mas_lessThanOrEqualTo(-15);
        }];
        return cell;
        
    }else if (indexPath.section == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [NSString stringWithFormat:@"¥%@",self.PaymentAmount];
        cell.textLabel.font = kFont(13);
        cell.textLabel.textColor = RGBS(51);
        [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.right.bottom.mas_equalTo(-18);
            make.top.mas_equalTo(5);
        }];
        return cell;
    }else if (indexPath.section == 3){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"所付钱款将退回到您的婚礼桥账户，请前往 “我的—我的钱包” 查看";
        cell.textLabel.font = kFont(13);
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.textLabel.textColor = RGBS(51);
        [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.right.bottom.mas_equalTo(-18);
            make.top.mas_equalTo(5);
        }];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 15];
        label.textColor = RGBS(51);
        if (section == 1) {
            label.text = @"申请原因";
        }else if (section == 2) {
            label.text = @"退款金额";
        }else if (section == 3) {
            label.text = @"退款方式";
        }
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view);
            make.left.mas_equalTo(18);
        }];
        return view;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        YPAddRemarkController *addRemark = [[YPAddRemarkController alloc]init];
        addRemark.remarkDelegate = self;
        
        addRemark.titleStr = @"申请原因";
        addRemark.placeHolder = @"请填写申请退款原因";
        addRemark.limitCount = 150;
        addRemark.editRemark = self.remark;
        [self.navigationController pushViewController:addRemark animated:YES];
    }
    
}

#pragma mark - YPAddRemarkDelegate
- (void)addRemark:(NSString *)remark{
    self.remark = remark;
    [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitBtnClick{
    [self UpdatePreferentialOrderRefundApplyType];
}

#pragma mark - 网络请求
#pragma mark 特惠商品申请退款
- (void)UpdatePreferentialOrderRefundApplyType{
    
    NSString *url = @"/api/HQOAApi/UpdatePreferentialOrderRefundApplyType";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = self.Id;
    params[@"RefundApply"] = @"1";//0不申请,1申请退款
    params[@"Meno"] = self.remark;

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
//            [EasyShowTextView showText:@"申请退款成功!" inView:self.tableView];
            YPHYTHRefundSucController *suc = [[YPHYTHRefundSucController alloc]init];
            [self.navigationController pushViewController:suc animated:YES];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
