//
//  YPNewWedsOtherSelectController.m
//  HunQingYH
//
//  Created by Else丶 on 2017/12/11.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPNewWedsOtherSelectController.h"
#import "YPImgSelectCell.h"
#import "YPImgTitleInputTWCell.h"
#import "YPNewWedsSelectTypeListController.h"//选项类型

@interface YPNewWedsOtherSelectController ()<UITableViewDelegate,UITableViewDataSource,YPSelectTypeListDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *typeStr;
@property (nonatomic, strong) UITextView *inputTW;

@end

@implementation YPNewWedsOtherSelectController{
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
    titleLab.text = self.titleStr;
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
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
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
    
    
    if (indexPath.row == 0) {
        YPImgSelectCell *cell = [YPImgSelectCell cellWithTableView:tableView];
        
        if (self.selectStr.length > 0) {
            if (self.typeStr.length > 0) {
                cell.titleLabel.text = self.typeStr;
            }else{
                cell.titleLabel.text = self.selectStr;
            }
        }else{
            
            if (self.typeStr.length > 0) {
                cell.titleLabel.text = self.typeStr;
            }else{
                cell.titleLabel.text = @"点击选择类型";
            }
        }
        
        return cell;
    }else if (indexPath.row == 1) {
        YPImgTitleInputTWCell *cell = [YPImgTitleInputTWCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.contentStr.length > 0) {
            cell.inputTW.text = self.contentStr;
        }
        
        self.inputTW = cell.inputTW;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 60;
    }else{
        return 240;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = CHJ_bgColor;
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
        [btn setBackgroundColor:NavBarColor];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(view);
            make.right.mas_equalTo(-15);
        }];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        NSArray *arr = [self.selectTypeStr componentsSeparatedByString:@","];
        YPNewWedsSelectTypeListController *select = [[YPNewWedsSelectTypeListController alloc]init];
        select.typeList = arr;
        select.listDelegate = self;
        [self.navigationController pushViewController:select animated:YES];
    }
}

#pragma mark - YPSelectTypeListDelegate
- (void)returnSelectType:(NSString *)type{
    self.typeStr = type;
    [self.tableView reloadData];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnClick{
    NSLog(@"保存");
    
    [self UpNewPeopleQuestion];
}

#pragma mark 修改新人问题
- (void)UpNewPeopleQuestion{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpNewPeopleQuestion";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"QuestionID"] = self.questionID;
    params[@"TypeContent"] = self.typeStr;//无选项传空,多选项逗号分隔,选啥穿啥
    params[@"Answer"] = self.inputTW.text;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@""];
            
            if ([self.selectDelegate respondsToSelector:@selector(yp_selectUpdateSuccess)]) {
                [self.navigationController popViewControllerAnimated:YES];
                [self.selectDelegate yp_selectUpdateSuccess];
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
