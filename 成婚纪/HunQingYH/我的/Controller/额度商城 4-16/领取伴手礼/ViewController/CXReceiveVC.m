//
//  CXReceiveVC.m
//  HunQingYH
//
//  Created by apple on 2019/9/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - - - - - 领取伴手礼 - - - - - -  - - - - - - - - - - - -

#import "CXReceiveVC.h"
#import "SDCycleScrollView.h"

#import "CXReceiveTableViewCell.h"  // 商家
#import "CXReceiveUserCell.h"       //  用户
#import "CXReceiveCommonCell.h"     // 宴会厅
#import "CXReviceTaoCanCell.h"      // 套餐
#import "YPHunJJSponsorImgCell.h"   // 加载图片

#import "BRDatePickerView.h"
#import "YPGetUserQuotas.h" // 伴手礼领取规则model
#import "YPGetCommodityTypeTableList.h"

#import "CXUserReceiveVC.h"         // 领取界面
#import "CXUserReceiveLogVC.h"  // 领取记录
#import "XHWebImageAutoSize.h"  //  网络图片尺寸
#import "CXSelectGoodSpectionVC.h"  //  选择商品规格
#import "CXShowDidSelectGoodsVC.h"
#import "CXCompanySubReceiveLog.h"  // 酒店j提交的 用户记录
@interface CXReceiveVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UITextFieldDelegate>
{
    UIView *_navView;
    UIButton *_backBtn;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SDCycleScrollView *tableHeaderView;
@property (nonatomic, strong) UILabel *naviTitle;   // 导航栏名称

@property (nonatomic, strong) CXReceiveTableViewCell *comCell;          //  商家填写资料

@property (nonatomic, strong) NSMutableArray<YPGetCommodityTypeTableList *> *listMarr; //  套餐数据
@property (nonatomic, strong) NSMutableArray *goodsMarr;// 商品array
@property (nonatomic, strong) NSMutableArray *allImgArr;    // 所有图片

/** 服务商id */
@property (nonatomic, copy) NSString *FacilitatorId;

/** 婚期 */
@property (nonatomic, copy) NSString *tingDateStr;
@property (nonatomic, strong) YPGetFacilitatorFlowRecord *flowModel;
@property (nonatomic, strong) YPGetUserQuotas *quotasModel;             // 伴手礼领取规则
/** 是否是套餐 */
@property (nonatomic, assign) BOOL isSetMenu;
/** 是否是商品 */
@property (nonatomic, assign) BOOL isGoods;
@end

@implementation CXReceiveVC

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    NSLog(@"%@",FacilitatorId_New);
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"伴手礼";
    [self.view addSubview:self.tableView];
    [self setupNav];
    [self GetUserQuotas];
    [self loadUserReceiveLog];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.rowHeight = 100;
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        _tableView.backgroundColor =  [UIColor colorWithHexString:@"#F5F5F5"];
        
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    int number = 3;
    if (self.listMarr.count != 0) { number += self.listMarr.count;}
    if (self.allImgArr.count != 0) { number += 1;}
    
    return number;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.allImgArr.count != 0 && [self checkCurrentSectionIsGoods:section]) {
         return self.allImgArr.count;
    }
    if (self.listMarr.count != 0 && [self checkCurrentSectionIsSetMenu:section]) {
       return self.listMarr[section - 3].Data.count;
    }
    
    if (section == 1) {
        return YongHu(Profession_New) ? 0 : 1;
    }
    if (section == 2) {
        return  YongHu(Profession_New) ? 1 : 0;
    }
    return 1;
}

/** 当前section 是否是套餐section  */
- (BOOL)checkCurrentSectionIsSetMenu:(NSInteger )section {
    
    return  section >2 && section < 3 + self.listMarr.count;
}

/** 当前section 是否是商品section  */
- (BOOL)checkCurrentSectionIsGoods:(NSInteger )section {
    
    return section > (2 + self.listMarr.count) &&  section < (3 + self.listMarr.count + 1);
}

