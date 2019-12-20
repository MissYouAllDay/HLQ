//
//  CXBaseTableView.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/9.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXBaseTableView.h"

@implementation CXBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(20) + HOME_INDICATOR_HEIGHT)];
        self.tableFooterView = footer;
        self.rowHeight = 0;
        self.estimatedRowHeight = UITableViewAutomaticDimension;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

@end
