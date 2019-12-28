//
//  CXReviceTaoCanCell.m
//  HunQingYH
//
//  Created by apple on 2019/9/28.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXReviceTaoCanCell.h"

@interface CXReviceTaoCanCell  ()

@property (nonatomic, strong) UILabel *titleLab;    // 套餐名称
@property (nonatomic, strong) UIView *mainBgView;// 主视图
@property (nonatomic, strong) UIImageView *icon; //  图片

@end

@implementation CXReviceTaoCanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubViews];
    }
    return self;
}

- (void)setModel:(YPGetCommodityTypeTableList *)model {
    
    _model = model;
    
    NSString *url ;
    if (_model.Data.count != 0) {
        url =  _model.Data[0].ShowImage;
    }
    [self.icon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"smallPlaceIcon"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (!image) {
            self.icon.contentMode = UIViewContentModeCenter;
        }
    }];
    self.titleLab.text = _model.TypeName;
}

- (void)setGoodModel:(YPGetCommodityTypeTableListData *)goodModel {
    
    _goodModel = goodModel;

    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.goodModel.ShowImage] placeholderImage:[UIImage imageNamed:@"smallPlaceIcon"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {    }];
    
    NSString *title = _goodModel.Title;
    NSString *name = _goodModel.Name;
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",title,name] attributes:@{NSFontAttributeName:kFont(13),NSForegroundColorAttributeName:[UIColor grayColor]}];
   
    [att addAttributes:@{NSFontAttributeName:kFont(13),NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, title.length)];
    self.titleLab.attributedText = att;
}

- (void)loadSubViews {
    
    [self.contentView removeAllSubviews];
    [self.contentView addSubview:self.mainBgView];
    [self.mainBgView addSubview:self.icon];
    [self.mainBgView addSubview:self.titleLab];
}

- (UIView *)mainBgView {
    
    if (!_mainBgView) {
        _mainBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.01)];
    }
    return _mainBgView;
}

- (UILabel *)titleLab {
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(self.icon.right + Line375(15), 0, ScreenWidth - Line375(60) -  Line375(45) ,self.icon.height)];
        _titleLab.font = kFont(15);
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

- (UIImageView *)icon {
    
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake( Line375(15),  Line375(15), Line375(90), Line375(90))];
    }
    return _icon;
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
