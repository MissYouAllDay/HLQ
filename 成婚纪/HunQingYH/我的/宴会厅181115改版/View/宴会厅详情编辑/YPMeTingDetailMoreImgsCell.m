//
//  YPMeTingDetailMoreImgsCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/20.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPMeTingDetailMoreImgsCell.h"
#import "HZImagesGroupView.h"
#import "HZPhotoItemModel.h"

#define Margin 10
#define itemMargin 5
#define itemCol 3

@interface YPMeTingDetailMoreImgsCell ()<YPImagesGroupViewDelegate>

@end

@implementation YPMeTingDetailMoreImgsCell{
    HZImagesGroupView *_imagesGroupView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMeTingDetailMoreImgsCell";
    YPMeTingDetailMoreImgsCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMeTingDetailMoreImgsCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setEditBtn:(UIButton *)editBtn{
    _editBtn = editBtn;
    _editBtn.layer.cornerRadius = 14;
    _editBtn.clipsToBounds = YES;
    _editBtn.layer.borderColor = RGBS(170).CGColor;
    _editBtn.layer.borderWidth = 1;
}

- (void)setImgArr:(NSArray *)imgArr{
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
