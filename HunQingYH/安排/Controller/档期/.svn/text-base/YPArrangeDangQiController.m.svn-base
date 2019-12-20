//
//  YPArrangeDangQiController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/16.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPArrangeDangQiController.h"
#import "ZJScrollPageViewDelegate.h"
#import <FSCalendar.h>
#import "YPArrangeDangQiEventCell.h"
#import "YPArrangeDangQiDriverEventCell.h"//车手档期
#import "YPArrangeDangQiSelfEventCell.h"//自填档期
#import "YPTotalScheduleModel.h"
#import "YPGetScheduleList.h"
//车手模型
#import "YPDriverTotalScheduleModel.h"
#import "YPGetDriverScheduleList.h"

#import "YPAddArrangeController.h"
#import "YPGetDriverTimetableListByDriverID.h"
#import "YPANAAcceptDetailController.h"//婚车 已接受 详情 -- 内容/车手
#import "YPOtherArrangeNewAddAcceptDetailController.h"//其他 已接受 详情 -- 只有内容
#import "YPArrangeSelfAddController.h"//自填详情界面

@interface YPArrangeDangQiController ()<ZJScrollPageViewChildVcDelegate,UITableViewDataSource,UITableViewDelegate,FSCalendarDataSource,FSCalendarDelegate,UIGestureRecognizerDelegate>{
    void * _KVOContext;
    NSString *deleteID;
    NSString *carDeleteID;//车手删除ID
    UILabel *sectionlabel;
    UILabel *sectiontime ;
}
@property (strong, nonatomic) FSCalendar *calendar;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;
@property (strong, nonatomic) NSArray *datesWithEvent;//事件数组

@property (nonatomic, strong) NSMutableArray *eventDateMarr;//有事件天数 数组

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *selectDate;

/** 婚车和其他供应商数据*/
@property (nonatomic, strong) NSMutableArray<YPTotalScheduleModel *> *scheduleMarr;
@property (nonatomic, strong) NSMutableArray *listMarr;

/** 车手 数据*/
@property (nonatomic, strong) NSMutableArray<YPDriverTotalScheduleModel *> *driverMarr;
@property (nonatomic, strong) NSMutableArray *carMarr;

@end

@implementation YPArrangeDangQiController{
    FSCalendar *_calendar;
    NSInteger _requestTag;
}



- (void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
//    _requestTag = 0;
    [self setupUI];
    [self rereshData];
}
-(void)rereshData{
    self.selectDate =nil;
    
    [self getCurrentMonthData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
}
- (void)setupUI{
    
    
    _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 1, ScreenWidth, 300)];
    
    _calendar.dataSource = self;
    _calendar.delegate = self;
    _calendar.backgroundColor = WhiteColor;
    _calendar.calendarWeekdayView.backgroundColor = CHJ_bgColor;
    _calendar.appearance.weekdayTextColor = GrayColor;
    _calendar.appearance.headerTitleColor = BlackColor;
    _calendar.appearance.headerTitleFont = [UIFont boldSystemFontOfSize:17];
    [self.view addSubview:_calendar];
    self.calendar = _calendar;
    
    [self.calendar selectDate:[NSDate date] scrollToDate:YES];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.calendar action:@selector(handleScopeGesture:)];
    panGesture.delegate = self;
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 2;
    [self.view addGestureRecognizer:panGesture];
    self.scopeGesture = panGesture;
    
    // While the scope gesture begin, the pan gesture of tableView should cancel.
    [self.tableView.panGestureRecognizer requireGestureRecognizerToFail:panGesture];
    
    [self.calendar addObserver:self forKeyPath:@"scope" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:_KVOContext];
    
    self.calendar.scope = FSCalendarScopeMonth;//初始按月展示
    
    // For UITest
    self.calendar.accessibilityIdentifier = @"calendar";
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.calendar.frame), ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-CGRectGetHeight(self.calendar.frame)-10) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.view addSubview:self.tableView];
}

