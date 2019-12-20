//
//  CXSmallTestResultCell.h
//  CXFrameWork
//
//  Created by canxue on 2019/12/11.
//  Copyright © 2019 canxue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXSmallTestResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *zeroLab;
@property (weak, nonatomic) IBOutlet UILabel *firstLab;
@property (weak, nonatomic) IBOutlet UILabel *secondLab;
@property (weak, nonatomic) IBOutlet UILabel *thirdLab;

- (void)showHeaderData;
- (void)showCellData:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
