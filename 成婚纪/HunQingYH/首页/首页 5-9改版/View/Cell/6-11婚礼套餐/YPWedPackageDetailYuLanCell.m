//
//  YPWedPackageDetailYuLanCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/11.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPWedPackageDetailYuLanCell.h"
#import "HZImagesGroupView.h"
#import "HZPhotoItemModel.h"

#define Margin 10
#define itemMargin 5
#define itemCol 3

@interface YPWedPackageDetailYuLanCell ()<YPImagesGroupViewDelegate>

@end

@implementation YPWedPackageDetailYuLanCell{
    HZImagesGroupView *_imagesGroupView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPWedPackageDetailYuLanCell";
    YPWedPackageDetailYuLanCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPWedPackageDetailYuLanCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setImgArr:(NSArray *)imgArr{
    //- (void)setImgArr:(NSArray<YPGetBanquetHallInfoImgs *> *)imgArr{
    
    _imgArr = imgArr;
    
    if (!_imagesGroupView) {
        _imagesGroupView = [[HZImagesGroupView alloc] init];
    }
    
    _imagesGroupView.imgsGroupDelegate = self;
    NSMutableArray *temp = [NSMutableArray array];
    [imgArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HZPhotoItemModel *item = [[HZPhotoItemModel alloc] init];
        item.thumbnail_pic = obj;
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

- (BOOL)shouldAutorotate{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
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