- (void)getCurrentMonthData{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:[NSDate date]];
    NSDateComponents *lastDateComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear |NSCalendarUnitDay fromDate:firstDay];
    NSUInteger dayNumberOfMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+dayNumberOfMonth-1];
    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd";
    NSString *first = [dateFormatter stringFromDate:firstDay];
    NSString *last = [dateFormatter stringFromDate:lastDay];
    
    if (CheShou(Profession_New)) {//车手档期 -- 每天只有一个事件
        [self GetDriverScheduleListWithBeginTime:first AndEndTime:last];
    }else{
        [self GetScheduleListBeginTime:first AndEndTime:last];
    }
    
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == _KVOContext) {
        FSCalendarScope oldScope = [change[NSKeyValueChangeOldKey] unsignedIntegerValue];
        FSCalendarScope newScope = [change[NSKeyValueChangeNewKey] unsignedIntegerValue];
        NSLog(@"From %@ to %@",(oldScope==FSCalendarScopeWeek?@"week":@"month"),(newScope==FSCalendarScopeWeek?@"week":@"month"));
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - <UIGestureRecognizerDelegate>

// Whether scope gesture should begin
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top;
    if (shouldBegin) {
        CGPoint velocity = [self.scopeGesture velocityInView:self.view];
        switch (self.calendar.scope) {
            case FSCalendarScopeMonth:
                return velocity.y < 0;
            case FSCalendarScopeWeek:
                return velocity.y > 0;
        }
    }
    return shouldBegin;
}

#pragma mark - <FSCalendarDataSource>

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    if ([self.datesWithEvent containsObject:dateString]) {
        return 1;
    }
    return 0;
}

#pragma mark - <FSCalendarDelegateAppearance>

//- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventColorForDate:(NSDate *)date
//{
//    NSString *dateString = [self.dateFormatter2 stringFromDate:date];
//    if ([self.datesWithEvent containsObject:dateString]) {
//        return NavBarColor;
//    }
//    return nil;
//}

//- (NSArray *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
//{
//    NSString *dateString = [self.dateFormatter2 stringFromDate:date];
//    if ([self.datesWithMultipleEvents containsObject:dateString]) {
//        return @[NavBarColor,appearance.eventDefaultColor,[UIColor blackColor]];
//    }
//    return nil;
//}

#pragma mark - <FSCalendarDelegate>

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    //    NSLog(@"%@",(calendar.scope==FSCalendarScopeWeek?@"week":@"month"));
    self.calendar.height = CGRectGetHeight(bounds);
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.calendar.frame), ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1-self.calendar.height);
    
    [self.view layoutIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[self.dateFormatter stringFromDate:obj]];
    }];
    NSLog(@"selected dates is %@",selectedDates);
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
    
    self.selectDate = [self.dateFormatter stringFromDate:date];
    
