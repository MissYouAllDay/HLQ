//
//  YPProfessionController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/25.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPProfessionController.h"
#import "YPGetAllOccupationList.h"
#import "YPCreateShenFenController.h"

#define UnselectedColor WhiteColor
#define SelectedColor RGB(51, 51, 51)

@interface YPProfessionController ()

// 按钮数组
@property (nonatomic, strong) NSMutableArray *btnArray;

// 选中按钮
@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, copy) NSString *profession;//编号
@property (nonatomic, copy) NSString *professionName;//职业

//@property (nonatomic, strong) NSMutableArray<YPGetAllOccupationList *> *listMarr;
@property (nonatomic, strong) NSMutableArray<YPGetAllOccupationList *> *lastMarr;

@end

@implementation YPProfessionController{
    UIView *_navView;
    
    //防止重复创建
    UIView *line;
    UILabel *lab1;
    UIView *div1;
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
    
    [self GetAllOccupationList];
    
    self.view.backgroundColor = WhiteColor;
}

- (void)setupUI{
    
    if (!line) {
        line = [[UIView alloc]init];
    }
    line.backgroundColor = CHJ_bgColor;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1);
    }];
    
    if (!lab1) {
        lab1 = [[UILabel alloc]init];
    }
    lab1.text = @"确定职业后将不能再修改,请谨慎选择";
    lab1.font = kBigFont;
    lab1.textColor = [UIColor redColor];
    [self.view addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(self.view);
    }];

    if (!div1) {
        div1 = [[UIView alloc]init];
    }
    div1.backgroundColor = CHJ_bgColor;
    [self.view addSubview:div1];
    [div1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(lab1.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(1);
    }];
    
    [self setupRadioBtnView];
    
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"选择职业";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.mas_equalTo(_navView).mas_offset(15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
    
    //确定按钮
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [sureBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    sureBtn.layer.cornerRadius = 10;
    sureBtn.clipsToBounds = YES;
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn);
    }];
    
}

- (void)setupRadioBtnView {
    
    CGFloat marginX = 15;
    CGFloat top = 170;
    CGFloat btnH = 60;
    CGFloat width = (ScreenWidth-10*2-2*marginX)/3.0;
    
    // 循环创建按钮
    NSInteger maxCol = 3;
    for (NSInteger i = 0; i < self.lastMarr.count; i++) {
        
        UIButton *proBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        proBtn.backgroundColor = UnselectedColor;
        proBtn.layer.cornerRadius = 3.0; // 按钮的边框弧度
        proBtn.layer.borderColor = RGB(51, 51, 51).CGColor;
        proBtn.layer.borderWidth = 2;
        proBtn.clipsToBounds = YES;
        proBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [proBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [proBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [proBtn addTarget:self action:@selector(chooseMark:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger col = i % maxCol; //列
        proBtn.x = 10 + col * (width + marginX);
        NSInteger row = i / maxCol; //行
        proBtn.y = top + row * (btnH + marginX);
        proBtn.width = width;
        proBtn.height = btnH;
        [proBtn setTitle:[self.lastMarr[i] OccupationName] forState:UIControlStateNormal];
        [self.view addSubview:proBtn];
        proBtn.tag = i;
        [self.btnArray addObject:proBtn];
    }
}

#pragma mark - target
- (void)sureBtnClick{
    NSLog(@"sureBtnClick");
    
//    if ([self.professionDelegate respondsToSelector:@selector(returnProfession:AndProfessionName:)]) {
//        [self.professionDelegate returnProfession:self.profession AndProfessionName:self.professionName];
//    }
//    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.professionName.length > 0 && self.profession.length > 0) {
        YPCreateShenFenController *create = [[YPCreateShenFenController alloc]init];
        create.phoneNo = self.phoneNo;
        create.authCodeID = self.authCodeID;
        create.professionID = self.profession;
        create.professionName = self.professionName;
        [self.navigationController pushViewController:create animated:YES];
    }else{
        
        [EasyShowTextView showText:@"请选择职业"];
    }
    
}

- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)chooseMark:(UIButton *)sender {
    NSLog(@"点击了%@", sender.titleLabel.text);
    
    self.profession = [self.lastMarr[sender.tag] OccupationID];
    self.professionName = [self.lastMarr[sender.tag] OccupationName];
    
    self.selectedBtn = sender;
    
    sender.selected = !sender.selected;
    
    for (NSInteger j = 0; j < [self.btnArray count]; j++) {
        UIButton *btn = self.btnArray[j] ;
        if (sender.tag == j) {
            btn.selected = sender.selected;
        } else {
            btn.selected = NO;
        }
        btn.backgroundColor = UnselectedColor;
    }
    
    UIButton *btn = self.btnArray[sender.tag];
    if (btn.selected) {
        btn.backgroundColor = SelectedColor;
    } else {
        btn.backgroundColor = UnselectedColor;
    }
}

#pragma mark - 网络请求
#pragma mark 获取所有职业列表
- (void)GetAllOccupationList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetAllOccupationList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    /**
     0、获取所有
     1、注册（不包含公司、用户、车手、员工）
     2、主页（不包含 用户、车手、员工）
     3、主页（不包含 用户、车手、员工,酒店）
     */
    params[@"Type"] = @"1";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.lastMarr = [YPGetAllOccupationList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
//            self.lastMarr = [self.listMarr mutableCopy];
//            
//            for (YPGetAllOccupationList *list in self.listMarr) {
//                
//                if ([list.OccupationName isEqualToString:@"婚车"] || [list.OccupationName isEqualToString:@"用户"] || [list.OccupationName isEqualToString:@"婚庆"]) {
//
//                    [self.lastMarr removeObject:list];
//                    
//                }
//            }
            
            [self.btnArray removeAllObjects];
            
            [self setupUI];
            
            if (self.lastMarr.count > 0) {
                
            }else{
                
                [EasyShowTextView showSuccessText:@"当前没有数据!"];

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

#pragma mark - 懒加载

//- (NSArray *)markArray {
//    if (!_markArray) {
//        NSArray *array = [NSArray array];
//        array = @[@"酒店", @"婚车", @"主持", @"摄影",@"摄像",@"化妆",@"演艺",@"婚纱",@"督导"];
//        _markArray = array;
//    }
//    return _markArray;
//}

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        NSMutableArray *array = [NSMutableArray array];
        _btnArray = array;
        
    }
    return _btnArray;
}

//- (NSMutableArray<YPGetAllOccupationList *> *)listMarr{
//    if (!_listMarr) {
//        _listMarr = [NSMutableArray array];
//    }
//    return _listMarr;
//}

- (NSMutableArray<YPGetAllOccupationList *> *)lastMarr{
    if (!_lastMarr) {
        _lastMarr = [NSMutableArray array];
    }
    return _lastMarr;
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
