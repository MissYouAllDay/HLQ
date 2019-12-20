//
//  YPMyNewlywedsController.m
//  HunQingYH
//
//  Created by Else丶 on 2017/11/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMyNewlywedsController.h"
//#import "YPNewlywedsAddCell.h"
#import "YPNewWedsNoDescAddCell.h"
#import "YPMyNewlywedsInfoCell.h"
#import "YPMyNewlywedsDescCell.h"
#import "YPMyNewlywedsAddPersonInfoController.h"//个人信息
#import "YPMyNewlywedsMusicController.h"//音乐类型
#import "YPNewWedsOtherInfoController.h"//其他
#import "YPNewWedsOtherSelectController.h"//选择
#import "YPGetNewPeopleQuestionListDataXR.h"//新人模型
#import "YPGetNewPeopleInfo.h"//个人信息

@interface YPMyNewlywedsController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,YPMyNewlywedsAddPersonInfoDelegate,YPNewWedsOtherInfoDelegate,YPNewWedsOtherSelectDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YPGetNewPeopleInfo *personInfo;
@property (nonatomic, strong) NSMutableArray<YPGetNewPeopleQuestionListDataXR *> *xrDataList;

@end

@implementation YPMyNewlywedsController

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupUI];
    
    [self GetNewPeopleInfo];
}