//    [self GetScheduleListBeginTime:self.selectDate AndEndTime:self.selectDate];

    //车手和其他 分开
    if (CheShou(Profession_New)) {//车手档期 -- 每天只有一个事件 -- 9.25 还有自填
        [self GetDriverScheduleListWithBeginTime:self.selectDate AndEndTime:self.selectDate];
    }else{
        [self GetScheduleListBeginTime:self.selectDate AndEndTime:self.selectDate];
    }
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"%s %@", __FUNCTION__, [self.dateFormatter stringFromDate:calendar.currentPage]);
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if ([self.selectDate isEqualToString:@"2017-08-25"]) {
//        NSInteger numbers[2] = {2,1};
//        return numbers[section];
//    }else{
//        NSInteger numbers[2] = {2,4};
//        return numbers[section];
//        return numbers[section];
//    }

    if (section == 0) {
        return 2;
    }else{
        if (CheShou(Profession_New)) {//9.25 修改 车手有自填安排
            if (self.carMarr.count > 0) {
                return self.carMarr.count;
            }else{
                return 1;
            }
        }else{
            if (self.listMarr.count > 0) {
                return self.listMarr.count;
            }else{
                return 1;
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        NSString *identifier = @[@"cell_month",@"cell_week"][indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"显示月历";
        }else{
            cell.textLabel.text = @"显示周历";
        }
        
        return cell;
    } else {
        
        if (CheShou(Profession_New)) {
            
            if (self.carMarr.count > 0) {//车手 只有一种 队长给安排的 不能自填 -- 9.25 修改 车手可自填
                
                YPGetDriverScheduleList *driverModel = self.carMarr[indexPath.row];
                
                if (driverModel.ScheduleType == 1) {//1自填 2安排
                    YPArrangeDangQiSelfEventCell *cell = [YPArrangeDangQiSelfEventCell cellWithTableView:tableView];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    [cell.iconImgV setImage:[UIImage imageNamed:@"提醒"]];
                    cell.titleLabel.text = driverModel.Title;
                    cell.content.text = driverModel.LogContent;
                    [cell.deleteBtn addTarget:self action:@selector(carDeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.editBtn addTarget:self action:@selector(carXiugaiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    return cell;
                }else if (driverModel.ScheduleType == 2) {//1自填 2安排

                    YPArrangeDangQiDriverEventCell *cell = [YPArrangeDangQiDriverEventCell cellWithTableView:tableView];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;

                    
                    cell.driverModel = driverModel;
                    
                    return cell;
                }
                
            }else{
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]init];
                }
                cell.textLabel.text = @"当前无档期安排";
                return cell;
            }
            
        }else{
            
            if (self.listMarr.count > 0) {
                
                YPGetScheduleList *list = self.listMarr[indexPath.row];
                
                if (list.ScheduleType == 1) {//1自填 2安排
                    YPArrangeDangQiSelfEventCell *cell = [YPArrangeDangQiSelfEventCell cellWithTableView:tableView];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    [cell.iconImgV setImage:[UIImage imageNamed:@"提醒"]];
                    cell.titleLabel.text = list.Title;
                    cell.content.text = list.LogContent;
                    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.editBtn addTarget:self action:@selector(xiugaiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    return cell;
                }else if (list.ScheduleType == 2) {//1自填 2安排
                    YPArrangeDangQiEventCell *cell = [YPArrangeDangQiEventCell cellWithTableView:tableView];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.scheduleModel =list;

                    return cell;
                }
            }else{
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]init];
                }
                cell.textLabel.text = @"当前无档期安排";
                return cell;
            }
        }
    }
    return nil;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        FSCalendarScope selectedScope = indexPath.row == 0 ? FSCalendarScopeMonth : FSCalendarScopeWeek;
        [self.calendar setScope:selectedScope animated:YES];
        
    }else if (indexPath.section == 1) {
        
        if (self.listMarr.count > 0) {
            
            YPGetScheduleList *list = self.listMarr[indexPath.row];
            
            if (HunChe(Profession_New)) {//婚车 - 已接受详情 - 内容/车手
                
                if (list.ScheduleType == 1) {//1自填 2安排
                    
                    YPArrangeSelfAddController *selfAdd = [[YPArrangeSelfAddController alloc]init];
                    selfAdd.titleStr = list.Title;
                    selfAdd.logContentStr = list.LogContent;
                    selfAdd.weddingDateStr = list.WeddingDate;
                    
                    UIViewController *myVC = [self getviewController];
                    [myVC.navigationController pushViewController:selfAdd animated:YES];
                    
                }else if (list.ScheduleType == 2) {//1自填 2安排
                    
                    YPANAAcceptDetailController *detail = [[YPANAAcceptDetailController alloc]init];
                    detail.supplierOrderID = list.OrderID;
                    detail.corpName = list.CorpName;
                    detail.corpLogo = list.CorpLogo;
                    detail.corpPhone = list.CorpPhone;
                    
                    detail.weddingTime = list.WeddingDate;//注意: 添加婚期
                    
                    UIViewController *myVC = [self getviewController];
                    [myVC.navigationController pushViewController:detail animated:YES];
                    
                }
  
            }else{//其他供应商 - 已接受详情 - 内容
                
                if (list.ScheduleType == 1) {//1自填 2安排
                    
                    YPArrangeSelfAddController *selfAdd = [[YPArrangeSelfAddController alloc]init];
                    selfAdd.titleStr = list.Title;
                    selfAdd.logContentStr = list.LogContent;
                    selfAdd.weddingDateStr = list.WeddingDate;
                    
                    UIViewController *myVC = [self getviewController];
                    [myVC.navigationController pushViewController:selfAdd animated:YES];
                    
                }else if (list.ScheduleType == 2) {//1自填 2安排
                
                    YPOtherArrangeNewAddAcceptDetailController *other = [[YPOtherArrangeNewAddAcceptDetailController alloc]init];
                    other.supplierOrderID = list.OrderID;//只需要订单ID 下边参数没用
                    other.corpName = list.CorpName;
                    other.corpLogo = list.CorpLogo;
                    other.corpPhone = list.CorpPhone;
                    
                    other.weddingTime = list.WeddingDate;
                    
                    UIViewController *myVC = [self getviewController];
                    [myVC.navigationController pushViewController:other animated:YES];
                }
                
            }
        }
        
        
        if (self.carMarr.count > 0) {//车手专用
            
            //车手不能查看详情 -- 9.25 修改 可查看自填
            YPGetDriverScheduleList *driverModel = self.carMarr[indexPath.row];
            
            if (driverModel.ScheduleType == 1) {//1自填 2安排
                
                YPArrangeSelfAddController *selfAdd = [[YPArrangeSelfAddController alloc]init];
                selfAdd.titleStr = driverModel.Title;
                selfAdd.logContentStr = driverModel.LogContent;
                selfAdd.weddingDateStr = driverModel.WeddingDate;
                
                UIViewController *myVC = [self getviewController];
                [myVC.navigationController pushViewController:selfAdd animated:YES];
                
            }
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 30;
    }else{
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = CHJ_bgColor;
        
        sectionlabel = [[UILabel alloc]init];
        if (!self.selectDate) {
            sectionlabel.text = @"本月安排";
        }else{
            sectionlabel.text = @"当天安排";
        }
        
        [view addSubview:sectionlabel];
        [sectionlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(view);
        }];
        
        sectiontime = [[UILabel alloc]init];
        sectiontime.text = self.selectDate;
        sectiontime.textColor = GrayColor;
        [view addSubview:sectiontime];
        [sectiontime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(sectionlabel.mas_right).mas_offset(10);
            make.centerY.mas_equalTo(sectionlabel);
        }];
        
        return view;
    }
    return nil;
}

