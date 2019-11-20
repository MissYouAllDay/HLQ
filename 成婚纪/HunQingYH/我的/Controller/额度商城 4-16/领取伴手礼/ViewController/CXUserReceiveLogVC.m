//
//  CXUserReceiveLogVC.m
//  HunQingYH
//
//  Created by apple on 2019/9/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXUserReceiveLogVC.h"
#import "YPGetFacilitatorFlowRecord.h"
#import "CXTitleAndDetailCell.h"    // 普通cell
#import "CXReceiveUserInfoCell.h"   // 用户信息
#import "YPGetCommodityTypeTableListData.h"

@interface CXUserReceiveLogVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YPGetFacilitatorFlowRecord *model;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *detailArr;
@property (nonatomic, strong) UIButton *subBtn; // 提交按钮
@property (nonatomic, strong) NSMutableArray *goodsArr;

@end

@implementation CXUserReceiveLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"领取记录";
    self.titleArr = @[@"姓        名",@"手 机 号",@"婚        期",@"桌        数",@"餐        标",@"缴纳金额",@"领取状态",@"领取日期"];
    self.detailArr = @[@"残雪",@"150****1437",@"2019-12-12",@"10桌",@"2009",@"100000",@"已领取",@"2019-12-12"];
    
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self loadUserReceiveLog];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(34))];
//        UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(200))];
//        top.backgroundColor = [UIColor redColor];
//        [head addSubview:top];
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = head;
        _tableView.backgroundColor =  [UIColor colorWithHexString:@"#F5F5F5"];

        _tableView.backgroundColor =  [UIColor clearColor];

        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.goodsArr.count == 0 ? 2 : 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.goodsArr.count == 0) {
        return section == 0 ? 1 : self.titleArr.count;
    }else {
        switch (section) {
            case 0: return 1;
            case 1: return self.goodsArr.count;
            case 2: return self.titleArr.count;
            default: break;
        }
    }
    return 0;
}
#pragma mark - - - - - - - - - - - - - - - 创建cell - - - - - - - - - - - - - - - - -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {

        CXReceiveUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXReceiveUserInfoCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CXReceiveUserInfoCell" owner:nil options:nil] lastObject];
        }
        return cell;
    }
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
      if (!cell) {
          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
          cell.textLabel.font = kFont(12);
          cell.detailTextLabel.font = kFont(12);
      }
    
    if ((self.goodsArr.count == 0 && indexPath.section == 1) || (self.goodsArr.count != 0 && indexPath.section == 2)) {
        cell.textLabel.text = self.titleArr[indexPath.row];
        cell.detailTextLabel.text = self.detailArr[indexPath.row];
    }else if (self.goodsArr.count != 0 && indexPath.section == 1) {
        YPGetCommodityTypeTableListData *model = self.goodsArr[indexPath.row];
        cell.textLabel.text = model.CommodityName;
        cell.detailTextLabel.text = model.Model;
    }
    
    cell.textLabel.textColor = indexPath.section == 1 ? [UIColor blackColor] : [UIColor colorWithHexString:@"#999999"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.section == 0 ? Line375(100) : Line375(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return Line375(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    switch (section) {
        case 0: return 10;
        case 1: return 20;
        case 2: return 40;
        default: break;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,  Line375(30))];
    view.backgroundColor = [UIColor whiteColor];
    view.clipsToBounds = YES;
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth, view.height)];
    NSString *text;
    
    if (self.goodsArr.count == 0) {
        text = section == 0 ? @"个人信息" : @"领取记录";
    }else {
        switch (section) {
               case 0:  text = @"个人信息"; break;
               case 1:  text = @"礼品详情"; break;
               case 2:  text = @"领取记录"; break;
               default: break;
           }
    }
    la.text = text;
    la.font = kFont(12);
    [view addSubview:la];
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if ([view respondsToSelector:@selector(tintColor)]) {

        // if (tableView == self.tableView) {

        CGFloat cornerRadius = 10.f;

        view.backgroundColor = UIColor.clearColor;

        CAShapeLayer *layer = [[CAShapeLayer alloc] init];

        CGMutablePathRef pathRef = CGPathCreateMutable();

        CGRect bounds = CGRectInset(view.bounds, 10, 0);

        BOOL addLine = NO;

        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));

        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);

        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);

        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));

        layer.path = pathRef;

        CFRelease(pathRef);

        //颜色修改
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:1.f].CGColor;
        layer.strokeColor=[UIColor whiteColor].CGColor;

        if (addLine == YES) {

            CALayer *lineLayer = [[CALayer alloc] init];

            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);

            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);

            lineLayer.backgroundColor = tableView.separatorColor.CGColor;

            [layer addSublayer:lineLayer];

        }

        [view.layer insertSublayer:layer atIndex:0];

        view.backgroundColor = UIColor.clearColor;

        }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([cell respondsToSelector:@selector(tintColor)]) {

        // if (tableView == self.tableView) {

        CGFloat cornerRadius = 10.f;

        cell.backgroundColor = UIColor.clearColor;

        CAShapeLayer *layer = [[CAShapeLayer alloc] init];

        CGMutablePathRef pathRef = CGPathCreateMutable();

        CGRect bounds = CGRectInset(cell.bounds, 10, 0);

        if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {

            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));

            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);

            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);

            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));

        } else {

            CGPathAddRect(pathRef, nil, bounds);

//            addLine = YES;

        }

        layer.path = pathRef;

        CFRelease(pathRef);

        //颜色修改
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:1.f].CGColor;
        layer.strokeColor=[UIColor whiteColor].CGColor;

        UIView *testView = [[UIView alloc] initWithFrame:bounds];

        [testView.layer insertSublayer:layer atIndex:0];

        testView.backgroundColor = UIColor.clearColor;

        cell.backgroundView = testView;

    }
}

