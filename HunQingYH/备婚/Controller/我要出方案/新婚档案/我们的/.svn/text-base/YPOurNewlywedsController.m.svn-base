//
//  YPOurNewlywedsController.m
//  HunQingYH
//
//  Created by Else丶 on 2017/11/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPOurNewlywedsController.h"
//#import "YPNewlywedsAddCell.h"
#import "YPOurNewlywedsDescCell.h"
#import "YPOurNewWedsChangBuYuSuanController.h"//场布预算
#import "YPOurNewWedsHotelInfoController.h"//酒店信息
#import "YPNewWedsOtherInfoController.h"//输入
#import "YPOurNewWedsScreenController.h"//LED屏
#import "YPOurNewWedsWeddingDateController.h"//婚期
#import "YPGetNewPeopleQuestionListDataGG.h"//公共模型
#import "YPMyNewlywedsDescCell.h"
#import "YPNewWedsNoDescAddCell.h"
#import "YPOurNewWedsHotelInfoCell.h"

@interface YPOurNewlywedsController ()<UITableViewDelegate,UITableViewDataSource,YPNewWedsOtherInfoDelegate,YPOurNewWedsWeddingDateDelegate,YPOurNewWedsBudgetDelegate,YPOurNewWedsScreenDelegate,YPOurNewWedsHotelDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetNewPeopleQuestionListDataGG *> *ggDataList;
@property (nonatomic, strong) YPGetNewPeopleQuestionListDataGG *ggData;

@end

