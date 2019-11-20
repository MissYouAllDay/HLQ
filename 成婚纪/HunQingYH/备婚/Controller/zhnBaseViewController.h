//
//  zhnBaseViewController.h
//  bantang
//
//  Created by zhn on 16/6/30.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zhnBaseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
/**文章类别ID */
@property(nonatomic,copy)NSString  *leiID;
@property (nonatomic,weak) UITableView * tableView;

@property (nonatomic,assign) UIEdgeInsets zhn_tableViewEdinsets;
@end
