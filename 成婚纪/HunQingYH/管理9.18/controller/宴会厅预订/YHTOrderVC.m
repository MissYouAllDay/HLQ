//
//  YHTOrderVC.m
//  HunQingYH
//
//  Created by xl on 2019/6/17.
//  Copyright © 2019 xl. All rights reserved.
//

#import "YHTOrderVC.h"
#import "JXCategoryView.h"
#import "RMCalendarController.h" //日历
#import "LTSCalendarManager.h"
#import "yhtorderriliCell.h"
#import "YPHYTHThreeSelectView.h"
#import "yhtorderCell.h"
#import "WTTableAlertView.h"
#import "AddYHTOrderVC.h"
#import "YHTOrderDetailVC.h"
#import "YHTRiDetailVC.h"
#import "YPGetBanquetHallList.h"
#import "yhtyudingListModel.h"
#import "RiliModel.h"
#import <BRPickerView.h>

@interface YHTOrderVC ()<JXCategoryViewDelegate,LTSCalendarEventSource,calendarTableviewDelegate,UITableViewDelegate,UITableViewDataSource>{
        NSMutableDictionary *eventsByDate;
    UILabel *selecttimeLab;
    UITableView *orderTableView;
    UIButton *riliBtn ;
    UIButton *orderBtn;
    UIView *riliview;
    UIView *orderView;
    YPHYTHThreeSelectView *selectview;
    NSDate *selectDate;
    NSString *thisYearString;
    
    NSString *orderSelectTimeStr;

    
}
/**<#注释#>*/
@property(nonatomic,strong)JXCategoryTitleView  *categoryView;
@property (nonatomic,strong)LTSCalendarManager *manager;
/**宴会厅数组*/
@property(nonatomic,strong)NSMutableArray  *tingArray;

/**预订日期数组*/
@property(nonatomic,strong)NSMutableArray  *riLiTimeArray;

/**日历当前选择的厅*/
@property(nonatomic,strong)YPGetBanquetHallList  *rilicurrentTingModel;
/**订单当前选择的厅*/
@property(nonatomic,strong)YPGetBanquetHallList  *ordercurrentTingModel;
/**日历预订数组*/
@property(nonatomic,strong)NSMutableArray  *riliDataArray;

/**订单数组*/
@property(nonatomic,strong)NSMutableArray  *orderDataArray;

@end

