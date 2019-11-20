//
//  HRDTVideoCell.h
//  HunQingYH
//
//  Created by Hiro on 2018/3/15.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRDongTaiModel.h"

@class HRDTVideoCell;

@protocol HRDTVideoCellDelegate <NSObject>

- (void)cl_tableViewCellPlayVideoWithCell:(HRDTVideoCell *)cell;

@end

@interface HRDTVideoCell : UITableViewCell
/**动态模型*/
@property(nonatomic,strong)HRDongTaiModel  *dtModel;
+(instancetype)cellWithTableView:(UITableView *)tableView;


@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *shenfenLab;
@property (weak, nonatomic) IBOutlet UIImageView *IconImageView;
//@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
//@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UILabel *likeLab;
@property (weak, nonatomic) IBOutlet UILabel *pinglunLab;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIImageView *fenmianImageView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic, assign) NSInteger index;//方便在滚动时取出对应cell的frame
@property (nonatomic, weak) id <HRDTVideoCellDelegate> delegate;

@end
