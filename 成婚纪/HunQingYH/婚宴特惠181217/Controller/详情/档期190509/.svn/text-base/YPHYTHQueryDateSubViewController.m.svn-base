//
//  YPHYTHQueryDateSubViewController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/5/9.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHQueryDateSubViewController.h"
#import <FSCalendar.h>

@interface YPHYTHQueryDateSubViewController ()

@property (nonatomic, strong) FSCalendar *calendar;

@end

@implementation YPHYTHQueryDateSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteColor;
    
    [self.view addSubview:self.calendar];
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, ScreenWidth));
        make.left.top.right.mas_equalTo(self.view);
    }];
}

#pragma mark - getter
- (FSCalendar *)calendar{
    if (!_calendar) {
        _calendar = [[FSCalendar alloc]init];
        _calendar.scrollDirection = FSCalendarScrollDirectionVertical;
        _calendar.headerHeight = 40;
        _calendar.weekdayHeight = 20;
        _calendar.calendarWeekdayView.backgroundColor = RGBA(246, 247, 249, 1);
        [_calendar.calendarWeekdayView.weekdayLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.text isEqualToString:@"周日"] || [obj.text isEqualToString:@"周六"]) {
                obj.textColor = RGBA(240, 154, 55, 1);
            }else{
               obj.textColor = RGBS(51);
            }
            if ([obj.text isEqualToString:@"周日"]) {
                obj.text = @"日";
            }else if ([obj.text isEqualToString:@"周一"]){
                obj.text = @"一";
            }else if ([obj.text isEqualToString:@"周二"]){
                obj.text = @"二";
            }else if ([obj.text isEqualToString:@"周三"]){
                obj.text = @"三";
            }else if ([obj.text isEqualToString:@"周四"]){
                obj.text = @"四";
            }else if ([obj.text isEqualToString:@"周五"]){
                obj.text = @"五";
            }else if ([obj.text isEqualToString:@"周六"]){
                obj.text = @"六";
            }
            obj.font = [UIFont systemFontOfSize:12];
        }];
        FSCalendarAppearance *appearance = [[FSCalendarAppearance alloc]init];
        appearance.headerTitleColor = RGBS(51);
        appearance.headerTitleFont = [UIFont fontWithName:@"PingFangSC-Medium" size: 18];
        appearance.titleDefaultColor = RGBS(190);
        appearance.titleSelectionColor = RGBS(51);
        appearance.titleFont = [UIFont fontWithName:@"DINAlternate-Bold" size: 18];
        appearance.borderRadius = 0.2;
        appearance.selectionColor = RGBA(250, 226, 104, 1);
        appearance.todayColor = RGBA(245, 166, 35, 1);
        appearance.headerDateFormat = @"yyyy年MM月";
        appearance.titlePlaceholderColor = WhiteColor;
        [_calendar setValue:appearance forKey:@"appearance"];
    }
    return _calendar;
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
