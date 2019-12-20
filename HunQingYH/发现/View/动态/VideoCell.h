//
//  VideoCell.h
//  WMVideoPlayer
//
//  Created by zhengwenming on 16/1/17.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRDongTaiModel.h"

@class VideoCell;

@protocol VideoCellDelegate <NSObject>

- (void)cl_tableViewCellPlayVideoWithCell:(VideoCell *)cell;
@end
@interface VideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *delBtn;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundIV;


@property (weak, nonatomic) IBOutlet UIButton *playBtn;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *desLabHeight;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *shenfenLab;
@property (weak, nonatomic) IBOutlet UIImageView *IconImageView;
//@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
//@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UILabel *likeLab;
//@property (weak, nonatomic) IBOutlet UILabel *pinglunLab;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

//@property (nonatomic, retain)VideoModel *model;

/**动态模型*/
@property(nonatomic,strong)HRDongTaiModel  *dtModel;

@property (nonatomic, assign) NSInteger index;//方便在滚动时取出对应cell的frame
@property (nonatomic, weak) id <VideoCellDelegate> delegate;
@end