#pragma mark - - - - - - - - - - - - - - - 创建cell - - - - - - - - - - - - - - - - -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
       // 领取规格
        return [self sectionZeroCell:tableView cellForRowAtIndexPath:indexPath];
    }
    if (indexPath.section == 1) {
        return [self sectionFirstCell:tableView cellForRowAtIndexPath:indexPath];
        // 商家 填写用户资料
    }
    if (indexPath.section == 2) {
        // 用户 领取伴手礼
        return [self sectionUserFirstCell:tableView cellForRowAtIndexPath:indexPath];
    }
    if ([self checkCurrentSectionIsGoods:indexPath.section]) {      //
        return [self sectionReceiveCommonCell:tableView cellForRowAtIndexPath:indexPath];
    }
    if ( [self checkCurrentSectionIsSetMenu:indexPath.section]) {
        return [self sectionSetMenuCell:tableView cellForRowAtIndexPath:indexPath];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableViewCell *)sectionZeroCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 领取说明
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sectionZeroCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"sectionZeroCell"];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#F29129"];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#F9352B"];
        cell.textLabel.font = kFont(15);
        cell.detailTextLabel.font = kFont(13);
        cell.detailTextLabel.numberOfLines = 0;
        cell.clipsToBounds = YES;
        cell.textLabel.numberOfLines = 0;
    }
    
    NSString *title = @"领取说明>>>";
    
    if (self.quotasModel) {
        
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.minimumLineHeight = 20;
        if (!ISEMPTY(self.quotasModel.RulesActivity)) {
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",title,self.quotasModel.RulesActivity] attributes:@{NSParagraphStyleAttributeName:paragraph}];
            [att addAttribute:NSFontAttributeName value:kFont(15) range:NSMakeRange(0, title.length)];
            cell.detailTextLabel.attributedText = att;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableViewCell *)sectionFirstCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 商家
    CXReceiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXReceiveTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXReceiveTableViewCell" owner:nil options:nil] lastObject];
        self.comCell = cell;
        self.comCell.nameTF.delegate = self;
        self.comCell.telTF.delegate = self;
         self.comCell.dateTF.delegate = self;
        self.comCell.tabNum.delegate = self;
        self.comCell.canBiaoTF.delegate = self;
        self.comCell.payMoneyTF.delegate = self;
        cell.clipsToBounds = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCompanySubLog)];
        [cell.receiveLogLab addGestureRecognizer:tap];
        cell.receiveLogLab.userInteractionEnabled = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.subBtn addTarget:self action:@selector(postFlowRecordData) forControlEvents:UIControlEventTouchUpInside];
    [cell.reveiveLogBtn addTarget:self action:@selector(showCompanySubLog) forControlEvents:UIControlEventTouchUpInside];

    self.comCell.nameTF.text = self.flowModel.UserName;
    self.comCell.telTF.text =  self.flowModel.Phone;
    self.comCell.dateTF.text =  self.flowModel.WeddingDate;
    self.comCell.canBiaoTF.text =  self.flowModel.MealMark;
    self.comCell.tabNum.text =  self.flowModel.TablesNumber;
    self.comCell.payMoneyTF.text =  self.flowModel.Money;

    return cell;
}

- (void)showCompanySubLog {
    
    CXCompanySubReceiveLog *log = [[CXCompanySubReceiveLog alloc] init];
    [self.navigationController pushViewController:log animated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 1002) {
        [CXDataManager hiddenKeyBoard];
        [self selectDate];
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    switch (textField.tag - 1000) {
        case 0: self.flowModel.UserName = textField.text; break;
        case 1: self.flowModel.Phone = textField.text; break;
        case 3: self.flowModel.TablesNumber = textField.text; break;
        case 4: self.flowModel.MealMark = textField.text; break;
        case 5: self.flowModel.Money = textField.text; break;
        default:
            break;
    }
    
    return YES;
}

- (void)selectDate {

    [BRDatePickerView showDatePickerWithTitle:@"请选择时间" dateType:BRDatePickerModeDate defaultSelValue:@"" minDate:[NSDate date] maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
        NSArray *arr = [selectValue componentsSeparatedByString:@"-"];
        NSString *text = [NSString stringWithFormat:@"%@  年  %@  月  %@  日",arr[0],arr[1],arr[2]];
        self.comCell.dateTF.text = text;
        self.flowModel.WeddingDate = [NSString stringWithFormat:@"%@年%@月%@日",arr[0],arr[1],arr[2]];
    }];
}

