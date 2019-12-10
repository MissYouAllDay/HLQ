//
//  hotelRenManageVC.m
//  HunQingYH
//
//  Created by Hiro on 2019/6/27.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "hotelRenManageVC.h"
#import "JXCategoryView.h"
#import "hotelRenYuanell.h"
#import "hotelAddRenVC.h"
#import "yuangongModel.h"
@interface hotelRenManageVC ()<JXCategoryViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    UITableView *thisTableView;
    NSInteger selectindx;
}
@property(nonatomic,strong)JXCategoryTitleView *categoryView;
/***/
@property(nonatomic,strong)NSMutableArray  *dataArray;
@end

@implementation hotelRenManageVC
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    selectindx =0;
    [self createNav];
    [self createUI];
    [self createBottomView];
}

- (void)createNav {
    self.view.backgroundColor=WhiteColor ;
    UIView *navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor = WhiteColor;
    [self.view addSubview:navView];
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(navView.mas_left);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-5);
    }];
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"人员管理";
    titleLab.textColor = [UIColor colorWithWhite:0.098 alpha:1.000];
    titleLab.font = [UIFont systemFontOfSize:20 ];
    [navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];
    
   
    
}
-(void)createUI{
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(ScreenWidth/2-100,NAVIGATION_BAR_HEIGHT, 200, 49)];
    self.categoryView.delegate = self;
    [self.view addSubview:self.categoryView];
    self.categoryView.titles = @[@"销售代表", @"预订人员"];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleColor =TextNormalColor;
    self.categoryView.titleSelectedColor =BlackColor;
    self.categoryView.backgroundColor =WhiteColor;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = MainColor;
//    lineView.indicatorLineWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[lineView];
    //tableview
    thisTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+50, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50-50)];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:thisTableView];
}
-(void)createBottomView{
    UIView *bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, ScreenWidth, 50);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.2),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[RGB(255, 0, 123) CGColor],(id)[RGB(255, 83, 103) CGColor]]];//渐变数组
    [bottomView.layer addSublayer:gradientLayer];
    [self.view addSubview:bottomView];
    
    
    UIButton *addBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.backgroundColor=[UIColor clearColor];
    [addBtn setTitle:@"添加人员" forState:UIControlStateNormal];
    [addBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    addBtn.titleLabel.font =kFont(15);
    [addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bottomView);
        make.size.mas_equalTo(bottomView);
    }];
    
}
//点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    NSLog(@"%ld",index);
    selectindx =index;
    if (index==0) {
        [self GetListWithId:@"E420424F-98FE-4FE2-A342-D530F3893BFB"];
    }else{
        [self GetListWithId:@"67FC24E4-E001-4E85-B969-A4DEEDFA0DA2"];
    }
    
}

#pragma mark ---------------tableviewdatascource------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    hotelRenYuanell *cell =[hotelRenYuanell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.editBtn.tag =indexPath.row;
    cell.model =self.dataArray[indexPath.row];
    [cell.editBtn addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark ----------------tableviewDelegate------------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark --------------------- target---------------------
-(void)addClick{
    hotelAddRenVC *addvc = [hotelAddRenVC new];
    addvc.formIndex =1;
    if (selectindx==0) {
        addvc.shenfenStr =@"销售代表";
    }else{
        addvc.shenfenStr =@"预订人员";
        
    }
    [self.navigationController pushViewController:addvc animated:YES];
}
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)editClick:(UIButton*)sender{
    
    NSLog(@"%zd",sender.tag);
    hotelAddRenVC *addvc = [[hotelAddRenVC alloc]init];
    //获取点击的cell
    yuangongModel *model =self.dataArray[sender.tag];
    addvc.ID =model.Id;
    addvc.nameStr =model.Name;
    addvc.phoneStr=model.Phone;
    if (selectindx==0) {
        addvc.shenfenStr =@"销售代表";
    }else{
        addvc.shenfenStr =@"预订人员";

    }
    [self.navigationController pushViewController:addvc animated:YES];
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    if (selectindx==1) {
        [self GetListWithId:@"67FC24E4-E001-4E85-B969-A4DEEDFA0DA2"];

    }else{
        [self GetListWithId:@"E420424F-98FE-4FE2-A342-D530F3893BFB"];

    }
    

    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark -------------------网络请求-------------------
- (void)GetListWithId:(NSString *)Id{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetHotelPersonnelList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"IdentityId"] =Id;
    params[@"FacilitatorId"] =FacilitatorId_New;
    
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"人员%@",object);
            //
            self.dataArray = [yuangongModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [thisTableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
            
        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}


@end
