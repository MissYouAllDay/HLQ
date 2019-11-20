//
//  LuckView.h
//  QSyihz
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 yihuazhuan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^luckBlock)(NSInteger result);
typedef void (^luckBtnBlock)(UIButton *btn);

@protocol LuckViewDelegate <NSObject>
- (void)luckViewDidStopWithArrayCount:(NSInteger)count;
- (void)luckSelectBtn:(UIButton *)btn;

@end

@interface LuckView : UIView



/**
 *  图片地址，网络获取
 */
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) NSMutableArray *titleArray;
@property (assign, nonatomic) int stopCount;
@property (assign, nonatomic) id<LuckViewDelegate> delegate;
@property (copy, nonatomic) luckBlock luckResultBlock;
@property (copy, nonatomic) luckBtnBlock luckBtn;

@property (nonatomic, strong) UIButton *lotteryBtn;

/**抽奖次数*/
@property (nonatomic, copy) NSString *LotteryQualification;

//************************* 中奖model ***************************
/**奖品Id*/
@property (nonatomic, copy) NSString *PrizeId;
/**奖品名称*/
@property (nonatomic, copy) NSString *PrizeName;
/**奖品图片地址*/
@property (nonatomic, copy) NSString *Imgurl;
/**停止位置下标
 GetAllPrizesList接口奖品下标 用于抽奖停止*/
@property (nonatomic, copy) NSString *PrizeSubscript;
//************************* model ***************************

- (void)yp_lotteryBtnClick;

- (void)getLuckResult:(luckBlock)luckResult;
- (void)getLuckBtnSelect:(luckBtnBlock)btnBlock;

@end
