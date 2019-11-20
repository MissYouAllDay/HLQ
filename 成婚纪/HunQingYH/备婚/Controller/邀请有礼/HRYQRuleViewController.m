//
//  HRYQRuleViewController.m
//  HunQingYH
//
//  Created by Hiro on 2017/12/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRYQRuleViewController.h"
#import "ProblemTitleModel.h"
#import "AnswerModel.h"
#import "HeadView.h"
#import "AnswerCell.h"
@interface HRYQRuleViewController ()<UITableViewDelegate,UITableViewDataSource,HeadViewDelegate>
{
    UIView *_navView;
    UITableView *thisTableView;
}

@property (nonatomic, strong) NSMutableArray *answersArray;
@property (nonatomic, assign) CGSize textSize;
@end

@implementation HRYQRuleViewController
- (NSMutableArray *)answersArray{
    if (_answersArray == nil) {
        self.answersArray = [NSMutableArray array];
    }
    return _answersArray;
}
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
    titleLab.text = @"活动规则";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
       self.view.backgroundColor =CHJ_bgColor;
}
-(void)setupUI{
 
    thisTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1)];
    thisTableView.backgroundColor =CHJ_bgColor;
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    thisTableView.sectionHeaderHeight = 50;
    
    [self.view addSubview:thisTableView];

    [self loadData];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.answersArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ProblemTitleModel *titleGroup = self.answersArray[section];
    NSInteger count = titleGroup.isOpened ? titleGroup.Rule.count : 0;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    AnswerCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AnswerCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor =CHJ_bgColor;
    cell.backView.backgroundColor =CHJ_bgColor;
    ProblemTitleModel *titleGroup = self.answersArray[indexPath.section];

    cell.textViewLabel.text = [NSString stringWithFormat:@"%@", titleGroup.Rule[indexPath.row]];
    
    self.textSize = [self getLabelSizeFortextFont:[UIFont systemFontOfSize:15] textLabel: titleGroup.Rule[indexPath.row]];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.textSize.height+30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView headViewWithTableView:tableView];
    headView.backgroundColor =WhiteColor;
    headView.delegate = self;
    headView.titleGroup = self.answersArray[section];
    
    return headView;
}

- (void)clickHeadView
{
    [thisTableView reloadData];
}


- (CGSize)getLabelSizeFortextFont:(UIFont *)font textLabel:(NSString *)text{
    NSDictionary * totalMoneydic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize totalMoneySize =[text boundingRectWithSize:CGSizeMake(ScreenWidth-16,1000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:totalMoneydic context:nil].size;
    return totalMoneySize;
}

#pragma mark 加载数据
- (void)loadData
{
    
        [EasyShowLodingView showLoding];
        NSString *url = @"/api/Corp/ByIdsGetActivityInfo";
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
       params[@"TwoObjectTypes"]   =@"1,3";
        [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
            // 菊花不会自动消失，需要自己移除
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [EasyShowLodingView hidenLoding];
            });
            if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
                
                NSLog(@"详情%@",object);
//                self.rulerInfo.YQCode =[object objectForKey:@"YQCode"];
                
                self.answersArray = [ProblemTitleModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                [thisTableView reloadData];
                
                
            
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
        
        
    
    
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"problemCenter.plist" withExtension:nil];
//    NSArray *tempArray = [NSArray arrayWithContentsOfURL:url];
//
//    self.answersArray = [NSMutableArray array];
//    for (NSDictionary *dict in tempArray) {
//        ProblemTitleModel *titleGroup = [ProblemTitleModel friendGroupWithDict:dict];
//        [self.answersArray addObject:titleGroup];
//    }
    
}
#pragma mark --------------target-------------
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
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
