//
//  YPOurNewWedsScreenController.m
//  HunQingYH
//
//  Created by Else丶 on 2017/12/12.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPOurNewWedsScreenController.h"

@interface YPOurNewWedsScreenController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic, assign) NSInteger selectType;

@end

@implementation YPOurNewWedsScreenController{
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

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNav];
    [self setupUI];
    
}

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
    titleLab.text = @"LED大屏幕";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //设置导航栏右边
    UIButton *doneBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"保存" forState:UIControlStateNormal];
    [doneBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.right.mas_equalTo(-15);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"不需要";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"需要";
    }
    
    if ([self.selectedIndexPath isEqual:indexPath]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectedIndexPath) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.selectedIndexPath = indexPath;
    
    self.selectType = self.selectedIndexPath.row + 1000;
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneBtnClick{
    NSLog(@"doneBtnClick");
    
    if (self.selectType > 0) {
        [self UpNewPeoplePublic];
    }else{

        [EasyShowTextView showText:@"请选择是否需要全面屏"];
    }
}

#pragma mark 修改新人公共问题
- (void)UpNewPeoplePublic{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpNewPeoplePublic";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"NewPeopleCustomID"] = self.peopleCustomID;
    params[@"UpType"] = @"3";//1酒店,2婚期,3led ,4邀请码,5预算,6特别说明
    params[@"Budget"] = @"333";//不修改 随便传
    params[@"WeddingDay"] = @"";
    params[@"HotelName"] = @"";
    params[@"HotelAddress"] = @"";
    params[@"HallName"] = @"";
    params[@"TableCount"] = @"333";//不修改 随便传
    params[@"RummeryImg"] = @"";
    params[@"RummeryXls"] = @"";
    params[@"IsLEDScreen"] = [NSString stringWithFormat:@"%ld",self.selectType-1000];//0不需要,1需要
    params[@"InvitationCode"] = @"";
    params[@"SpecialVersion"] = @"";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@""];
            
            if ([self.screenDelegate respondsToSelector:@selector(yp_screen)]) {
                [self.navigationController popViewControllerAnimated:YES];
                [self.screenDelegate yp_screen];
            }
            
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
