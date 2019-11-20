//
//  HRCartTableViewCell.h
//  HunQingYH
//
//  Created by Hiro on 2018/4/24.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HRCartModel;
typedef void(^HRNumberChangedBlock)(NSInteger number);
typedef void(^HRCellSelectedBlock)(BOOL select);
@interface HRCartTableViewCell : UITableViewCell
//商品数量
@property (assign,nonatomic)NSInteger lzNumber;
@property (assign,nonatomic)BOOL lzSelected;
//选中按钮
@property (nonatomic,retain) UIButton *selectBtn;
- (void)reloadDataWithModel:(HRCartModel*)model;
- (void)numberAddWithBlock:(HRNumberChangedBlock)block;
- (void)numberCutWithBlock:(HRNumberChangedBlock)block;
- (void)cellSelectedWithBlock:(HRCellSelectedBlock)block;
@end
