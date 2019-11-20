//
//  HRCartTableViewCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/4/24.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRCartTableViewCell.h"
#import "LZConfigFile.h"
#import "HRCartModel.h"

@interface HRCartTableViewCell ()
{
    HRNumberChangedBlock numberAddBlock;
    HRNumberChangedBlock numberCutBlock;
    HRCellSelectedBlock cellSelectedBlock;
}

//显示照片
@property (nonatomic,retain) UIImageView *lzImageView;
//商品名
@property (nonatomic,retain) UILabel *nameLabel;
//尺寸
@property (nonatomic,retain) UILabel *sizeLabel;
//时间
@property (nonatomic,retain) UILabel *dateLabel;
//价格
@property (nonatomic,retain) UILabel *priceLabel;
//数量
@property (nonatomic,retain)UILabel *numberLabel;

@end

@implementation HRCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = LZColorFromRGB(245, 246, 248);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupMainView];
    }
    return self;
}
#pragma mark - public method
- (void)reloadDataWithModel:(HRCartModel*)model {
    
    [self.lzImageView sd_setImageWithURL:[NSURL URLWithString:model.BriefIntroduction]];
    self.nameLabel.text = model.CommodityName;
    self.priceLabel.text = model.Quota;
    self.dateLabel.text = model.dateStr;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)model.Count];
    self.sizeLabel.text = [NSString stringWithFormat:@"尺码:%@",model.PlaceOriginName];
    self.selectBtn.selected = model.select;
}

- (void)numberAddWithBlock:(HRNumberChangedBlock)block {
    numberAddBlock = block;
}

- (void)numberCutWithBlock:(HRNumberChangedBlock)block {
    numberCutBlock = block;
}

- (void)cellSelectedWithBlock:(HRCellSelectedBlock)block {
    cellSelectedBlock = block;
}
#pragma mark - 重写setter方法
- (void)setLzNumber:(NSInteger)lzNumber {
    _lzNumber = lzNumber;
    
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)lzNumber];
}

- (void)setLzSelected:(BOOL)lzSelected {
    _lzSelected = lzSelected;
    self.selectBtn.selected = lzSelected;
}
#pragma mark - 按钮点击方法
- (void)selectBtnClick:(UIButton*)button {
    button.selected = !button.selected;
    
    if (cellSelectedBlock) {
        cellSelectedBlock(button.selected);
    }
}

- (void)addBtnClick:(UIButton*)button {
    
    NSInteger count = [self.numberLabel.text integerValue];
    count++;
    
    if (numberAddBlock) {
        numberAddBlock(count);
    }
}

- (void)cutBtnClick:(UIButton*)button {
    NSInteger count = [self.numberLabel.text integerValue];
    count--;
    if(count <= 0){
        return ;
    }
    
    if (numberCutBlock) {
        numberCutBlock(count);
    }
}
#pragma mark - 布局主视图
-(void)setupMainView {
    //白色背景
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(10, 10, LZSCREEN_WIDTH - 20, lz_CartRowHeight - 10);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = LZColorFromHex(0xEEEEEE).CGColor;
    bgView.layer.borderWidth = 1;
    bgView.clipsToBounds =YES;
    bgView.layer.cornerRadius =10;
    [self addSubview:bgView];
    
    //选中按钮
    UIButton* selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.center = CGPointMake(20, bgView.height/2.0);
    selectBtn.bounds = CGRectMake(0, 0, 30, 30);
    [selectBtn setImage:[UIImage imageNamed:lz_Bottom_UnSelectButtonString] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:lz_Bottom_SelectButtonString] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:selectBtn];
    self.selectBtn = selectBtn;
    
    //照片背景
    UIView *imageBgView = [[UIView alloc]init];
    imageBgView.frame = CGRectMake(selectBtn.right + 5, 10, bgView.height - 20, bgView.height - 20);
    imageBgView.backgroundColor = LZColorFromHex(0xF3F3F3);
    [bgView addSubview:imageBgView];
    
    //显示照片
    UIImageView* imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"default_pic_1"];
    imageView.frame = imageBgView.frame;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:imageView];
    self.lzImageView = imageView;
    
    CGFloat width = (bgView.width - imageBgView.right - 30)/2.0;
   
    
    //商品名
    UILabel* nameLabel = [[UILabel alloc]init];
    nameLabel.frame = CGRectMake(imageBgView.right + 10, 10, width, 20);
    nameLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //尺寸
    UILabel* sizeLabel = [[UILabel alloc]init];
    sizeLabel.frame = CGRectMake(nameLabel.left, nameLabel.bottom+5, width, 20);
    sizeLabel.textColor = LZColorFromRGB(132, 132, 132);
    sizeLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:sizeLabel];
    self.sizeLabel = sizeLabel;
    
    //时间
//    UILabel* dateLabel = [[UILabel alloc]init];
//    dateLabel.frame = CGRectMake(nameLabel.left, sizeLabel.bottom , width, 20);
//    dateLabel.font = [UIFont systemFontOfSize:10];
//    dateLabel.textColor = LZColorFromRGB(132, 132, 132);
//    [bgView addSubview:dateLabel];
//    self.dateLabel = dateLabel;
    
    //价格
    UILabel* priceLabel = [[UILabel alloc]init];
    priceLabel.frame = CGRectMake(nameLabel.left, imageBgView.bottom-30, width, 30);
    priceLabel.font = [UIFont boldSystemFontOfSize:16];
    priceLabel.textColor = BASECOLOR_RED;
    priceLabel.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    //数量加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(bgView.width - 35, bgView.height - 35, 25, 25);
    [addBtn setImage:[UIImage imageNamed:@"addshangpin"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"addshangpin"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:addBtn];
    
    //数量显示
    UILabel* numberLabel = [[UILabel alloc]init];
    numberLabel.frame = CGRectMake(addBtn.left - 30, addBtn.top, 30, 25);
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.text = @"1";
    numberLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:numberLabel];
    self.numberLabel = numberLabel;
    
    //数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cutBtn.frame = CGRectMake(numberLabel.left - 25, addBtn.top, 25, 25);
    [cutBtn setImage:[UIImage imageNamed:@"jianshangpin"] forState:UIControlStateNormal];
    [cutBtn setImage:[UIImage imageNamed:@"jianshangpin"] forState:UIControlStateHighlighted];
    [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cutBtn];
}

@end
