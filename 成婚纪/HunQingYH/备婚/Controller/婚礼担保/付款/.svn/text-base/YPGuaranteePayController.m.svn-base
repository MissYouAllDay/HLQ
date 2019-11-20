//
//  YPGuaranteePayController.m
//  HunQingYH
//
//  Created by Else丶 on 2017/12/18.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPGuaranteePayController.h"
#import "YPGuaranteeHeaderCell.h"
#import "YPGuaranteeSelectCell.h"
#import "YPGuaranteeFooterCell.h"

@interface YPGuaranteePayController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger price;
@property (nonatomic, strong) UIButton *allBtn;
@property (nonatomic, strong) UIButton *halfBtn;
@property (nonatomic, strong) UIButton *threeBtn;

@end

@implementation YPGuaranteePayController{
    UIView *_navView;
    
    UIView *view;
    UIView *line;
    UILabel *label1;
    UILabel *label2;
    UIButton *sureBtn;
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

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setupNav];
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
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
    titleLab.text = @"付款";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
    
    [self setupBottomView];
}

- (void)setupBottomView{
    
    if (!view) {
        view = [[UIView alloc]init];
    }
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    if (!line) {
        line = [[UIView alloc]init];
    }
    line.backgroundColor = LightGrayColor;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1);
    }];
    
    if (!label1) {
        label1 = [[UILabel alloc]init];
    }
    label1.text = @"需支付";
    [view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(view);
    }];
    
    if (!label2) {
        label2 = [[UILabel alloc]init];
    }
    label2.text = [NSString stringWithFormat:@"¥ %zd",self.price];
    label2.textColor = RGB(255, 80, 1);
    [view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(view);
    }];
    
    if (!sureBtn) {
        sureBtn = [[UIButton alloc]init];
    }
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:RGB(255, 80, 1)];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(view);
        make.width.mas_equalTo(105);
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return 3;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        YPGuaranteeHeaderCell *cell = [YPGuaranteeHeaderCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        
        YPGuaranteeSelectCell *cell = [YPGuaranteeSelectCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"全额支付";
            cell.priceLabel.text = @"32000";
            self.allBtn = cell.selectBtn;
        }else if (indexPath.row == 1){
            cell.titleLabel.text = @"全额的1/2支付";
            cell.priceLabel.text = @"16000";
            self.halfBtn = cell.selectBtn;
        }else if (indexPath.row == 2){
            cell.titleLabel.text = @"全额的1/3支付";
            cell.priceLabel.text = @"10666";
            self.threeBtn = cell.selectBtn;
        }
        
        cell.selectBtn.tag = indexPath.row + 1000;
        [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else {
        
        YPGuaranteeFooterCell *cell = [YPGuaranteeFooterCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentLabel.attributedText = [self getAttributedStringWithString:@"当您确定合作的婚庆公司后，因婚庆前期采购、预定相关的项目需要资金费用，为减轻婚庆公司的压力，故建议将大部分资金直接支付给婚庆公司，将总金额的1/3留在平台作为担保金，具体支付方式以双方实际协商为主，本平台仅作为担保，婚礼结束第二天即会按照合同进行资金划拨。" lineSpace:10.0];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = CHJ_bgColor;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - label设置行间距
-(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectBtnClick:(UIButton *)sender{
    
    if (sender.tag == 1000) {
        self.allBtn.selected = !self.allBtn.selected;
        self.halfBtn.selected = NO;
        self.threeBtn.selected = NO;
        self.price = 32000;
    }else if (sender.tag == 1001){
        self.allBtn.selected = NO;
        self.halfBtn.selected = !self.halfBtn.selected;
        self.threeBtn.selected = NO;
        self.price = 16000;
    }else if (sender.tag == 1002){
        self.allBtn.selected = NO;
        self.halfBtn.selected = NO;
        self.threeBtn.selected = !self.threeBtn.selected;
        self.price = 10666;
    }
    
    [self setupBottomView];
}

- (void)sureBtnClick{
    NSLog(@"sureBtnClick");
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