@implementation YHTOrderVC
-(NSMutableArray *)orderDataArray{
    if (!_orderDataArray) {
        _orderDataArray =[NSMutableArray array];
    }
    return _orderDataArray;
}
-(NSMutableArray *)riliDataArray{
    if (!_riliDataArray) {
        _riliDataArray =[NSMutableArray array];
    }
    return _riliDataArray;
}
-(NSMutableArray *)tingArray{
    if (!_tingArray) {
        _tingArray =[NSMutableArray array];
    }
    return _tingArray;
}
-(NSMutableArray *)riLiTimeArray{
    if (!_riLiTimeArray) {
        _riLiTimeArray =[NSMutableArray array];
    }
    return _riLiTimeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =CHJ_bgColor;
    [self createTopView];
    [self GetBanquetHallList];
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy"];
    thisYearString=[dateformatter stringFromDate:senddate];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadRili)
                                                 name:@"rilireload" object:nil];
 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadOrder)
                                                 name:@"orderReload" object:nil];
    
}
-(void)reloadRili{
    [self  GetdateListWithTingId:_rilicurrentTingModel.BanquetID];
}
-(void)reloadOrder{
    [self GetOrderListRequestWithDate:orderSelectTimeStr];
}
-(void)createTopView{
    UIView *topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    topView.backgroundColor =RGBA(243, 243, 243, 1);
    [self.view addSubview:topView];
    riliBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [riliBtn setTitle:@"日历预订" forState:UIControlStateNormal];
    riliBtn.titleLabel.font =kFont(12);
    [riliBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    [riliBtn setBackgroundImage:[UIImage imageNamed:@"rectbg_left"] forState:UIControlStateNormal];
    riliBtn.frame =CGRectMake(0, 15,ScreenWidth/2, 35);
    [riliBtn addTarget:self action:@selector(addRiLiView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:riliBtn];
    
    orderBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [orderBtn setTitle:@"预订订单" forState:UIControlStateNormal];
    [orderBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    [orderBtn setBackgroundColor:RGBA(243, 243, 243, 1)];
    orderBtn.titleLabel.font =kFont(12);
    orderBtn.frame =CGRectMake(ScreenWidth/2, 15, ScreenWidth/2, 35);
    [orderBtn addTarget:self action:@selector(addOrderView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:orderBtn];
    
  
    
    
    //日历
//    // CalendarShowTypeMultiple 显示多月
//    // CalendarShowTypeSingle   显示单月
//    RMCalendarController *c = [RMCalendarController calendarWithDays:365 showType:CalendarShowTypeMultiple ];
//    c.view.frame =CGRectMake(0, 100, ScreenWidth, ScreenHeight-100-NAVIGATION_BAR_HEIGHT-100-TabBarHeight);
//    // 此处用到MJ大神开发的框架，根据自己需求调整是否需要
//    c.modelArr = [TicketModel objectArrayWithKeyValuesArray:@[@{@"year":@2015, @"month":@7, @"day":@22,
//                                                                @"ticketCount":@194, @"ticketPrice":@283},
//                                                              @{@"year":@2015, @"month":@7, @"day":@17,
//                                                                @"ticketCount":@91, @"ticketPrice":@223},
//                                                              @{@"year":@2015, @"month":@10, @"day":@4,
//                                                                @"ticketCount":@91, @"ticketPrice":@23},
//                                                              @{@"year":@2015, @"month":@7, @"day":@8,
//                                                                @"ticketCount":@2, @"ticketPrice":@203},
//                                                              @{@"year":@2015, @"month":@7, @"day":@28,
//                                                                @"ticketCount":@2, @"ticketPrice":@103},
//                                                              @{@"year":@2015, @"month":@7, @"day":@18,
//                                                                @"ticketCount":@0, @"ticketPrice":@153}]]; //最后一条数据ticketCount 为0时不显示
//    // 是否展现农历
//    c.isDisplayChineseCalendar = YES;
//
//    // YES 没有价格的日期可点击
//    // NO  没有价格的日期不可点击
//    c.isEnable = YES;
//    c.calendarBlock = ^(RMCalendarModel *model) {
//        if (model.ticketModel.ticketCount) {
//            NSLog(@"%lu-%lu-%lu-票价%.1f",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day, model.ticketModel.ticketPrice);
//        } else {
//            NSLog(@"%lu-%lu-%lu",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day);
//        }
//    };
//
//    [self.view addSubview:c.view];
    
    [self initContentView];
    [self addRiLiView];
    
}
-(void)initContentView{
    riliview =[[UIView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-150-TAB_BAR_HEIGHT)];
    riliview.backgroundColor =[UIColor whiteColor];
    
    orderView =[[UIView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-150-TAB_BAR_HEIGHT)];
    orderView.backgroundColor =[UIColor blueColor];
    
    
    UIView *shaixuanView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    shaixuanView.backgroundColor =WhiteColor;
    [orderView addSubview:shaixuanView];
    
 
    selectview = [YPHYTHThreeSelectView yp_threeSelectView];
    [selectview.areaBtn addTarget:self action:@selector(tingClick) forControlEvents:UIControlEventTouchUpInside];
    [selectview.areaBtn setTitle:@"" forState:UIControlStateNormal];
//    [selectview.xiaoliangBtn setTitle:@"月份" forState:UIControlStateNormal];
 
    selectview.xiaoliangBtn.hidden =YES;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY-MM"];
    orderSelectTimeStr = [formatter stringFromDate:[NSDate date]];
    [selectview.priceBtn setTitle:orderSelectTimeStr forState:UIControlStateNormal];
    [selectview.priceBtn addTarget:self action:@selector(stateClick) forControlEvents:UIControlEventTouchUpInside];
    selectview.frame =shaixuanView.frame;
    [shaixuanView addSubview:selectview];
    //
    orderTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-200-TAB_BAR_HEIGHT)];
    orderTableView.delegate =self;
    orderTableView.dataSource =self;
    [orderTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [orderView addSubview:orderTableView];
    
}
-(void)addRiLiView{
    [riliBtn setBackgroundImage:[UIImage imageNamed:@"rectbg_left"] forState:UIControlStateNormal];
    [orderBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [orderBtn setBackgroundColor:RGBA(243, 243, 243, 1)];
    [orderView removeFromSuperview];
    [self.view addSubview:riliview];
    
    
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    self.categoryView.delegate = self;
    self.categoryView.backgroundColor=WhiteColor;
    self.categoryView.titleSelectedColor =MainColor;
    [riliview addSubview:self.categoryView];
    NSMutableArray *titleArr =[NSMutableArray array];
    for (YPGetBanquetHallList *model in self.tingArray) {
        [titleArr addObject:model.BanquetHallName];
    }
    self.categoryView.titles = titleArr;
    self.categoryView.titleColorGradientEnabled = YES;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = MainColor;
    lineView.indicatorLineWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[lineView];
    
    UIView *timeView =[[UIView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, 30)];
    timeView.backgroundColor=WhiteColor;
    [riliview addSubview:timeView];
    selecttimeLab =[[UILabel alloc]init];
    selecttimeLab.font =[UIFont fontWithName:@"PingFangSC-Semibold" size:20];
    selecttimeLab.textColor =BlackColor;
    selecttimeLab.text =@"测试";
    [timeView addSubview:selecttimeLab];
    [selecttimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(timeView);
    }];
    
    UIButton *addOrderBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [addOrderBtn setBackgroundColor:WhiteColor];
    [addOrderBtn setTitle:@"添加预订" forState:UIControlStateNormal];
    [addOrderBtn setTitleColor:RGB(243, 165, 54) forState:UIControlStateNormal];
    [addOrderBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [timeView addSubview:addOrderBtn];
    [addOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(timeView);
        make.right.mas_equalTo(timeView.mas_right).offset(-15);
    }];
    
    self.manager = [LTSCalendarManager new];
    self.manager.eventSource = self;
    self.manager.weekDayView = [[LTSCalendarWeekDayView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 30)];
    [riliview addSubview:self.manager.weekDayView];
    
    self.manager.calenderScrollView = [[LTSCalendarScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.manager.weekDayView.frame), ScreenWidth, ScreenHeight-TAB_BAR_HEIGHT-NAVIGATION_BAR_HEIGHT-200-30)];
    [riliview addSubview:self.manager.calenderScrollView];
//    [self createRandomEvents];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.manager.calenderScrollView.calendarTablewDelegate =self;

}
-(void)addOrderView{
    [orderBtn setBackgroundImage:[UIImage imageNamed:@"rectbg_right"] forState:UIControlStateNormal];
    [riliBtn setBackgroundColor:RGBA(243, 243, 243, 1)];
    [riliBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];

    [riliview removeFromSuperview];
    [self.view addSubview:orderView];
}
// 该日期是否有事件
- (BOOL)calendarHaveEventWithDate:(NSDate *)date {
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    return NO;
}
//当前 选中的日期  执行的方法
- (void)calendarDidSelectedDate:(NSDate *)date {
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
//    self.label.text =  key;
    NSArray *events = eventsByDate[key];
    selecttimeLab.text = key;
    selectDate =date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *selectDate = [formatter stringFromDate:date];
    [self GetYudingListRequestWithDate:selectDate];
//    if (events.count>0) {
//
//        //该日期有事件    tableView 加载数据
//    }
}
#pragma mark ------------tabeviewdatascource----------
//日历
-(NSInteger)calendartableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.riliDataArray.count;
}
-(UITableViewCell*)calendartableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    yhtorderriliCell *cell =[yhtorderriliCell cellWithTableView:tableView];
    cell.contentView.backgroundColor =CHJ_bgColor;
    cell.model =self.riliDataArray[indexPath.row];
    return cell;
}
//订单
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderDataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    yhtorderCell *cell =[yhtorderCell cellWithTableView:tableView];
    cell.contentView.backgroundColor =CHJ_bgColor;
    cell.model =self.orderDataArray[indexPath.row];
    return cell;
}
#pragma mark --------------tableviewdelegate-------
-(CGFloat)calendartableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
-(void)calendartableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YHTRiDetailVC *detailVC =[YHTRiDetailVC new];
    yhtyudingListModel *model =_riliDataArray[indexPath.row];
    detailVC.Id =model.Id;
    detailVC.tingId =self.rilicurrentTingModel.BanquetID;
    [[self getviewController].navigationController pushViewController:detailVC animated:YES];
}
//订单
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YHTOrderDetailVC *detailVC = [YHTOrderDetailVC new];
    yhtyudingListModel *model =_orderDataArray[indexPath.row];
    detailVC.Id =model.Id;
    [[self getviewController].navigationController pushViewController:detailVC animated:YES];
}
#pragma mark ******************订单target*******************
-(void)addClick{
  
    AddYHTOrderVC *addvc = [AddYHTOrderVC new];
    addvc.timeDate =selectDate;
    addvc.tingName =self.rilicurrentTingModel.BanquetHallName;
    addvc.tingID =self.rilicurrentTingModel.BanquetID;
    [[self getviewController].navigationController pushViewController:addvc animated:YES];
}
-(void)tingClick{
    NSMutableArray *titleArray =[NSMutableArray array];
    for (YPGetBanquetHallList *model in self.tingArray) {
        [titleArray addObject:model.BanquetHallName];
    }

    WTTableAlertView* alertview = [WTTableAlertView initWithTitle:@"选择宴会厅" options:titleArray singleSelection:YES selectedItems:@[@(3)] completionHandler:^(NSArray * _Nullable options) {
        for (id obj in options) {
            NSLog(@"单选，且隐藏确定按钮:%@", obj);
            NSInteger index =[obj integerValue];
            self.ordercurrentTingModel =_tingArray[index];
            [selectview.areaBtn setTitle:titleArray[index] forState:UIControlStateNormal];
            
            [self GetOrderListRequestWithDate:orderSelectTimeStr];
        }
        
    }];
    alertview.hiddenConfirBtn = YES;
    [alertview show];
}
//-(void)monthsClick{
//    NSArray *monthArr=@[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
//    WTTableAlertView* alertview = [WTTableAlertView initWithTitle:@"选择月份" options:monthArr singleSelection:YES selectedItems:@[@(3)] completionHandler:^(NSArray * _Nullable options) {
//        for (id obj in options) {
//            NSLog(@"单选，且隐藏确定按钮:%@", obj);
//            NSInteger index =[obj integerValue];
//
//            [selectview.xiaoliangBtn setTitle:monthArr[index] forState:UIControlStateNormal];
//
//        }
//
//    }];
//    alertview.hiddenConfirBtn = YES;
//    [alertview show];
//}
-(void)stateClick{

    
    [BRDatePickerView showDatePickerWithTitle:@"请选择时间" dateType:BRDatePickerModeYM defaultSelValue:@"" minDate:nil maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
        
//        starTimeStr =selectValue;
//        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
//        [thisTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        [selectview.priceBtn setTitle:selectValue forState:UIControlStateNormal];
        orderSelectTimeStr =selectValue;
        [self GetOrderListRequestWithDate:orderSelectTimeStr];

    }];
}
- (void)createRandomEvents
{
    eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!eventsByDate[key]){
            eventsByDate[key] = [NSMutableArray new];
        }
        
        [eventsByDate[key] addObject:randomDate];
        
    }
    [self.manager reloadAppearanceAndData];
}
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy.MM.dd";
    }
    
    return dateFormatter;
}
- (UIViewController *)getviewController {
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

//点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    NSLog(@"%zd",index);
    self.rilicurrentTingModel =_tingArray[index];
    [self GetdateListWithTingId:_rilicurrentTingModel.BanquetID];
}


