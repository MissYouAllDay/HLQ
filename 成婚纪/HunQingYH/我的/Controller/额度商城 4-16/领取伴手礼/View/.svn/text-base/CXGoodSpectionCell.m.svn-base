//
//  CXGoodSpectionCell.m
//  HunQingYH
//
//  Created by apple on 2019/9/29.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXGoodSpectionCell.h"

@interface CXGoodSpectionCell ()
@property (nonatomic, strong) UIImageView *goodIcon;    // 图片
@property (nonatomic, strong) UILabel *nameLab; // 名称
@property (nonatomic, strong) UILabel *spesLab; // 所选择的规格
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSMutableArray *selectIndexArr;

@end
@implementation CXGoodSpectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    
    [self.contentView addSubview:self.goodIcon];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.spesLab];
    [self.contentView addSubview:self.bgView];
    
    [self.goodIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Line375(10));
        make.left.mas_equalTo(Line375(10));
        make.size.mas_equalTo(CGSizeMake(Line375(75), Line375(75)));
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodIcon.mas_top);
        make.left.mas_equalTo(self.goodIcon.mas_right).mas_offset(Line375(10));
        make.right.mas_equalTo(self.right).mas_offset(-10);
    }];
    [self.spesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.goodIcon.mas_bottom);
        make.left.mas_equalTo(self.nameLab.mas_left);
        make.right.mas_equalTo(self.nameLab.mas_right);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodIcon.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_offset(0);
    }];
}

- (void)setModel:(YPGetCommodityTypeTableListData *)model {
    
    _model = model;
    
    [self.goodIcon sd_setImageWithURL:[NSURL URLWithString:self.model.ShowImage] placeholderImage:[UIImage imageNamed:@"smallPlaceIcon"]];
    self.nameLab.text = self.model.Name;
    self.spesLab.text = self.model.selectSpe;
    
    CGFloat bottom = 0;
    for (int i = 0; i < model.Data.count; i ++) {
        
        CXSpecificationsModel *speModel = model.Data[i];
        UIView *view = [self loadSpections:[speModel.Specifications componentsSeparatedByString:@"，"] withName:speModel.SpecificationName withTag:(i + 1) * 1000 withTop:bottom withSelectData:model.selectSpe];
        bottom += view.height + Line375(10);
        [self.bgView addSubview:view];
    }
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(bottom);
    }];
}

/**
 创建规格视图

 @param specArr 规格数组
 @param name 规格名称
 @param tag section的j初始tag
 @param top originY
 @param selectSpe 以前选中的规格
 @return view
 */
- (UIView *)loadSpections:(NSArray *)specArr withName:(NSString *)name withTag:(NSInteger)tag withTop:(CGFloat)top withSelectData:(NSString *)selectSpe {
    
    NSArray *selectSpeArr = [selectSpe componentsSeparatedByString:@"、"];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(Line375(20), top, ScreenWidth - Line375(30), 0)];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgView.width, Line375(25))];
    nameLab.text = name;
    nameLab.textColor = [UIColor colorWithHexString:@"#2D2D2D"];
    nameLab.font = kFont(13);
    [bgView addSubview:nameLab];
    
    CGFloat oriY = nameLab.bottom;
    CGFloat oriX = 0;
    CGFloat width = (bgView.width - Line375(40))/5;
    CGFloat height = Line375(20);
    for (int i = 0; i < specArr.count; i ++) {
        UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
        sender.frame = CGRectMake(oriX, oriY, width, height);
        [sender setTitle:specArr[i] forState:UIControlStateNormal];
        sender.layer.cornerRadius = sender.height/2;
        sender.clipsToBounds = YES;
        sender.tag = tag + i;
        sender.titleLabel.font = kFont(11);
        [sender addTarget:self action:@selector(specAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:sender];
        
        sender.layer.borderWidth = 1;
        [sender setTitleColor:[UIColor colorWithHexString:@"#8C8989"] forState:UIControlStateNormal];
        sender.layer.borderColor = [UIColor colorWithHexString:@"#8C8989"].CGColor;
        sender.backgroundColor = [UIColor whiteColor];
//        oriX = i%5 == 0 && i != 0 ? 0 : oriX + width;
//        oriY = i/5 == 0 && i != 0 ? 0 : oriY + height;
        
        if ([selectSpeArr containsObject:specArr[i]]) {
            
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            sender.layer.borderColor = [UIColor colorWithHexString:@"#F65F62"].CGColor;
            sender.backgroundColor = [UIColor colorWithHexString:@"#F65F62"];
            self.selectIndexArr[tag/1000 - 1] = sender;
        }
        oriX += width + Line375(10);
    }
    bgView.height = oriY + height;
    
    return bgView;
}

- (void)specAction:(UIButton *)sender {
    
    NSInteger index = sender.tag/1000 - 1;
    NSMutableArray *selectSpeArr = [[NSMutableArray alloc] initWithArray:[self.model.selectSpe componentsSeparatedByString:@"、"]];
    selectSpeArr[index] = sender.titleLabel.text;
    self.model.selectSpe = [selectSpeArr componentsJoinedByString:@"、"];
    self.spesLab.text = self.model.selectSpe;
    
    UIButton *button = self.selectIndexArr[index];
    [button setTitleColor:[UIColor colorWithHexString:@"#8C8989"] forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor colorWithHexString:@"#8C8989"].CGColor;
    button.backgroundColor = [UIColor whiteColor];
    
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.layer.borderColor = [UIColor colorWithHexString:@"#F65F62"].CGColor;
    sender.backgroundColor = [UIColor colorWithHexString:@"#F65F62"];
    self.selectIndexArr[index] = sender;
}

- (UIImageView *)goodIcon {
    
    if (!_goodIcon) {
//        _goodIcon = [[UIImageView alloc] initWithFrame:CGRectMake(Line375(10), Line375(10), Line375(75), Line375(75))];
        _goodIcon = [[UIImageView alloc] init];
        _goodIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodIcon;
}

- (UIView *)bgView {
    
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
    }
    return _bgView;
}

- (UILabel *)nameLab {
    
    if (!_nameLab) {
//        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(self.goodIcon.right + 10,self.goodIcon.top, ScreenWidth - self.goodIcon.right - 20, self.goodIcon.height/2)];
        _nameLab = [[UILabel alloc] init];
        _nameLab.numberOfLines = 0;
        _nameLab.font = kFont(15);
        _nameLab.textColor = [UIColor colorWithHexString:@"#353535"];
    }
    return _nameLab;
}

- (UILabel *)spesLab {
    
    if (!_spesLab) {
//        _spesLab = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLab.left,self.nameLab.bottom , self.nameLab.width, self.nameLab.height)];
        _spesLab = [[UILabel alloc] init];
        _spesLab.numberOfLines = 0;
        _spesLab.font = kFont(13);
        _spesLab.textColor = [UIColor colorWithHexString:@"#8B8989"];
    }
    return _spesLab;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSMutableArray *)selectIndexArr {
    
    if (!_selectIndexArr) {
        _selectIndexArr = [[NSMutableArray alloc] init];
    }
    return _selectIndexArr;
}
@end
