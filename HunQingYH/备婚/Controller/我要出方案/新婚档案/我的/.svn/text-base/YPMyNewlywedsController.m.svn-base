//
//  YPMyNewlywedsController.m
//  HunQingYH
//
//  Created by Else丶 on 2017/11/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMyNewlywedsController.h"
#import "YPNewlywedsAddCell.h"
#import "YPMyNewlywedsInfoCell.h"
#import "YPMyNewlywedsDescCell.h"
#import "YPMyNewlywedsAddPersonInfoController.h"//个人信息
#import "YPMyNewlywedsMusicController.h"//音乐类型

@interface YPMyNewlywedsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YPMyNewlywedsController

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupUI{
    self.view.backgroundColor = bgColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = bgColor;
    self.tableView.estimatedRowHeight = 90;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //没有数据
    YPNewlywedsAddCell *cell = [YPNewlywedsAddCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.section == 0) {

        [cell.addBtn setTitle:@"展示您的个人信息" forState:UIControlStateNormal];
        cell.descLabel.text = @"展示您的个人信息";

    }else if (indexPath.section == 1){

        [cell.addBtn setTitle:@"描述您的职业特点" forState:UIControlStateNormal];
        cell.descLabel.text = @"请详细描述下您职业的特点及工作强度";

    }else if (indexPath.section == 2){

        [cell.addBtn setTitle:@"描述您的兴趣爱好" forState:UIControlStateNormal];
        cell.descLabel.text = @"请详细描述下您的兴趣爱好,最擅长的是?";

    }else if (indexPath.section == 3){

        [cell.addBtn setTitle:@"您最喜欢的音乐类型" forState:UIControlStateNormal];
        cell.descLabel.text = @"您喜欢什么类型的音乐?有什么背景故事吗?";

    }
    return cell;
    
    
    //有数据
//    if (indexPath.section == 0) {
//
//        YPMyNewlywedsInfoCell *cell = [YPMyNewlywedsInfoCell cellWithTableView:tableView];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell.editBtn addTarget:self action:@selector(infoEditBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        return cell;
//
//    }else{
//
//        YPMyNewlywedsDescCell *cell = [YPMyNewlywedsDescCell cellWithTableView:tableView];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        if (indexPath.section == 1) {
//            cell.typeLabel.hidden = YES;
////            cell.contentLabel.text = @"";
//            [cell.editBtn addTarget:self action:@selector(zhiyeEditBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        }else if (indexPath.section == 2) {
//            cell.typeLabel.hidden = YES;
////            cell.contentLabel.text = @"";
//            [cell.editBtn addTarget:self action:@selector(xingquEditBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        }else if (indexPath.section == 3) {
//            cell.typeLabel.hidden = NO;
////            cell.contentLabel.text = @"";
//            [cell.editBtn addTarget:self action:@selector(musicEditBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        }
//        return cell;
//    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = bgColor;
    UILabel *label = [[UILabel alloc]init];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view);
        make.left.mas_equalTo(10);
    }];
    switch (section) {
        case 0:
            label.text = @"个人信息";
            break;
        case 1:
            label.text = @"职业特点";
            break;
        case 2:
            label.text = @"兴趣爱好";
            break;
        case 3:
            label.text = @"音乐类型";
            break;
        default:
            break;
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        YPMyNewlywedsAddPersonInfoController *add = [[YPMyNewlywedsAddPersonInfoController alloc]init];
        [self.navigationController pushViewController:add animated:YES];
    }else if (indexPath.section == 3){
        YPMyNewlywedsMusicController *music = [[YPMyNewlywedsMusicController alloc]init];
        [self.navigationController pushViewController:music animated:YES];
    }
}

#pragma mark - target
- (void)infoEditBtnClick{
    NSLog(@"infoEdit");
}

- (void)zhiyeEditBtnClick{
    NSLog(@"zhiyeEditBtnClick");
}

- (void)xingquEditBtnClick{
    NSLog(@"xingquEditBtnClick");
}

- (void)musicEditBtnClick{
    NSLog(@"musicEditBtnClick");
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