#pragma mark***********************网络请求*********************
//根据服务商id获取宴会厅列表
- (void)GetBanquetHallList{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetBanquetHallList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] =FacilitatorId_New;
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
                        NSLog(@"宴会厅列表返回%@",object);
            
            self.tingArray = [YPGetBanquetHallList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

            [self addRiLiView];
            
            if (_tingArray.count>0) {
                self.rilicurrentTingModel =self.tingArray[0];
                self.ordercurrentTingModel =self.tingArray[0];
                [self GetdateListWithTingId:_rilicurrentTingModel.BanquetID];
                [self GetOrderListRequestWithDate:orderSelectTimeStr];
                
            }
            [selectview.areaBtn setTitle:self.ordercurrentTingModel.BanquetHallName forState:UIControlStateNormal];

            
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
//根据年份获取全年预订信息
- (void)GetdateListWithTingId:(NSString *)Id{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetYearBanquetlReserveList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
   
    params[@"BanquetId"] =Id;
    params[@"Year"] =thisYearString;

    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"日期%@",object);
//
//            self.riLiTimeArray = [RiliModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            [self.riLiTimeArray removeAllObjects];
            for (NSDictionary *dic  in object[@"Data"]) {
                
                if ([[dic allKeys] containsObject:@"Day"] && [[dic allKeys] containsObject:@"Number"]) {
                    
                    NSString *day = dic[@"Day"];
                    NSString *number = dic[@"Number"];
                    if (!ISEMPTY(day) || !ISEMPTY(number) ) {
                         [self.riLiTimeArray addObject:[RiliModel mj_objectWithKeyValues:dic]];
                    }
                }
            }
            
            eventsByDate = [NSMutableDictionary new];

            for (int i=0; i<self.riLiTimeArray.count; i++) {
                RiliModel *model =self.riLiTimeArray[i];
                if (![model.Number isEqualToString:@""]) {
                    NSArray *array = [model.Number componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
                    for (int j =0; j<array.count; j++) {
                        NSString *key;
                        NSString *timeStr;
                        if (i<9) {
                            if ([array[j] integerValue]<10) {
                                key =[NSString stringWithFormat:@"%@.0%d.0%@",thisYearString, i+1,array[j]];
                                timeStr =[NSString stringWithFormat:@"%@-0%d-0%@ 00:00:00.000",thisYearString, i+1,array[j]];

                            }else{
                                key =[NSString stringWithFormat:@"%@.0%d.%@",thisYearString, i+1,array[j]];
                                timeStr =[NSString stringWithFormat:@"%@-0%d-%@ 00:00:00.000",thisYearString, i+1,array[j]];

                            }

                        }
                                        if(!eventsByDate[key]){
                                            eventsByDate[key] = [NSMutableArray new];
                                        }
                         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
                         [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
                        NSDate *birthdayDate = [dateFormatter dateFromString:timeStr];
                        if (birthdayDate !=nil) {
                            [eventsByDate[key] addObject:birthdayDate];
                        }           
                    }

                }
            }
            
                       [self.manager reloadAppearanceAndData];
            
//
//            for(int i = 0; i < 30; ++i){
//                // Generate 30 random dates between now and 60 days later
//                NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
//
//                // Use the date as key for eventsByDate
//                NSString *key = [[self dateFormatter] stringFromDate:randomDate];
//
//                if(!eventsByDate[key]){
//                    eventsByDate[key] = [NSMutableArray new];
//                }
//
//                [eventsByDate[key] addObject:randomDate];
//            }
//            [self.manager reloadAppearanceAndData];
            
            
               NSDate *date = [NSDate date];
             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
             [formatter setDateFormat:@"yyyy-MM-dd"];
             NSString *time_now = [formatter stringFromDate:date];
            
            
            [self GetYudingListRequestWithDate:time_now];
            
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

- (void)GetYudingListRequestWithDate:(NSString*)date{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetBanquetlReserveList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"BanquetId"] =self.rilicurrentTingModel.BanquetID;
    params[@"Time"]=date;
    params[@"TimeType"]=@"0";//0按天查找,1按月查找,2按年,3当前日期以后全部

    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"预订列表%@",object);
            //
            self.riliDataArray = [yhtyudingListModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            [self.manager.calenderScrollView.tableView reloadData];
            
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


- (void)GetOrderListRequestWithDate:(NSString*)date{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetBanquetlReserveList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"BanquetId"] =self.ordercurrentTingModel.BanquetID;
    params[@"Time"]=date;
    params[@"TimeType"]=@"1";//0按天查找,1按月查找,2按年,3当前日期以后全部
    
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"预订列表%@",object);
            //
            self.orderDataArray = [yhtyudingListModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            [orderTableView reloadData];
            
            if (self.orderDataArray.count==0) {
                [self showNoDataEmptyView];
            }else{
                [EasyShowEmptyView hiddenEmptyView:orderTableView];
            }
            
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

-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"这里空空的，暂时什么也没有" subTitle:@"" imageName:@"chahu" inview:orderTableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        
    }];
    
}

@end
