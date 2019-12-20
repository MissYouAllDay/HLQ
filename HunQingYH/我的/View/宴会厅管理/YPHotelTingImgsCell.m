//
//  YPHotelTingImgsCell.m
//  hunqing
//
//  Created by YanpengLee on 2017/6/2.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPHotelTingImgsCell.h"
#import "HZImagesGroupView.h"
#import "HZPhotoItemModel.h"

//#define ItemMargin 10
#define Margin 10
#define itemMargin 5
#define itemCol 3

@interface YPHotelTingImgsCell ()<YPImagesGroupViewDelegate>

@end

@implementation YPHotelTingImgsCell{
    HZImagesGroupView *_imagesGroupView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHotelTingImgsCell";
    YPHotelTingImgsCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHotelTingImgsCell" owner:nil options:nil] lastObject];
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

@end
