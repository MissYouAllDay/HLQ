//
//  LTSCalendarScrollView.h
//  LTSCalendar
//
//  Created by 李棠松 on 2018/1/13.
//  Copyright © 2018年 leetangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSCalendarContentView.h"
#import "LTSCalendarWeekDayView.h"
@protocol calendarTableviewDelegate <NSObject>
-(NSInteger)calendarnumberOfSectionsInTableView:(UITableView *)tableView;
-(NSInteger)calendartableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell*)calendartableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)calendartableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(CGFloat)calendartableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface LTSCalendarScrollView : UIScrollView
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)LTSCalendarContentView *calendarView;

@property (nonatomic,strong)UIColor *bgColor;
- (void)scrollToSingleWeek;

- (void)scrollToAllWeek;
@property(nonatomic,weak)id<calendarTableviewDelegate>calendarTablewDelegate;
@end
