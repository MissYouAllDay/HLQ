//
//  YPNewWedsSelectTypeListController.h
//  HunQingYH
//
//  Created by Else丶 on 2017/12/12.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YPSelectTypeListDelegate <NSObject>

@optional
- (void)returnSelectType:(NSString *)type;

@end

@interface YPNewWedsSelectTypeListController : UIViewController

@property (nonatomic, assign) id<YPSelectTypeListDelegate> listDelegate;

//@property (nonatomic, copy) NSString *selectTypeStr;
@property (nonatomic, strong) NSArray *typeList;

@end
