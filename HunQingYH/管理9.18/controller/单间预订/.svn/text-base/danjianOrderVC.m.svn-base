//
//  danjianOrderVC.m
//  HunQingYH
//
//  Created by xl on 2019/6/17.
//  Copyright © 2019 xl. All rights reserved.
//

#import "danjianOrderVC.h"
#import "LTSCalendarManager.h"
#import "danjianOrderCell.h"
#import "danjianOrderModel.h"
#import "danjianOrderSubModel.h"
#import "danjianOrderDetailVC.h"
#import "danjianAddVC.h"
@interface danjianOrderVC ()<LTSCalendarEventSource,calendarTableviewDelegate>{
      UILabel *selecttimeLab;
    NSMutableDictionary *eventsByDate;
    NSDate *selectDate;


}
@property (nonatomic,strong)LTSCalendarManager *manager;
/**n*/
@property(nonatomic,strong)NSMutableArray  *dataArray;
@end

@implementation danjianOrderVC
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =CHJ_bgColor;
    [self createriliview];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *selectDatestr = [formatter stringFromDate:[NSDate date]];
    selectDate =[NSDate date];
    [self GetDanjianListRequestWithDate:selectDatestr];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloaddanjian)
                                                 name:@"danjiReload" object:nil];

}
-(void)reloaddanjian{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *selectDate1 = [formatter stringFromDate:selectDate];
    [self GetDanjianListRequestWithDate:selectDate1];
}
-(void)createriliview{
    
    UIView *timeView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    timeView.backgroundColor=WhiteColor;
    [self.view addSubview:timeView];
    selecttimeLab =[[UILabel alloc]init];
    selecttimeLab.font =[UIFont fontWithName:@"PingFangSC-Semibold" size:20];
    selecttimeLab.textColor =BlackColor;
    selecttimeLab.text =@"测试";
    [timeView addSubview:selecttimeLab];
    [selecttimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(timeView);
    }];
    self.manager = [LTSCalendarManager new];
    self.manager.eventSource = self;
    self.manager.weekDayView = [[LTSCalendarWeekDayView alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 30)];
    [self.view addSubview:self.manager.weekDayView];
    
    self.manager.calenderScrollView = [[LTSCalendarScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.manager.weekDayView.frame), ScreenWidth, ScreenHeight-TAB_BAR_HEIGHT-NAVIGATION_BAR_HEIGHT-100-30)];
    [self.view addSubview:self.manager.calenderScrollView];
    [self createRandomEvents];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.manager.calenderScrollView.calendarTablewDelegate =self;
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
    NSString *selectDate1 = [formatter stringFromDate:date];
    [self GetDanjianListRequestWithDate:selectDate1];
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
- (void)createRandomEvents
{
    eventsByDate = [NSMutableDictionary new];
    
//    for(int i = 0; i < 30; ++i){
//        // Generate 30 random dates between now and 60 days later
//        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
//        
//        // Use the date as key for eventsByDate
//        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
//        
//        if(!eventsByDate[key]){
//            eventsByDate[key] = [NSMutableArray new];
//        }
//        
//        [eventsByDate[key] addObject:randomDate];
//    }
    [self.manager reloadAppearanceAndData];
}
#pragma mark ------------tabeviewdatascource----------
//日历
-(NSInteger)calendartableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell*)calendartableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    danjianOrderCell *cell =[danjianOrderCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor =WhiteColor;
    cell.model =self.dataArray[indexPath.row];
    cell.wucanBtn.tag =indexPath.row;
    cell.wancanBtn.tag =indexPath.row;
    [cell.wucanBtn addTarget:self action:@selector(wucanlClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.wancanBtn addTarget:self action:@selector(wancanClick:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}
//订单
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

#pragma mark --------------tableviewdelegate-------
-(CGFloat)calendartableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
-(void)calendartableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -----------------target-------
-(void)wucanlClick:(UIButton *)btn{
    danjianOrderModel *model =_dataArray[btn.tag];
    if (model.Data_1.count==0) {
        //添加
        NSLog(@"添加午餐");
        danjianAddVC *addvc =[danjianAddVC new];
        addvc.timeDate =selectDate;
        addvc.danjianName =model.Name;
        addvc.Id=model.RoomId;
        addvc.type =@"0";
        [[self getviewController].navigationController pushViewController:addvc animated:YES];
    }else if(model.Data_1.count ==1){
        danjianOrderSubModel *submodel =model.Data_1[0];
        if([submodel.Type integerValue] ==0){
            NSLog(@"午餐id%@",submodel.Id);
            
            danjianOrderDetailVC *detailVC = [danjianOrderDetailVC new];
            detailVC.Id =submodel.Id;
            detailVC.type =@"0";
            detailVC.danjianId =model.RoomId;
            detailVC.danjianArray =self.dataArray;

            [[self getviewController].navigationController pushViewController:detailVC animated:YES];
        }else{
            NSLog(@"添加午餐");

            danjianAddVC *addvc =[danjianAddVC new];
            addvc.timeDate =selectDate;
            addvc.danjianName =model.Name;
            addvc.Id=model.RoomId;
            addvc.type =@"0";
            [[self getviewController].navigationController pushViewController:addvc animated:YES];
        }
        
    } else{
        //详情
        danjianOrderSubModel *submodel =[danjianOrderSubModel new];
        for (danjianOrderSubModel *indexmodel in model.Data_1) {
            if ([indexmodel.Type integerValue] ==0) {
                submodel =indexmodel;
                break;
            }
        }
        NSLog(@"午餐id%@",submodel.Id);
        
        danjianOrderDetailVC *detailVC = [danjianOrderDetailVC new];
        detailVC.Id =submodel.Id;
        detailVC.type =@"0";
        detailVC.danjianId =model.RoomId;
        detailVC.danjianArray =self.dataArray;

        [[self getviewController].navigationController pushViewController:detailVC animated:YES];
        
    }
        
    
}
-(void)wancanClick:(UIButton *)btn{
    danjianOrderModel *model =_dataArray[btn.tag];
    if (model.Data_1.count==0) {
        //添加
        NSLog(@"添加晚餐");
        
        danjianAddVC *addvc =[danjianAddVC new];
        addvc.timeDate =selectDate;
        addvc.danjianName =model.Name;
        addvc.Id=model.RoomId;
        addvc.type =@"1";
        [[self getviewController].navigationController pushViewController:addvc animated:YES];
    }else if(model.Data_1.count ==1){
        danjianOrderSubModel *submodel =model.Data_1[0];
        if([submodel.Type integerValue] ==1){
              NSLog(@"晚餐id%@",submodel.Id);
            
            danjianOrderDetailVC *detailVC = [danjianOrderDetailVC new];
            detailVC.Id =submodel.Id;
            detailVC.type =@"1";
            detailVC.danjianId =model.RoomId;
            detailVC.danjianArray =self.dataArray;
            [[self getviewController].navigationController pushViewController:detailVC animated:YES];
        }else{
            NSLog(@"添加晚餐");
            
            danjianAddVC *addvc =[danjianAddVC new];
            addvc.timeDate =selectDate;
            addvc.danjianName =model.Name;
            addvc.Id=model.RoomId;
            addvc.type =@"1";
            [[self getviewController].navigationController pushViewController:addvc animated:YES];
        }

    } else{
        //详情
        danjianOrderSubModel *submodel =[danjianOrderSubModel new];
        for (danjianOrderSubModel *indexmodel in model.Data_1) {
            if ([indexmodel.Type integerValue] ==1) {
                submodel =indexmodel;
                break;
            }
        }
        NSLog(@"晚餐id%@",submodel.Id);
        
        danjianOrderDetailVC *detailVC = [danjianOrderDetailVC new];
        detailVC.Id =submodel.Id;
        detailVC.type =@"1";
        detailVC.danjianId =model.RoomId;
        detailVC.danjianArray =self.dataArray;

        [[self getviewController].navigationController pushViewController:detailVC animated:YES];

    }
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

- (void)GetDanjianListRequestWithDate:(NSString*)date{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetSinglelReserveList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"FacilitatorId"] =FacilitatorId_New;
    params[@"Time"]=date;
    
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"预订列表%@",object);
            //
            self.dataArray = [danjianOrderModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
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

@end
