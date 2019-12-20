
//
//  YPDriverListController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/22.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPDriverListController.h"
#import "YPDriverHeaderView.h"
#import "YPDriverSelectCell.h"
#import "YPNewAddDriverModel.h"//测试

char* const buttonKey = "buttonKey";

@interface YPDriverListController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataMarr;

@property (nonatomic, assign) NSInteger selectCount;//选中人数

@end

@implementation YPDriverListController{
    UIView      *_navView;
    
    //避免重复创建
    UIView      *_top;
    UILabel     *time;
    UILabel     *type;
    UIView      *view;
    UIImageView *icon;
    UILabel     *label;
    UIButton    *doneBtn;
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
    titleLab.text = @"分配车手";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
 
    //设置导航栏右边
    UIButton *searchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
    
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    if (!_top) {
        _top = [[UIView alloc]init];
    }
    _top.backgroundColor = WhiteColor;
    [self.view addSubview:_top];
    [_top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    if (!time) {
        time = [[UILabel alloc]init];
    }
    time.text = @"2017-08-22 10:00";
    time.textColor = GrayColor;
    [_top addSubview:time];
    
    if (!type) {
        type = [[UILabel alloc]init];
    }
    type.text = @"他们都有空";
    type.textColor = GrayColor;
    [_top addSubview:type];
    
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(_top);
    }];
    
    [type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(time.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(time);
    }];
    
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+41, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-41-50) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.view addSubview:self.tableView];
    
    if (!view) {
        view = [[UIView alloc]init];
    }
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
    if (!icon) {
        icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"占位图"]];
    }
    [view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    self.selectCount = 0;
    for (YPNewAddDriverModel *model in self.dataMarr) {
        for (NSDictionary *info in model.drivers) {
            if ([info[@"status"] integerValue] == 1) {
                self.selectCount ++;
            }
        }
    }
    
    if (!label) {
        label = [[UILabel alloc]init];
    }
    label.text = [NSString stringWithFormat:@"已选%zd人",self.selectCount];
    label.font = kNormalFont;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(icon.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(icon);
    }];
    
    if (!doneBtn) {
        doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:NavBarColor];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(view);
        make.width.mas_equalTo(125);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YPNewAddDriverModel *groupModel = self.dataMarr[section];
    NSInteger count = groupModel.isOpen?groupModel.drivers.count:0;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPNewAddDriverModel *model = self.dataMarr[indexPath.section];
    NSDictionary *friendInfoDic = model.drivers[indexPath.row];
    
    YPDriverSelectCell *cell = [YPDriverSelectCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = friendInfoDic[@"name"];
    
    if ([friendInfoDic[@"status"] integerValue] == 1) {
        cell.selectBtn.selected = YES;
    }else if ([friendInfoDic[@"status"] integerValue] == 0){
        cell.selectBtn.selected = NO;
    }
    
    cell.selectBtn.section = indexPath.section;
    cell.selectBtn.row = indexPath.row;
    [cell.selectBtn addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 110;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    YPNewAddDriverModel *model = self.dataMarr[section];
    
    YPDriverHeaderView *head = [YPDriverHeaderView driverHeaderView];
    
    head.titleLabel.text = model.carName;
    
    head.selectBtn.tag = section + 1000;
    [head.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (model.isOpen) {
        UIImageView * _imgView = head.xialaImgV;
        CGAffineTransform currentTransform = _imgView.transform;
        CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, M_PI); // 在现在的基础上旋转指定角度
        _imgView.transform = newTransform;
        objc_setAssociatedObject(head.selectBtn, buttonKey, _imgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }else{
        UIImageView * _imgView = head.xialaImgV;
        objc_setAssociatedObject(head.selectBtn, buttonKey, _imgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }

    return head;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBtnClick{
    NSLog(@"searchBtnClick");
}

- (void)selectBtnClick:(UIButton *)sender{
    
    YPNewAddDriverModel *model = self.dataMarr[sender.tag-1000];
    UIImageView *imageView =  objc_getAssociatedObject(sender,buttonKey);
    
    
    if (model.isOpen) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
            CGAffineTransform currentTransform = imageView.transform;
            CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, -M_PI/2); // 在现在的基础上旋转指定角度
            imageView.transform = newTransform;
            
            
        } completion:^(BOOL finished) {
            
            
        }];

    }else{
        
        [UIView animateWithDuration:0.3 delay:0.0 options: UIViewAnimationOptionAllowUserInteraction |UIViewAnimationOptionCurveLinear animations:^{
            
            CGAffineTransform currentTransform = imageView.transform;
            CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, M_PI/2); // 在现在的基础上旋转指定角度
            imageView.transform = newTransform;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    model.isOpen = !model.isOpen;
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1000] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)buttonSelect:(YPSelectButton *)sender{

    NSLog(@"%zd-----%zd",sender.section,sender.row);
    
    YPNewAddDriverModel *model = self.dataMarr[sender.section];
    NSDictionary *dic = model.drivers[sender.row];
    
    if ([dic[@"status"] integerValue] == 0) {
//        model.drivers[sender.row][@"status"] = @"1";
//        [[[model.drivers mutableCopy][sender.row] mutableCopy] setObject:@"1" forKey:@"status"];
//        NSDictionary *dict = @{@"name":dic[@"name"],@"status":@"1"};
//        [model.drivers mutableCopy][sender.row] = dict;

        NSMutableArray *marr = [NSMutableArray array];
        for (int i = 0; i < model.drivers.count; i ++) {
            if (i == sender.row) {
                NSDictionary *dict = @{@"name":dic[@"name"],@"status":@"1"};
                [marr addObject:dict];
            }else{
                [marr addObject:model.drivers[i]];
            }
        }
        
        model.drivers = marr.copy;
    
    }else if ([dic[@"status"] integerValue] == 1) {
//        model.drivers[sender.row][@"status"] = @"0";
//        [[model.drivers[sender.row] mutableCopy] setObject:@"0" forKey:@"status"];
//        [[[model.drivers mutableCopy][sender.row] mutableCopy] setObject:@"0" forKey:@"status"];
        
//        NSDictionary *dict = @{@"name":dic[@"name"],@"status":@"0"};
//        [model.drivers mutableCopy][sender.row] = dict;
        
        NSMutableArray *marr = [NSMutableArray array];
        for (int i = 0; i < model.drivers.count; i ++) {
            if (i == sender.row) {
                NSDictionary *dict = @{@"name":dic[@"name"],@"status":@"0"};
                [marr addObject:dict];
            }else{
                [marr addObject:model.drivers[i]];
            }
        }
        
        model.drivers = marr.copy;
    }
    
    _dataMarr[sender.section] = model;
    
//    for (YPNewAddDriverModel *model in self.dataMarr) {
//        for (NSDictionary *info in model.drivers) {
//            if ([info[@"status"] integerValue] == 1) {
//                self.selectCount ++;
//            }
//        }
//    }
    
    [self setupUI];//重置选中人数
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
//    UITableViewCell *cell = (UITableViewCell *)[sender superview];
//    NSInteger section = [self.tableView indexPathForCell:cell].section;
//    NSInteger row = [self.tableView indexPathForCell:cell].row;
//    
//    NSLog(@"------- %zd -------%zd",section,row);
//    if (section == sender.section && row == sender.row) {
//        sender.selected = !sender.selected;
//    }
    
}

- (void)doneBtnClick{
    NSLog(@"doneBtnClick");
}

#pragma mark - getter
- (NSMutableArray *)dataMarr{
    if (!_dataMarr) {
        _dataMarr = [NSMutableArray array];
        
        NSDictionary *JSONDic =@{@"group":
                                     @[
                                         @{@"carName":@"AAAAAA",@"drivers":@[
                                                   @{@"name":@"小明",@"status":@"1"},
                                                   @{@"name":@"小红",@"status":@"1"},
                                                   @{@"name":@"小王",@"status":@"0"}
                                                   ]},
                                         @{@"carName":@"BBBBBB",@"drivers":@[
                                                   @{@"name":@"小A",@"status":@"1"},
                                                   @{@"name":@"小B",@"status":@"1"},
                                                   @{@"name":@"小C",@"status":@"0"}
                                                   ]},
                                         @{@"carName":@"CCCCCCC",@"drivers":@[
                                                   @{@"name":@"小1",@"status":@"1"},
                                                   @{@"name":@"小2",@"status":@"1"},
                                                   @{@"name":@"小3",@"status":@"0"}
                                                   ]},
                                         @{@"carName":@"DDDDDDDD",@"drivers":@[
                                                   @{@"name":@"小G",@"status":@"1"}
                                                   ]},
                                         @{@"carName":@"EEEEEEEE",@"drivers":@[
                                                   @{@"name":@"小明",@"status":@"1"},
                                                   @{@"name":@"小红",@"status":@"1"},
                                                   @{@"name":@"小王",@"status":@"0"},
                                                   @{@"name":@"小王",@"status":@"0"},
                                                   @{@"name":@"小王",@"status":@"0"}
                                                   ]},
                                         @{@"carName":@"FFFFFFFF",@"drivers":@[
                                                   @{@"name":@"小明",@"status":@"1"},
                                                   @{@"name":@"小红",@"status":@"1"},
                                                   @{@"name":@"小王",@"status":@"0"}
                                                   ]}
                                         ]
                                 };
        
        for (NSDictionary *groupInfoDic in JSONDic[@"group"]) {
            YPNewAddDriverModel *model = [[YPNewAddDriverModel alloc]init];
            model.carName = groupInfoDic[@"carName"];
            model.isOpen = NO;
            model.drivers = groupInfoDic[@"drivers"];
            [_dataMarr addObject:model];
        }
    }
    return _dataMarr;
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
