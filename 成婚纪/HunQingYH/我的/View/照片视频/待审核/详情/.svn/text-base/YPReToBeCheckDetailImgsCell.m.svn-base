//
//  YPReToBeCheckDetailImgsCell.m
//  hunqing
//
//  Created by Else丶 on 2018/3/21.
//  Copyright © 2018年 DiKai. All rights reserved.
//

#import "YPReToBeCheckDetailImgsCell.h"

//#define ItemMargin 10
//#define Margin 10
//#define itemMargin 5
//#define itemCol 3

@interface YPReToBeCheckDetailImgsCell ()

@end

@implementation YPReToBeCheckDetailImgsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReToBeCheckDetailImgsCell";
    YPReToBeCheckDetailImgsCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReToBeCheckDetailImgsCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setImgArr:(NSArray<YPGetFileSupplierData *> *)imgArr{
    _imgArr = imgArr;
    
    if (!_imagesGroupView) {
        _imagesGroupView = [[HZImagesGroupView alloc] init];
    }
    
    _imagesGroupView.imgsGroupDelegate = self;
    
    _imagesGroupView.isFullWidth = @"FullWidth";//全屏宽
//    _imagesGroupView.isReject = @"Reject";//照片视频
    _imagesGroupView.isReject = self.isCustomerPortCorper;//用户端 供应商-去掉不合格
    
    NSMutableArray *temp = [NSMutableArray array];
    [imgArr enumerateObjectsUsingBlock:^(YPGetFileSupplierData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HZPhotoItemModel *item = [[HZPhotoItemModel alloc] init];
        item.thumbnail_pic = obj.OriginalFileUrl;//3-21 修改 原文件路径
        item.isRejectStatus = obj.Status;
        item.Reason = obj.Reason;
        [temp addObject:item];
    }];
    
    
    _imagesGroupView.photoItemArray = [temp copy];
    
    [_moreImgsView addSubview:_imagesGroupView];
    
    [_moreImgsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_imagesGroupView.bounds.size.height);
    }];
}

#pragma mark - YPImagesGroupViewDelegate
- (void)frameWithImagesGroupView:(CGRect)frame{
    
    [_moreImgsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(frame.size);
    }];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