#pragma mark - target
//修改个人档期
-(void)xiugaiBtnClick:(id)sender{
    YPAddArrangeController *addVC = [[YPAddArrangeController alloc]init];
    //获取点击的cell
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * path = [self.tableView indexPathForCell:cell];
//     YPArrangeDangQiSelfEventCell *cell1 = [self.tableView cellForRowAtIndexPath:path];
    
    YPGetScheduleList *list = self.listMarr[path.row];
    addVC.leixingStr =@"2";
    addVC.anpaiTitle =list.Title;
    YPTotalScheduleModel *model =self.scheduleMarr[0];
    addVC.selectTime =model.ScheduleTime;
    addVC.anpaiNeiRong =list.LogContent;
    addVC.ScheduleID =[list.ScheduleID integerValue];
    
    UIViewController *myVC=[self getviewController];
 
    [myVC.navigationController pushViewController:addVC animated:YES];
}
//删除个人档期
-(void)deleteBtnClick:(id)sender{
    //获取点击的cell
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * path = [self.tableView indexPathForCell:cell];
    //     YPArrangeDangQiSelfEventCell *cell1 = [self.tableView cellForRowAtIndexPath:path];
    
    YPGetScheduleList *list = self.listMarr[path.row];
 
    deleteID =list.ScheduleID;
    
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"删除安排？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag =1000;
    [alertView show];

   NSLog(@"%@",deleteID);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if(buttonIndex == 1 && alertView.tag == 1000) {
        [self deleteAnpaiRequest];
      
    }
    
}

#pragma mark 车手
- (void)carDeleteBtnClick:(UIButton *)sender{
    
    //获取点击的cell
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * path = [self.tableView indexPathForCell:cell];
    
    YPGetDriverScheduleList *list = self.carMarr[path.row];
    
    carDeleteID = list.ScheduleID;
    
    [self DelDriverSchedule];
}