- (UITableViewCell *)sectionUserFirstCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 用户
    CXReceiveUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXReceiveUserCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXReceiveUserCell" owner:nil options:nil] lastObject];
        cell.clipsToBounds = YES;
    }
    cell.model = self.flowModel;
    [cell.reBtn addTarget:self action:@selector(pushUserReceiveVC) forControlEvents:UIControlEventTouchUpInside];
    [cell.relogBtn addTarget:self action:@selector(pushUserReceiveDetailVC) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableViewCell *)sectionSetMenuCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 套餐
    CXReviceTaoCanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXReviceTaoCanCell"];
    if (!cell) {
        cell = [[CXReviceTaoCanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CXReviceTaoCanCell"];
        cell.clipsToBounds = YES;
    }
    cell.goodModel = self.goodsMarr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (UITableViewCell *)sectionReceiveCommonCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YPHunJJSponsorImgCell *cell = [YPHunJJSponsorImgCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *str = self.allImgArr[indexPath.row];
    
    cell.imgStr = str;
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str]  placeholderImage:[UIImage imageNamed:@"图片占位"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        /**
         *  缓存image size
         */
        [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
            
            //reload row
            if(result && (self.isViewLoaded && self.view.window))  {
                
                [tableView  xh_reloadRowAtIndexPath:indexPath forURL:imageURL];
            }else{ }
        }];
    }];
    return cell;
    
}

#pragma mark - - - - - - - - - - - - - - - TableViewDelegate - - - - - - - - - - - - - - - - -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return UITableViewAutomaticDimension;
    }
    if (indexPath.section == 1) {
        return 320;
    }
    if (indexPath.section == 2) {
        return 100;
    }
    if ([self checkCurrentSectionIsSetMenu:indexPath.section]) {
        return Line375(120);
    }
    if ([self checkCurrentSectionIsGoods:indexPath.section]) {

        NSString *str = self.allImgArr[indexPath.row];
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:200];
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if ( section == 1  ) { return YongHu(Profession_New) ? 0 : 10; }

    if ( section == 2  ) { return YongHu(Profession_New) ? 10 : 0; }
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {  return YongHu(Profession_New) ? 0 : 38;  }
    if ([self checkCurrentSectionIsSetMenu:section])    {  return 38;  }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CXSetMenuSectionHeader *view = [[CXSetMenuSectionHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 38)];
    view.reviceBtn.tag = 2000 + section - 3;
    view.reviceBtn.hidden = YES ;
    [view.reviceBtn addTarget:self action:@selector(pushSetMenuDetailVC:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self checkCurrentSectionIsSetMenu:section]) {
        view.name.text = self.listMarr[section - 3].TypeName;
//        if (YongHu(Profession_New)) { view.reviceBtn.hidden = NO;   }
        if (!ISEMPTY(self.flowModel.Id)) { view.reviceBtn.hidden = NO; }
    }else  if (section == 1) {
        view.name.text = YongHu(Profession_New) ? @"" : @"添加用户资料";
    }else {
        view.name.text = @"";
    }
    
    if (view.reviceBtn.hidden == NO) {
        view.reviceBtn.hidden = ISEMPTY(self.flowModel.Id);
    }
    
    return view;
}