#pragma mark - UI
- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.estimatedRowHeight = 90;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.xrDataList.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        YPMyNewlywedsInfoCell *cell = [YPMyNewlywedsInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.info = self.personInfo;
        
        if (self.upState == 1) {
            cell.editBtn.hidden = YES;
        }else{
            cell.editBtn.hidden = NO;
        }
        
        [cell.editBtn addTarget:self action:@selector(infoEditBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else{
        
        YPGetNewPeopleQuestionListDataXR *data = self.xrDataList[indexPath.section-1];
        
        if (data.OptionAnswer.length > 0 || data.Answer.length > 0) {
            //有答案
            YPMyNewlywedsDescCell *cell = [YPMyNewlywedsDescCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //判断是否有选项
            if (data.OptionAnswer.length > 0) {
                cell.typeLabel.hidden = NO;
                cell.typeLabel.text = data.OptionAnswer;
            }else{
                cell.typeLabel.hidden = YES;
            }
            
            //答案
            if (data.Answer.length > 0) {
                cell.contentLabel.text = data.Answer;
            }else{
                cell.contentLabel.text = @"未填写";
            }
            
            if (self.upState == 1) {
                cell.editBtn.hidden = YES;
            }else{
                cell.editBtn.hidden = NO;
            }
            
            cell.editBtn.tag = indexPath.section + 1000;
            [cell.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
        }else{
            
            //没有答案
            YPNewWedsNoDescAddCell *cell = [YPNewWedsNoDescAddCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = data.QuestionDescribe;
            return cell;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = CHJ_bgColor;
    UILabel *label = [[UILabel alloc]init];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view);
        make.left.mas_equalTo(10);
    }];
    if (section == 0) {
        label.text = @"个人信息";
    }else{
        YPGetNewPeopleQuestionListDataXR *data = self.xrDataList[section-1];
        label.text = data.QuestionClassification;
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.upState == 1) {//已提交 不能修改
        
    }else{
    
        if (indexPath.section == 0) {
            
        }else{
            
            YPGetNewPeopleQuestionListDataXR *data = self.xrDataList[indexPath.section-1];
            
            if (data.OptionAnswer.length > 0 || data.Answer.length > 0) {
                //有答案
                
            }else{
                
                //无答案
                YPGetNewPeopleQuestionListDataXR *data = self.xrDataList[indexPath.section-1];
                
                if ([data.TypeQuestion integerValue] == 0) {//0填写,1选择
                    
                    YPNewWedsOtherInfoController *other = [[YPNewWedsOtherInfoController alloc]init];
                    other.infoDelegate = self;
                    other.titleStr = data.QuestionClassification;
                    other.questionID = data.QuestionID;
                    other.contentStr = data.Answer;
                    [self.navigationController pushViewController:other animated:YES];

                }else{
                    //选择
                    
                    YPNewWedsOtherSelectController *select = [[YPNewWedsOtherSelectController alloc]init];
                    select.selectDelegate = self;
                    select.titleStr = data.QuestionClassification;
                    select.questionID = data.QuestionID;
                    select.selectStr = data.OptionAnswer;
                    select.contentStr = data.Answer;
                    [self.navigationController pushViewController:select animated:YES];
                    
    //                UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:data.QuestionClassification delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    //                sheet.tag = indexPath.section + 1001;
    //                NSArray *arr = [data.TypeContent componentsSeparatedByString:@","];
    //                for (NSString *str in arr) {
    //                    [sheet addButtonWithTitle:str];
    //                }
    //                [sheet showInView:self.view];
                }
            }
        }
    }
}

//#pragma mark - UIActionSheetDelegate
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//
//    YPGetNewPeopleQuestionListDataXR *data = self.xrDataList[actionSheet.tag - 1001 -1];
//    NSArray *arr = [data.TypeContent componentsSeparatedByString:@","];
//    NSLog(@"------ %@",arr[buttonIndex]);
//
//    [self UpNewPeopleQuestionWithQuestionID:data.QuestionID AndContent:arr[buttonIndex] AndAnswer:@""];
//
//}

#pragma mark - YPMyNewlywedsAddPersonInfoDelegate
- (void)yp_addSuccess{
    [self GetNewPeopleInfo];
}

#pragma mark - YPNewWedsOtherInfoDelegate
- (void)yp_infoUpdateSuccess{
    [self GetNewPeopleQuestionList];
}

#pragma mark - YPNewWedsOtherSelectDelegate
- (void)yp_selectUpdateSuccess{
    [self GetNewPeopleQuestionList];
}

#pragma mark - 网络请求
#pragma mark 获取新人订制问题列表
- (void)GetNewPeopleQuestionList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetNewPeopleQuestionList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    params[@"GetType"] = @"1";//0公共问题, 1新人问题
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.xrDataList = [YPGetNewPeopleQuestionListDataXR mj_objectArrayWithKeyValuesArray:[object objectForKey:@"DataXR"]];
            
            [self.tableView reloadData];
            
            if (self.xrDataList.count > 0) {
                
            }else{
                
                [EasyShowTextView showText:@"问题列表当前暂无数据!"];
            }
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 获取自己个人资料
- (void)GetNewPeopleInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetNewPeopleInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.personInfo.Name = [object valueForKey:@"Name"];
            self.personInfo.DateOfBirth = [object valueForKey:@"DateOfBirth"];
            self.personInfo.PlaceOfOrigin = [object valueForKey:@"PlaceOfOrigin"];
            self.personInfo.Constellation = [object valueForKey:@"Constellation"];
            self.personInfo.Occupation = [object valueForKey:@"Occupation"];
            self.personInfo.Phone = [object valueForKey:@"Phone"];
            self.personInfo.QQNumber = [object valueForKey:@"QQNumber"];
            self.personInfo.WechatNumber = [object valueForKey:@"WechatNumber"];
            
            [self GetNewPeopleQuestionList];
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 修改新人问题
- (void)UpNewPeopleQuestionWithQuestionID:(NSString *)quesID AndContent:(NSString *)content AndAnswer:(NSString *)answer{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpNewPeopleQuestion";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"QuestionID"] = quesID;
    params[@"TypeContent"] = content;
    params[@"Answer"] = answer;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
//            [MBProgressHUD wj_showSuccess];
            [EasyShowTextView showSuccessText:@""];
            
            [self GetNewPeopleQuestionList];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark - getter
- (NSMutableArray<YPGetNewPeopleQuestionListDataXR *> *)xrDataList{
    if (!_xrDataList) {
        _xrDataList = [NSMutableArray array];
    }
    return _xrDataList;
}

- (YPGetNewPeopleInfo *)personInfo{
    if (!_personInfo) {
        _personInfo = [[YPGetNewPeopleInfo alloc]init];
    }
    return _personInfo;
}

#pragma mark - target
- (void)infoEditBtnClick{
    NSLog(@"infoEdit");
    
    YPMyNewlywedsAddPersonInfoController *add = [[YPMyNewlywedsAddPersonInfoController alloc]init];
    add.addDelegate = self;
    add.info = self.personInfo;
    [self.navigationController pushViewController:add animated:YES];
}

- (void)editBtnClick:(UIButton *)sender{
    
    YPGetNewPeopleQuestionListDataXR *data = self.xrDataList[sender.tag - 1000 - 1];
    //    NSLog(@"edit --- %@",data.);
    
//    if ([data.QuestionClassification isEqualToString:@"音乐类型"]){
//        //音乐类型
//
//        YPMyNewlywedsMusicController *music = [[YPMyNewlywedsMusicController alloc]init];
//        [self.navigationController pushViewController:music animated:YES];
//
//    }else{
    
        if ([data.TypeQuestion integerValue] == 0) {//0填写,1选择
            
            YPNewWedsOtherInfoController *other = [[YPNewWedsOtherInfoController alloc]init];
            other.infoDelegate = self;
            other.titleStr = data.QuestionClassification;
            other.questionID = data.QuestionID;
            other.contentStr = data.Answer;
            [self.navigationController pushViewController:other animated:YES];
            
        }else{
            //选择
            
            YPNewWedsOtherSelectController *select = [[YPNewWedsOtherSelectController alloc]init];
            select.selectDelegate = self;
            select.titleStr = data.QuestionClassification;
            select.questionID = data.QuestionID;
            select.selectStr = data.OptionAnswer;
            select.contentStr = data.Answer;
            [self.navigationController pushViewController:select animated:YES];
            
//            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:data.QuestionClassification delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
//            sheet.tag = sender.tag - 1000 - 1 + 2001;
//            NSArray *arr = [data.TypeContent componentsSeparatedByString:@","];
//            for (NSString *str in arr) {
//                [sheet addButtonWithTitle:str];
//            }
//            [sheet showInView:self.view];
        }
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
