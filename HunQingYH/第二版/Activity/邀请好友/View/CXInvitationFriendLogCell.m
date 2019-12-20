//
//  CXInvitationFriendLogCell.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/17.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXInvitationFriendLogCell.h"

@interface CXInvitationFriendLogCell ()

@property (nonatomic, strong) UILabel  *titLab;    // title
@property (nonatomic, strong) UILabel  *subTitLab;    // sub
@property (nonatomic, strong) UILabel  *statuslab;    // 状态

@end
@implementation CXInvitationFriendLogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configerUI];
        [self configerLayout];
    }
    return self;
}

- (void)configerUI {
    
    [self.contentView addSubview:self.titLab];
    [self.contentView addSubview:self.subTitLab];
    [self.contentView addSubview:self.statuslab];
    
    self.titLab.text = @"150****1437";
    self.subTitLab.text = @"邀请成功50元自动进入账户余额";
    self.statuslab.text = @"领取成功";
}

- (void)configerLayout {
    
    [self.titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(Line375(5));
        make.height.mas_equalTo(Line375(30));
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(Line375(15));
    }];
    
    [self.subTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(- Line375(5));
        make.top.mas_equalTo(Line375(30));
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(Line375(15));
    }];
    [self.statuslab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.titLab.mas_bottom);
        make.top.mas_equalTo(self.titLab.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(- Line375(15));
    }];
}

- (UILabel *)titLab {
    
    if (!_titLab) {
        _titLab = [[UILabel alloc] init];
        _titLab.font = Font(15);
    }
    return _titLab;
}

- (UILabel *)subTitLab {
    
    if (!_subTitLab) {
        _subTitLab = [[UILabel alloc] init];
        _subTitLab.font = Font(12);
        _subTitLab.textColor = [CXUtils colorWithHexString:@"#A8A8A8"];
    }
    return _subTitLab;
}

- (UILabel *)statuslab {
    
    if (!_statuslab) {
        _statuslab = [[UILabel alloc] init];
        _statuslab.font = Font(15);
    }
    return _statuslab;
}

@end