- (SDCycleScrollView *)tableHeaderView {
    
    if (!_tableHeaderView) {
        _tableHeaderView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 170) delegate:self placeholderImage:[UIImage imageNamed:@"伴手礼Place"]];
        _tableHeaderView.currentPageDotColor = NavBarColor;
        _tableHeaderView.pageDotColor = WhiteColor;
        _tableHeaderView.layer.cornerRadius = 4;
        _tableHeaderView.clipsToBounds = YES;
    }
    return _tableHeaderView;
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
    [self.view addSubview:_navView];
    
    _backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    //    backBtn.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    //    backBtn.layer.cornerRadius = 16;
    //    backBtn.clipsToBounds = YES;
    [_navView addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.left.mas_equalTo(_navView.mas_left).mas_offset(10);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    [_navView addSubview:self.naviTitle];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > (200 - NAVIGATION_BAR_HEIGHT*2)) {
        CGFloat alpha = (offsetY-(200 - NAVIGATION_BAR_HEIGHT*2)) / NAVIGATION_BAR_HEIGHT;
        _navView.backgroundColor = WhiteColor;
        [_backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
        _navView.alpha = alpha;
    }else{
        _navView.backgroundColor = ClearColor;
        [_backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
        _navView.alpha = 1.0;
    }
}

#pragma mark - - - - - - - - - - - - - - - 数据请求 - - - - - - - - - - - - - - - - -
// 获取用户可使用的伴手礼列表
- (void)loadUserMaxLine{
    
    [EasyShowLodingView showLoding];
    
    //    NSString *url = @"/api/HQOAApi/GetPreferentialCommodityInfo";
    NSString *url = @"/api/HQOAApi/GetUserQuotas";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
     params[@"Type"] = @"0";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    }];
}

#pragma mark - 提交l伴手礼用户信息
- (void)postFlowRecordData{
    
    if (![YPGetFacilitatorFlowRecord checkoutData:self.flowModel]) {  return; }
    
    [EasyShowLodingView showLoding];
    
    //    NSString *url = @"/api/HQOAApi/GetPreferentialCommodityInfo";
    NSString *url = @"/api/HQOAApi/CreateFacilitatorFlowRecord";
    NSDictionary *param = [self.flowModel mj_JSONObject];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:param Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"提交成功"];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    }];
}

#pragma mark - - - - - - - - - - - - - - - 获取伴手礼规则 - - - - - - - - - - - - - - - - -
- (void)GetUserQuotas{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetUserQuotas";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    params[@"Type"] = @"0";//0伴手礼,1婚礼返还,2代收
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.quotasModel = [YPGetUserQuotas mj_objectWithKeyValues:object];
            if (self.quotasModel.Quota > 0) {//0伴手礼,1婚礼返还,2代收
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"婚宴伴手礼\n在交付酒店定金后一个周内领取有效" message:nil delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                [alert show];
            }
            
            CGSize size  = [UIImage getImageSizeWithURL:self.quotasModel.HeadImg];
            CGFloat scal = (CGFloat)(size.height *ScreenWidth);
            self.tableHeaderView.height =  scal / size.width;
            self.tableHeaderView.imageURLStringsGroup = @[self.quotasModel.HeadImg];
            
            [self GetCommodityTypeTableList];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    }];
}

#pragma mark 获取类别-商品列表
- (void)GetCommodityTypeTableList{
    
    [EasyShowLodingView showLoding];
    
//    NSString *url = @"/api/HQOAApi/GetCommodityTypeTableList";
    NSString *url = @"/api/HQOAApi/GetPackageTypeTableList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Type"] = @"1";//类型(0：全部，1上架，2下架)
//    params[@"ActivityId"] = act_banShouLi;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.goodsMarr removeAllObjects];
            self.listMarr = [YPGetCommodityTypeTableList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            NSArray *arr = [NSArray arrayWithArray:self.listMarr.copy];
            for (YPGetCommodityTypeTableList *listModel in arr) {
                if (listModel.Data.count == 0) {
                    [self.listMarr removeObject:listModel];
                }else {
                    [self.goodsMarr addObjectsFromArray:listModel.Data];
                    for (YPGetCommodityTypeTableListData *subModel in listModel.Data) {
                        [self.allImgArr addObjectsFromArray:subModel.CarouselFigureArr];
                    }
                }
            }
            
            [self.tableView reloadData];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
}

#pragma mark - - - - - - - - - - - - - - - 获取用户领取记录 - - - - - - - - - - - - - - - - -
- (void)loadUserReceiveLog {
   
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorSubmitRecord";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"UserNamePhone"] = UserPhone_New;
    params[@"PageCount"] = @"100";
    params[@"PageIndex"] = @"1";
    params[@"ActivityType"] = @"0";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.goodsMarr removeAllObjects];
            NSArray *subArr = [YPGetFacilitatorFlowRecord mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            if (subArr.count > 0) { _flowModel = subArr[0];  }
            [self.tableView reloadData];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    }];
}