#pragma mark - - - - - - - - - - - - - - - 获取用户领取记录 - - - - - - - - - - - - - - - - -
- (void)loadUserReceiveLog {
    
    [EasyShowLodingView showLoding];
    [self.goodsArr removeAllObjects];
   
    NSString *url = @"/api/HQOAApi/GetUserRecord";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserNamePhone"] = UserPhone_New;
  
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        NSLog(@"%@",object);
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSArray *subArr = [YPGetFacilitatorFlowRecord mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            if (subArr.count > 0) {
                self.model = subArr[0];
                [self.goodsArr addObjectsFromArray:[YPGetCommodityTypeTableListData mj_objectArrayWithKeyValuesArray:object[@"Data"][0][@"Data"]]];
            }
            if (!self.model) {
                    [EasyShowEmptyView showEmptyViewWithTitle:@"您尚未领取套餐！请立即领取" subTitle:@"" imageName:@"nullAlert" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
            }else {
                [self changeDataToUse];
                [self.tableView reloadData];
            }
          
        }else{
            [EasyShowEmptyView showEmptyViewWithTitle:@"出问题了喽～～" subTitle:@"" imageName:@"netError" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {}];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    }];
}

- (void)changeDataToUse {
    
    self.detailArr = @[@"残雪",@"150****1437",@"2019-12-12",@"10桌",@"2009",@"100000",@"已领取",@"2019-12-12"];
    
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    [dataArr addObject:self.model.UserName];
    [dataArr addObject:self.model.Phone];
    [dataArr addObject:self.model.WeddingDate];
    [dataArr addObject:self.model.TableNumber];
    [dataArr addObject:self.model.MealMark];
    [dataArr addObject:self.model.Money];
    [dataArr addObject:@"已领取"];
    [dataArr addObject:@"2012-12-12"];
    self.detailArr = dataArr;
}

- (NSMutableArray *)goodsArr {
    
    if (!_goodsArr) {
        _goodsArr = [[NSMutableArray alloc] init];
    }
    return _goodsArr;
}

@end