@implementation YPOurNewlywedsController

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
    
    [self GetNewPeopleQuestionList];
}

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
    return 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        if ([self.ggData.Budget integerValue] > 0) {
            //有数据
            YPMyNewlywedsDescCell *cell = [YPMyNewlywedsDescCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.typeLabel.hidden = YES;
            //答案
            if ([self.ggData.Budget integerValue] > 0) {
                cell.contentLabel.text = self.ggData.Budget;
            }else{
                cell.contentLabel.text = @"未填写";
            }
            
            if (self.upState == 1) {
                cell.editBtn.hidden = YES;
            }else{
                cell.editBtn.hidden = NO;
            }
            
            cell.editBtn.tag = indexPath.section + 1000;
            [cell.editBtn addTarget:self action:@selector(yusuanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            
            //暂无数据
            YPNewWedsNoDescAddCell *cell = [YPNewWedsNoDescAddCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"添加您的场布预算";
            return cell;
        }
        
    }else if (indexPath.section == 1){
        
        if (self.ggData.HotelName.length > 0) {
            //有数据
            YPOurNewWedsHotelInfoCell *cell = [YPOurNewWedsHotelInfoCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //酒店信息
            if (self.ggData.HotelName.length > 0) {
                cell.hotelName.text = self.ggData.HotelName;
            }else{
                cell.hotelName.text = @"无";
            }
            if (self.ggData.HotelAddress.length > 0) {
                cell.hotelAddress.text = self.ggData.HotelAddress;
            }else{
                cell.hotelAddress.text = @"无";
            }
            if (self.ggData.HallName.length > 0) {
                cell.tingName.text = self.ggData.HallName;
            }else{
                cell.tingName.text = @"无";
            }
            if (self.ggData.TableCount.length > 0) {
                cell.hotelTableCount.text = [NSString stringWithFormat:@"%@ 桌",self.ggData.TableCount];
            }else{
                cell.hotelTableCount.text = @"无";
            }
            if (self.ggData.RummeryXls.length > 0) {
                NSArray *arr = [self.ggData.RummeryXls componentsSeparatedByString:@","];
                cell.tingSize.text = [NSString stringWithFormat:@"%@米,%@米,%@米",arr[0],arr[1],arr[2]];
            }else{
                cell.tingSize.text = @"无";
            }
            
            NSArray *arr = [self.ggData.RummeryImg componentsSeparatedByString:@","];
            cell.imgArr = arr;
            
            if (self.upState == 1) {
                cell.editBtn.hidden = YES;
            }else{
                cell.editBtn.hidden = NO;
            }
            
            [cell.editBtn addTarget:self action:@selector(jiudianBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            
            //暂无数据
            YPNewWedsNoDescAddCell *cell = [YPNewWedsNoDescAddCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"描述您选择的酒店相关信息";
            return cell;
        }
        
    }else if (indexPath.section == 2){
        
        if ([self.ggData.IsLEDScreen integerValue] == 2) {
            
            //暂无数据
            YPNewWedsNoDescAddCell *cell = [YPNewWedsNoDescAddCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"是否需要LED大屏幕";
            return cell;
            
        }else{
            
            YPMyNewlywedsDescCell *cell = [YPMyNewlywedsDescCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.typeLabel.hidden = YES;
            
            if (self.upState == 1) {
                cell.editBtn.hidden = YES;
            }else{
                cell.editBtn.hidden = NO;
            }
            
            cell.editBtn.tag = indexPath.section + 1000;
            [cell.editBtn addTarget:self action:@selector(ledPingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if ([self.ggData.IsLEDScreen integerValue] == 1) {//0不需要,1需要，2未填写
                
                cell.contentLabel.text = @"需要";
                
            }else if ([self.ggData.IsLEDScreen integerValue] == 0) {
                
                cell.contentLabel.text = @"不需要";
                
            }
            return cell;
        }
        
    }else if (indexPath.section == 3){
        
        if (self.ggData.SpecialVersion.length > 0) {
            //有数据
            YPMyNewlywedsDescCell *cell = [YPMyNewlywedsDescCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.typeLabel.hidden = YES;
            //答案
            if (self.ggData.SpecialVersion.length > 0) {
                cell.contentLabel.text = self.ggData.SpecialVersion;
            }else{
                cell.contentLabel.text = @"未填写";
            }
            
            if (self.upState == 1) {
                cell.editBtn.hidden = YES;
            }else{
                cell.editBtn.hidden = NO;
            }
            
            cell.editBtn.tag = indexPath.section + 1000;
            [cell.editBtn addTarget:self action:@selector(tebieDescBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            
            //暂无数据
            YPNewWedsNoDescAddCell *cell = [YPNewWedsNoDescAddCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"请填写需要注意的婚礼细节";
            return cell;
        }
        
    }else if (indexPath.section == 4){
        //婚期
        if (self.ggData.WeddingDay.length > 0) {
            //有数据
            YPMyNewlywedsDescCell *cell = [YPMyNewlywedsDescCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.typeLabel.hidden = YES;
            //答案
            if (self.ggData.WeddingDay.length > 0) {
                cell.contentLabel.text = self.ggData.WeddingDay;
            }else{
                cell.contentLabel.text = @"未填写";
            }
            
            if (self.upState == 1) {
                cell.editBtn.hidden = YES;
            }else{
                cell.editBtn.hidden = NO;
            }
            
            cell.editBtn.tag = indexPath.section + 1000;
            [cell.editBtn addTarget:self action:@selector(hunqiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            
            //暂无数据
            YPNewWedsNoDescAddCell *cell = [YPNewWedsNoDescAddCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"请选择婚期";
            return cell;
        }
        
    }else if (indexPath.section == 5){
        //邀请码
        if (self.ggData.InvitationCode.length > 0) {
            //有数据
            YPMyNewlywedsDescCell *cell = [YPMyNewlywedsDescCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.typeLabel.hidden = YES;
            //答案
            if (self.ggData.InvitationCode.length > 0) {
                cell.contentLabel.text = self.ggData.InvitationCode;
            }else{
                cell.contentLabel.text = @"未填写";
            }
            
            if (self.upState == 1) {
                cell.editBtn.hidden = YES;
            }else{
                cell.editBtn.hidden = NO;
            }
            
            cell.editBtn.tag = indexPath.section + 1000;
            [cell.editBtn addTarget:self action:@selector(yaoqingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            
            //暂无数据
            YPNewWedsNoDescAddCell *cell = [YPNewWedsNoDescAddCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"请填写邀请码";
            return cell;
        }
        
    }else if (indexPath.section == 6 || indexPath.section == 7 || indexPath.section == 8){
        
        YPOurNewlywedsDescCell *cell = [YPOurNewlywedsDescCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 6) {
            
            cell.contentLabel.attributedText = [self getAttributedStringWithString:@"①易拉宝  数量 1-2张  竖版照片\n②水牌  数量 4-5张  横版竖版都要\n③展示区  数量 8-10张  横版竖版都要\n④电子相册  数量 40-50张\n请将以上所需照片按照分类打包上传至邮箱:\n15192055999@163.com" lineSpace:10.0];

        }else if (indexPath.section == 7){
            //按照预算金额的1%收取方案策划费, 如果您的婚礼有我们合作的婚庆公司来执行的话, 不收取任何费用。
            cell.contentLabel.attributedText = [self getAttributedStringWithString:@"    婚礼桥将会为您提供免费的策划方案，我们不会收取任何费用。若您的婚礼由我们合作的婚庆公司来执行,将会获得更优质的婚礼体验。\n注：\n    我们将会根据您以上所提供的材料设计两套PPT策划方案，选中其中一套后再次修改三次为准，上传的材料尽量全面细致，这样便于我们更好的为您做出理想满意的策划案。我们会将所有的设计图，包括效果图、源文件等等都交给您，便于您后期的设计修改。" lineSpace:10.0];
            
        }else if (indexPath.section == 8){
            
            cell.contentLabel.attributedText = [self getAttributedStringWithString:@"Q  Q:  3262007129\n微信:  15192055999\n电话:  15192055999\n邮箱:  15192055999@163.com" lineSpace:10.0];
            
        }
        
        return cell;
        
    }
    return nil;
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
    switch (section) {
        case 0:
            label.text = @"场布预算";
            break;
        case 1:
            label.text = @"酒店宴会厅信息";
            break;
        case 2:
            label.text = @"是否需要LED大屏幕?";
            break;
        case 3:
            label.text = @"特别说明";
            break;
        case 4:
            label.text = @"婚期";
            break;
        case 5:
            label.text = @"邀请码";
            break;
        case 6:
            label.text = @"婚纱照片";
            break;
        case 7:
            label.text = @"收费标准";
            break;
        case 8:
            label.text = @"联系我们";
            break;
        default:
            break;
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = [self getviewController];
    
    if (indexPath.section == 0) {//预算
        
        if ([self.ggData.Budget integerValue] > 0) {
            //有预算
        }else{
            
            YPOurNewWedsChangBuYuSuanController *changbu = [[YPOurNewWedsChangBuYuSuanController alloc]init];
            changbu.budgetDelegate = self;
            changbu.peopleCustomID = self.ggData.NewPeopleCustomID;
            [vc.navigationController pushViewController:changbu animated:YES];
        }
        
    }else if (indexPath.section == 1){//酒店
        
        if (self.ggData.HotelName.length > 0) {
            
        }else{
            
            YPOurNewWedsHotelInfoController *hotel = [[YPOurNewWedsHotelInfoController alloc]init];
            hotel.hotelDelegate = self;
            hotel.peopleCustomID = self.ggData.NewPeopleCustomID;
            [vc.navigationController pushViewController:hotel animated:YES];
        }
        
    }else if (indexPath.section == 2){//全屏
        
        if ([self.ggData.IsLEDScreen integerValue] == 2) {//0不需要,1需要，2未填写
            YPOurNewWedsScreenController *screen  = [[YPOurNewWedsScreenController alloc]init];
            screen.screenDelegate = self;
            screen.peopleCustomID = self.ggData.NewPeopleCustomID;
            [vc.navigationController pushViewController:screen animated:YES];
        }
        
    }else if (indexPath.section == 3){//特别说明
        
        if (self.ggData.SpecialVersion.length > 0) {
            
        }else{
            
            YPNewWedsOtherInfoController *other = [[YPNewWedsOtherInfoController alloc]init];
            other.infoDelegate = self;
            other.type = @"6";//1酒店,2婚期,3led ,4邀请码,5预算,6特别说明
            other.titleStr = @"特别说明";
            other.questionID = self.ggData.NewPeopleCustomID;
            [vc.navigationController pushViewController:other animated:YES];
        }
        
    }else if (indexPath.section == 4){//婚期
        
        if (self.ggData.WeddingDay.length > 0) {
            
        }else{
            
            YPOurNewWedsWeddingDateController *date = [[YPOurNewWedsWeddingDateController alloc]init];
            date.dateDelegate = self;
            date.peopleCustomID = self.ggData.NewPeopleCustomID;
            [vc.navigationController pushViewController:date animated:YES];
            
        }
        
    }else if (indexPath.section == 5){//邀请码
        
        if (self.ggData.InvitationCode.length > 0) {
            
        }else{
            
            YPNewWedsOtherInfoController *other = [[YPNewWedsOtherInfoController alloc]init];
            other.infoDelegate = self;
            other.type = @"4";//1酒店,2婚期,3led ,4邀请码,5预算,6特别说明
            other.titleStr = @"邀请码";
            other.questionID = self.ggData.NewPeopleCustomID;
            [vc.navigationController pushViewController:other animated:YES];
        }
    }
}

#pragma mark - YPOurNewWedsBudgetDelegate
- (void)yp_Budget{
    
    [self GetNewPeopleQuestionList];
}

#pragma mark - YPOurNewWedsHotelDelegate
- (void)yp_Hotel{
    
    [self GetNewPeopleQuestionList];
}

#pragma mark - YPOurNewWedsScreenDelegate
- (void)yp_screen{
    
    [self GetNewPeopleQuestionList];
}

#pragma mark - YPNewWedsOtherInfoDelegate
- (void)yp_infoUpdateSuccess{
    
    [self GetNewPeopleQuestionList];
}

#pragma mark - YPOurNewWedsWeddingDateDelegate
- (void)yp_WeddingDate{
    
    [self GetNewPeopleQuestionList];
}

#pragma mark - 网络请求
#pragma mark 获取新人订制问题列表
- (void)GetNewPeopleQuestionList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetNewPeopleQuestionList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    params[@"GetType"] = @"0";//0公共问题, 1新人问题
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.ggDataList = [YPGetNewPeopleQuestionListDataGG mj_objectArrayWithKeyValuesArray:[object objectForKey:@"DataGG"]];
            
            if (self.ggDataList.count > 0) {
                self.ggData = self.ggDataList[0];
            }
            
            [self.tableView reloadData];
            
            if (self.ggDataList.count > 0) {
                
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

#pragma mark - target
- (void)yusuanBtnClick:(UIButton *)sender{
    
    if (sender.tag == 1000) {
        UIViewController *vc = [self getviewController];
        
        YPOurNewWedsChangBuYuSuanController *changbu = [[YPOurNewWedsChangBuYuSuanController alloc]init];
        changbu.budgetDelegate = self;
        changbu.peopleCustomID = self.ggData.NewPeopleCustomID;
        changbu.budget = self.ggData.Budget;
        [vc.navigationController pushViewController:changbu animated:YES];
    }
    
}

- (void)jiudianBtnClick{
    
    UIViewController *vc = [self getviewController];
    
    YPOurNewWedsHotelInfoController *hotel = [[YPOurNewWedsHotelInfoController alloc]init];
    hotel.hotelDelegate = self;
    hotel.peopleCustomID = self.ggData.NewPeopleCustomID;
    hotel.hotelName = self.ggData.HotelName;
    hotel.hotelAddress = self.ggData.HotelAddress;
    hotel.hallName = self.ggData.HallName;
    hotel.tableCount = self.ggData.TableCount;
    hotel.rummeryImg = self.ggData.RummeryImg;
    hotel.rummeryXls = self.ggData.RummeryXls;
    [vc.navigationController pushViewController:hotel animated:YES];
    
}

- (void)ledPingBtnClick:(UIButton *)sender{
    
    if (sender.tag == 1002) {
        UIViewController *vc = [self getviewController];
        
        YPOurNewWedsScreenController *screen  = [[YPOurNewWedsScreenController alloc]init];
        screen.screenDelegate = self;
        screen.peopleCustomID = self.ggData.NewPeopleCustomID;
        [vc.navigationController pushViewController:screen animated:YES];
    }
}

- (void)tebieDescBtnClick:(UIButton *)sender{
    
    if (sender.tag == 1003) {
        UIViewController *vc = [self getviewController];
        
        YPNewWedsOtherInfoController *other = [[YPNewWedsOtherInfoController alloc]init];
        other.infoDelegate = self;
        other.type = @"6";//1酒店,2婚期,3led ,4邀请码,5预算,6特别说明
        other.titleStr = @"特别说明";
        other.questionID = self.ggData.NewPeopleCustomID;
        other.contentStr = self.ggData.SpecialVersion;
        [vc.navigationController pushViewController:other animated:YES];
    }
}

- (void)hunqiBtnClick:(UIButton *)sender{
    
    if (sender.tag == 1004) {
        UIViewController *vc = [self getviewController];
        
        YPOurNewWedsWeddingDateController *date = [[YPOurNewWedsWeddingDateController alloc]init];
        date.dateDelegate = self;
        date.peopleCustomID = self.ggData.NewPeopleCustomID;
        date.weddingDate = self.ggData.WeddingDay;
        [vc.navigationController pushViewController:date animated:YES];
    }
}

- (void)yaoqingBtnClick:(UIButton *)sender{
    
    if (sender.tag == 1005) {
        UIViewController *vc = [self getviewController];
        
        YPNewWedsOtherInfoController *other = [[YPNewWedsOtherInfoController alloc]init];
        other.infoDelegate = self;
        other.type = @"4";//1酒店,2婚期,3led ,4邀请码,5预算,6特别说明
        other.titleStr = @"邀请码";
        other.questionID = self.ggData.NewPeopleCustomID;
        other.contentStr = self.ggData.InvitationCode;
        [vc.navigationController pushViewController:other animated:YES];
    }
}

#pragma mark - getviewController
- (UIViewController *)getviewController {
    
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - label设置行间距
-(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
}

#pragma mark - getter
- (NSMutableArray<YPGetNewPeopleQuestionListDataGG *> *)ggDataList{
    if (!_ggDataList) {
        _ggDataList = [NSMutableArray array];
    }
    return _ggDataList;
}

- (YPGetNewPeopleQuestionListDataGG *)ggData{
    if (!_ggData) {
        _ggData = [[YPGetNewPeopleQuestionListDataGG alloc]init];
    }
    return _ggData;
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