#pragma mark - - - - - - - - - - - - - - - 懒蛋 - - - - - - - - - - - - - - - - -

- (YPGetUserQuotas *)quotasModel{
    if (!_quotasModel) {
        _quotasModel = [[YPGetUserQuotas alloc]init];
    }
    return _quotasModel;
}
- (NSMutableArray<YPGetCommodityTypeTableList *> *)listMarr {
    
    if (!_listMarr) {
        _listMarr = [[NSMutableArray alloc] init];
    }
    return _listMarr;
}
- (NSMutableArray *)goodsMarr {
    
    if (!_goodsMarr) {
        _goodsMarr = [[NSMutableArray alloc] init];
    }
    return _goodsMarr;
}
- (NSMutableArray *)allImgArr {
    
    if (!_allImgArr) {
        _allImgArr = [[NSMutableArray alloc] init];
    }
    return _allImgArr;
}
- (YPGetFacilitatorFlowRecord *)flowModel {
    
    if (!_flowModel) {
        _flowModel = [[YPGetFacilitatorFlowRecord alloc] init];
        _flowModel.FacilitatorId = FacilitatorId_New;
        _flowModel.PaymentType = @"1";
    }
    return _flowModel;
}
- (UILabel *)naviTitle {
    
    if (!_naviTitle) {
        _naviTitle = [[UILabel alloc] initWithFrame:CGRectMake(Line375(42), STATUSBAR_HEIGHT_S, ScreenWidth - Line375(42) * 2, 44)];
        _naviTitle.textAlignment = NSTextAlignmentCenter;
        _naviTitle.font = kFont(15);
        _naviTitle.text = @"伴手礼";
    }
    return _naviTitle;
}

#pragma mark - - - - - - - - - - - - - - - 界面跳转 - - - - - - - - - - - - - - - - -
// 立即领取。       选择商品规格。
- (void)pushSetMenuDetailVC:(UIButton *)sender {
    YPGetCommodityTypeTableList *model = self.listMarr[sender.tag - 2000];
    CXSelectGoodSpectionVC *vc = [[CXSelectGoodSpectionVC alloc] init];
    vc.name = model.TypeName;
    vc.dataArr = model.Data;
    vc.packageId = model.TypeId;
    vc.flowRecord = self.flowModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

// 用户领取
- (void)pushUserReceiveVC {
    
    CXUserReceiveVC *vc = [[CXUserReceiveVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// 用户领取记录
- (void)pushUserReceiveDetailVC {
    
    if (ISEMPTY(self.flowModel.Id)) {
        [self showAlert];
        return;
    }
    
    CXUserReceiveLogVC *vc = [[CXUserReceiveLogVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showAlert {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您在平台合作的酒店付款后即可免费领取,请联系您所定的酒店方为您添加!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


@end

@implementation CXSetMenuSectionHeader

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self loadSubViews];
    }
    return  self;
}

- (void)loadSubViews {
    
    self.backgroundColor = [UIColor whiteColor];
    self.name = [[UILabel alloc] initWithFrame:self.bounds];
    self.name.left = 15;
    self.name.font = kFont(15);
    [self addSubview:self.name];
    self.name.clipsToBounds = YES;
    
    self.reviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reviceBtn.frame = CGRectMake(ScreenWidth - Line375(105), (self.height - Line375(26))/2, Line375(90), Line375(26));
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = self.reviceBtn.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.2),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[RGB(255, 0, 123) CGColor],(id)[RGB(255, 83, 103) CGColor]]];//渐变数组
    [self.reviceBtn.layer addSublayer:gradientLayer];
    [self.reviceBtn setTitle:@"立即领取" forState:UIControlStateNormal];
    self.reviceBtn.titleLabel.font = kFont(12);
    self.reviceBtn.layer.cornerRadius = self.reviceBtn.height/2;
    self.reviceBtn.clipsToBounds = YES;
    
    [self addSubview:self.reviceBtn];
}

@end

