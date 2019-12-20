//
//  PageControllerFooterMore.m
//  XQPageControllerDemo
//
//  Created by Ticsmatic on 2017/7/21.
//  Copyright © 2017年 Ticsmatic. All rights reserved.
//

#import "PageControllerFooterMore.h"
#import "HRHotelTingTableViewController.h"
#import "YPReReHomeSupplierDongTaiController.h"
#import "YPHotelHuoDongTableViewController.h"
#import "YPHotelAnLiTableViewController.h"

@interface PageControllerFooterMore ()

@property (nonatomic, strong) HRHotelTingTableViewController *tingVC;
@property (nonatomic, strong) YPReReHomeSupplierDongTaiController *dongtaiVC;
@property (nonatomic, strong) YPHotelHuoDongTableViewController *huodongVC;
@property (nonatomic, strong) YPHotelAnLiTableViewController *anliVC;

@end

@implementation PageControllerFooterMore

- (void)viewDidLoad {
    self.slideBarCustom = YES;
    // 等宽
    self.slideBar.isUnifyWidth = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - ScrollPageViewControllerProtocol

- (NSArray *)arrayForControllerTitles {
//    if (JiuDian(self.profession)) {
     if (JiuDian(Profession_New)) {
        return @[@"宴会厅",@"动态",@"案例"];
    }else{
        return @[@"动态",@"案例"];
    }
}

- (UIViewController *)viewcontrollerWithIndex:(NSInteger)index {
    if (index <0 || index > self.arrayForControllerTitles.count) return nil;
    if (JiuDian(Profession_New)) {
        if (index == 0) {
            return self.tingVC;
        }else if (index == 1) {
            return self.dongtaiVC;
        }else if (index == 2) {
            return self.anliVC;
        }else if (index == 3) {
            return self.huodongVC;
        }
    }else{
        if (index == 0) {
            return self.dongtaiVC;
        } else if (index == 1) {
            return self.anliVC;
        } else if (index == 2) {
            return self.huodongVC;
        }
    }
    
    return nil;
}

#pragma mark - Getter
- (HRHotelTingTableViewController *)tingVC{
    if (!_tingVC) {
        _tingVC = [[HRHotelTingTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    }
    _tingVC.SupplierID = self.FacilitatorID;
    _tingVC.zhiyeName = self.profession;
    return _tingVC;
}

- (YPReReHomeSupplierDongTaiController *)dongtaiVC{
    if (!_dongtaiVC) {
        _dongtaiVC = [[YPReReHomeSupplierDongTaiController alloc]init];
    }
    _dongtaiVC.userID = self.UserID;
    return _dongtaiVC;
}

- (YPHotelHuoDongTableViewController *)huodongVC{
    if (!_huodongVC) {
        _huodongVC = [[YPHotelHuoDongTableViewController alloc]initWithStyle:UITableViewStylePlain];
    }
    _huodongVC.FacilitatorId = self.FacilitatorID;
    return _huodongVC;
}

- (YPHotelAnLiTableViewController *)anliVC{
    if (!_anliVC) {
        _anliVC = [[YPHotelAnLiTableViewController alloc]initWithStyle:UITableViewStylePlain];
    }
    _anliVC.SupplierID = self.FacilitatorID;
    return _anliVC;
}

@end