- (void)carXiugaiBtnClick:(UIButton *)sender{
    
    YPAddArrangeController *addVC = [[YPAddArrangeController alloc]init];
    //获取点击的cell
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * path = [self.tableView indexPathForCell:cell];
    
    YPGetDriverScheduleList *list = self.carMarr[path.row];
    addVC.leixingStr = @"2";
    addVC.anpaiTitle = list.Title;
    YPDriverTotalScheduleModel *model = self.driverMarr[0];
    addVC.selectTime = model.WeddingDate;
    addVC.anpaiNeiRong = list.LogContent;
    addVC.ScheduleID = [list.ScheduleID integerValue];
    
    UIViewController *myVC=[self getviewController];
    
    [myVC.navigationController pushViewController:addVC animated:YES];
    
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

#pragma mark - 网络请求
#pragma mark 获取档期列表
- (void)GetScheduleListBeginTime:(NSString *)begin AndEndTime:(NSString *)end{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetScheduleList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"SupplierType"] = @"0";//0、全部 1、自填 2、安排
    params[@"SettlementType"] = @"0";//0、全部 1、已结算 2、未结算
    params[@"BeginTime"] = begin;
    params[@"EndTime"] = end;
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"1000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"%@",object);
            [self.scheduleMarr removeAllObjects];
            [self.listMarr removeAllObjects];
            if (!self.selectDate) {
                [self.eventDateMarr removeAllObjects];
            }
        
            self.scheduleMarr = [YPTotalScheduleModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
     
         
            for (YPTotalScheduleModel *model in self.scheduleMarr) {
                [self.eventDateMarr addObject:model.ScheduleTime];
                
                for (YPGetScheduleList *list in model.Data) {
                    [self.listMarr addObject:list];
                }
            }
            
            NSLog(@"档期 - %@ - %@ - %@",self.selectDate,self.scheduleMarr,self.listMarr);
            
//            [self.tableView reloadData];
            
//            if (!self.selectDate) {
//                [self setupUI];
//                NSLog(@"%zd",self.scheduleMarr.count);
//                [_calendar reloadData];
//            }else{
//              
//            }
            
            [self.tableView reloadData];
            [_calendar reloadData];
            if (self.listMarr.count > 0) {
                
            }else{
                
                [EasyShowTextView showText:@"当前暂无数据!"];
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

- (void)deleteAnpaiRequest{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/DelSupplierSchedule";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"ScheduleID"] = deleteID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self getCurrentMonthData];
            
            
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

#pragma mark - 车手专用
#pragma mark - 车手获取自己档期列表
- (void)GetDriverScheduleListWithBeginTime:(NSString *)begin AndEndTime:(NSString *)end{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetDriverScheduleList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"DriverID"] = UserId_New;
    params[@"BeginTime"] = begin;
    params[@"EndTime"] = end;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.driverMarr removeAllObjects];
            [self.carMarr removeAllObjects];
//            [self.eventDateMarr removeAllObjects];
            
            self.driverMarr = [YPDriverTotalScheduleModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

            for (YPDriverTotalScheduleModel *model in self.driverMarr) {
                [self.eventDateMarr addObject:model.WeddingDate];
                
                for (YPGetDriverScheduleList *list in model.Data) {
                    [self.carMarr addObject:list];
                }
            }
            
            [_calendar reloadData];
            [self.tableView reloadData];
            
            if (self.carMarr.count > 0) {
                
            }else{
                
                [EasyShowTextView showText:@"当前暂无数据!"];
                
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

#pragma mark 车手删除档期
- (void)DelDriverSchedule{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/DelDriverSchedule";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"DriverID"] = UserId_New;
    params[@"ScheduleID"] = carDeleteID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.eventDateMarr removeAllObjects];
            self.selectDate = @"";
            
            [self getCurrentMonthData];
            
            
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

#pragma mark - getter
- (NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}

//- (NSDateFormatter *)dateFormatter2{
//    if (!_dateFormatter2) {
//        _dateFormatter2 = [[NSDateFormatter alloc]init];
//        _dateFormatter2.dateFormat = @"yyyy-MM-dd";
//    }
//    return _dateFormatter2;
//}

- (NSArray *)datesWithEvent{
    if (!_datesWithEvent) {
        _datesWithEvent = self.eventDateMarr;
    }
    return _datesWithEvent;
}

//- (NSArray *)datesWithMultipleEvents{
//    if (!_datesWithMultipleEvents) {
//        _datesWithMultipleEvents = @[@"2017-08-08",@"2017-08-16",@"2017-08-20",@"2017-08-28"];
//    }
//    return _datesWithMultipleEvents;
//}

- (NSMutableArray *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (NSMutableArray<YPTotalScheduleModel *> *)scheduleMarr{
    if (!_scheduleMarr) {
        _scheduleMarr = [NSMutableArray array];
    }
    return _scheduleMarr;
}

- (NSMutableArray<YPDriverTotalScheduleModel *> *)driverMarr{
    if (!_driverMarr) {
        _driverMarr = [NSMutableArray array];
    }
    return _driverMarr;
}

- (NSMutableArray *)carMarr{
    if (!_carMarr) {
        _carMarr = [NSMutableArray array];
    }
    return _carMarr;
}

- (NSMutableArray *)eventDateMarr{
    if (!_eventDateMarr) {
        _eventDateMarr = [NSMutableArray array];
    }
    return _eventDateMarr;
}

- (void)dealloc
{
    [self.calendar removeObserver:self forKeyPath:@"scope" context:_KVOContext];
    NSLog(@"%s",__FUNCTION__);
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
