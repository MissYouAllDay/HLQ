//
//  CXShowDidSelectGoodsVC.m
//  HunQingYH
//
//  Created by apple on 2019/9/29.
//  Copyright © 2019 YanpengLee. All rights reserved.

//// - - - - - - - - - - - - - - - - - - 此步骤为提供用户核对使用。 删除此界面也可以 - - - - - - - - - - - - - - - - - -

#pragma mark - - - - - - - - - - - - - - - 展示已经选择的规格 - - - - - - - - - - - - - - - - -


#import "CXShowDidSelectGoodsVC.h"
#import "CXReviceSuccessVC.h"

@interface CXShowDidSelectGoodsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *subBtn;
/** 订单id */
@property (nonatomic, copy) NSString *orderId;
/** 数据是否提交失败 */
@property (nonatomic, assign) BOOL subFaile;
@end

@implementation CXShowDidSelectGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"领取套餐";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.subBtn];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
- (UIButton *)subBtn {
    
    if (!_subBtn) {
        _subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _subBtn.frame =  CGRectMake(0, ScreenHeight-44-HOME_INDICATOR_HEIGHT - NAVIGATION_BAR_HEIGHT, ScreenWidth,44);
        [_subBtn setBackgroundImage:[UIImage gradientImageWithBounds:_subBtn.frame andColors:@[[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0], [UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
        [_subBtn setBackgroundImage:[UIImage gradientImageWithBounds:_subBtn.frame andColors:@[[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0], [UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
        [_subBtn setTitle:@"立即预约" forState:UIControlStateNormal];
        [_subBtn addTarget:self action:@selector(postOrderData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subBtn;
}


//
//- (void)initDownView {
//
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-44- NAVIGATION_BAR_HEIGHT, ScreenWidth, 44)];
//
//    self.subBtn = [UIButton buttonWithType: UIButtonTypeCustom];
//    self.subBtn.frame = CGRectMake(Line375(15), 0, ScreenWidth - Line375(30), 30);
//
//    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
//    gradientLayer.frame = self.subBtn.bounds;
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 0);
//    gradientLayer.locations = @[@(0.2),@(1.0)];//渐变点
//    [gradientLayer setColors:@[(id)[RGB(255, 0, 123) CGColor],(id)[RGB(255, 83, 103) CGColor]]];//渐变数组
//    [self.subBtn.layer addSublayer:gradientLayer];
//
//    [self.subBtn setTitle:@"提交" forState:UIControlStateNormal];
//    self.subBtn.layer.cornerRadius = self.subBtn.height/2;
//    self.subBtn.clipsToBounds = YES;
//
//    [self.subBtn addTarget:self action:@selector(pushSuccessVC) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:bgView];
//    [bgView addSubview:self.subBtn];
//}

- (void)pushSuccessVC {
    NSString *name;
    for (YPGetCommodityTypeTableListData *model in self.dataArr) {
        name = [name stringByAppendingFormat:@"%@ + ",model.Title];
    }
    if (name.length > 2) {
        name = [name substringToIndex:name.length - 2];
    }
    CXReviceSuccessVC *vc = [[CXReviceSuccessVC alloc] init];
    vc.name = name;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 44-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        _tableView.rowHeight = 100;
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor =  [UIColor colorWithHexString:@"#F5F5F5"];
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

#pragma mark - - - - - - - - - - - - - - - 创建cell - - - - - - - - - - - - - - - - -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXShowDidSelectGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXShowDidSelectGoodsCell"];
    if (!cell) {
        cell = [[CXShowDidSelectGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CXShowDidSelectGoodsCell"];
    }
    cell.model = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - - - - - - - - - - - - - - - TableViewDelegate - - - - - - - - - - - - - - - - -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return Line375(100) + 10;
}

#pragma mark - - - - - - - - - - - - - - - 用户提交套餐信息 - - - - - - - - - - - - - - - - -
- (void)postOrderData {
    
    if (!ISEMPTY(self.orderId)) {
        [self postUserSubData];
        return;
    }
    
    NSString *url = @"/api/HQOAApi/AddOrders";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //    params[@"UserNamePhone"] = UserPhone_New;
    params[@"PackageId"] = self.packageId;
    params[@"UserName"] = UserName_New;
    params[@"Phone"] = UserPhone_New;
    params[@"IsReceiveState"] = @"1";
    params[@"UserId"] = UserId_New;
    params[@"FacilitatorId"] = ISEMPTY(self.flowRecord.FacilitatorId) ? @"" : self.flowRecord.FacilitatorId;
    params[@"WeddingDate"] = ISEMPTY(self.flowRecord.WeddingDate) ? @"" : self.flowRecord.WeddingDate;
    params[@"TableNumber"] = ISEMPTY(self.flowRecord.TablesNumber) ? @"" : self.flowRecord.TablesNumber;
    params[@"MealMark"] = ISEMPTY(self.flowRecord.MealMark) ? @"" : self.flowRecord.MealMark;
    params[@"Money"] = ISEMPTY(self.flowRecord.Money) ? @"" : self.flowRecord.Money;
    //    params[@"ActivityId"] = act_banShouLi;
     [EasyShowLodingView showLoding];
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
       
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self postUserSubData];
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [EasyShowLodingView hidenLoding];
            });
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
- (void)postUserSubData {
   
    [EasyShowLodingView showLoding];

    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create(0, 0);
   
    for (YPGetCommodityTypeTableListData *model in self.dataArr) {
        
        dispatch_group_enter(group);
        dispatch_group_async(group, queue, ^{
            [self postGoodsData:group withGoodModel:model];
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
        if (self.subFaile) {
            [EasyShowTextView showText:@"提交失败"];
        }else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self pushSuccessVC];
            });
        }
    });
}

- (void)postGoodsData:(dispatch_group_t)group withGoodModel:(YPGetCommodityTypeTableListData *)model {
    NSString *url = @"/api/HQOAApi/AddOrder_detail";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    params[@"OrdersId"] = self.orderId;
    params[@"CommodityId"] = model.CommodityId;
    params[@"Model"] = ISEMPTY(model.selectSpe) ? @"" : model.selectSpe;
    params[@"Count"] = @"1";
    params[@"IsReceiveState"] = @"1";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
  
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] != 200) {
            self.subFaile = YES;
        }
        dispatch_group_leave(group);
    } Failure:^(NSError *error) {
        self.subFaile = YES;
        dispatch_group_leave(group);
    }];
    
}

@end


#pragma mark - - - - - - - - - - - - - - - cell - - - - - - - - - - - - - - - - -
@interface CXShowDidSelectGoodsCell ()

@property (nonatomic, strong) UIView *mainBgView;

@end

@implementation CXShowDidSelectGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        self.mainBgView.backgroundColor = [UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    [self.contentView addSubview:self.mainBgView];
    [self.mainBgView addSubview:self.icon];
    [self.mainBgView addSubview:self.titleLab];
    [self.mainBgView addSubview:self.specLab];
    
    self.titleLab.text = @"名称";
    self.specLab.text = @"规格、规格";
}

- (UIView *)mainBgView {
    
    if (!_mainBgView) {
        _mainBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, Line375(100))];
        
        _mainBgView.layer.cornerRadius = 6;
        _mainBgView.clipsToBounds = YES;
    }
    return _mainBgView;
}
- (void)setModel:(YPGetCommodityTypeTableListData *)model {
    
    _model = model;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.model.ShowImage] placeholderImage:[UIImage imageNamed:@"smallPlaceIcon"]];
    self.titleLab.text  = self.model.Title;
    self.specLab.text = self.model.selectSpe;
}
- (UILabel *)titleLab {
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(self.icon.right + Line375(15), self.icon.top, ScreenWidth - Line375(60) -  Line375(45) ,self.icon.height/2)];
        _titleLab.font = kFont(15);
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

- (UILabel *)specLab {
    
    if (!_specLab) {
        _specLab = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLab.left, self.titleLab.bottom, self.titleLab.width ,self.titleLab.height)];
        _specLab.numberOfLines = 0;
        _specLab.font = kFont(13);
        _specLab.textColor = [UIColor colorWithHexString:@"#8B8989"];
    }
    return _specLab;
}

- (UIImageView *)icon {
    
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake( Line375(15),  Line375(15), Line375(70), Line375(70))];
        _icon.image = [UIImage imageNamed:@"goodsPlace"];
    }
    return _icon;
}


@end
