//
//  YPOurNewWedsHotelInfoController.m
//  HunQingYH
//
//  Created by Else丶 on 2017/12/4.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPOurNewWedsHotelInfoController.h"
#import "YPLimitInputCell.h"
#import "YPTableCountInputCell.h"
#import "YJJTextField.h"
#import "YPTingSizeCell.h"
#import "YPOurNewWedsHeaderCell.h"
#import "WriteThirdImgTableViewCell.h"

@interface YPOurNewWedsHotelInfoController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,ZLPhotoPickerBrowserViewControllerDelegate,ZLPhotoPickerViewControllerDelegate,DeleteImgDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YJJTextField *nameTF;
@property (nonatomic, strong) YJJTextField *addressTF;
@property (nonatomic, strong) UITextField *tableCountTF;
@property (nonatomic, strong) YJJTextField *tingNameTF;

@property (nonatomic, strong) UITextField *changTF;
@property (nonatomic, strong) UITextField *kuanTF;
@property (nonatomic, strong) UITextField *gaoTF;

@property (nonatomic, strong) NSMutableArray *imgLists;

@end

@implementation YPOurNewWedsHotelInfoController{
    UIView *_navView;
//    MBProgressHUD *hud;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"场布预算";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //设置导航栏右边
    UIButton *doneBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"保存" forState:UIControlStateNormal];
    [doneBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.right.mas_equalTo(-15);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }else{
        if (self.imgLists.count<3) {
            return 2;
        }else if (self.imgLists.count>=3&&self.imgLists.count<6){
            return 3;
        }else if (self.imgLists.count>=6&&self.imgLists.count<=9){
            return 4;
        }else{
            return 2;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        YPLimitInputCell *cell = [YPLimitInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"酒店名称";
//            cell.maxNum = 20;
            
            if (!self.nameTF) {
                self.nameTF = [YJJTextField yjj_textField];
            }
            self.nameTF.layer.cornerRadius = 3;
            self.nameTF.clipsToBounds = YES;
            self.nameTF.backgroundColor = CHJ_bgColor;
            self.nameTF.maxLength = 20;
            self.nameTF.errorStr = [NSString stringWithFormat:@"字数长度不得超过%d位",20];
            self.nameTF.placeholder = @"";
            self.nameTF.showHistoryList = NO;
            
//            if (self.hotelName.length > 0) {
//                self.nameTF.textField.text = self.hotelName;
//            }
            
            [cell.contentView addSubview:self.nameTF];
            [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(cell.iconImgV.mas_bottom).mas_offset(15);
                make.right.mas_equalTo(-15);
                make.bottom.mas_equalTo(-10);
            }];
        }else if (indexPath.row == 1) {
            cell.titleLabel.text = @"酒店地址";
            
            if (!self.addressTF) {
                self.addressTF = [YJJTextField yjj_textField];
            }
            self.addressTF.layer.cornerRadius = 3;
            self.addressTF.clipsToBounds = YES;
            self.addressTF.backgroundColor = CHJ_bgColor;
            self.addressTF.maxLength = 30;
            self.addressTF.errorStr = [NSString stringWithFormat:@"字数长度不得超过%d位",30];
            self.addressTF.placeholder = @"";
            self.addressTF.showHistoryList = NO;
            
//            if (self.hotelAddress.length > 0) {
//                self.addressTF.textField.text = self.hotelAddress;
//            }
            
            [cell.contentView addSubview:self.addressTF];
            [self.addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(cell.iconImgV.mas_bottom).mas_offset(15);
                make.right.mas_equalTo(-15);
                make.bottom.mas_equalTo(-10);
            }];
        }else if (indexPath.row == 2) {
            YPTableCountInputCell *cell = [YPTableCountInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"酒店桌数";
            
//            if (self.tableCount.length > 0) {
//                self.tableCountTF.text = self.tableCount;
//            }
            
            self.tableCountTF = cell.inputTF;
            return cell;
        }else if (indexPath.row == 3) {
            cell.titleLabel.text = @"宴会厅名称";

            if (!self.tingNameTF) {
                self.tingNameTF = [YJJTextField yjj_textField];
            }
            self.tingNameTF.layer.cornerRadius = 3;
            self.tingNameTF.clipsToBounds = YES;
            self.tingNameTF.backgroundColor = CHJ_bgColor;
            self.tingNameTF.maxLength = 30;
            self.tingNameTF.errorStr = [NSString stringWithFormat:@"字数长度不得超过%d位",30];
            self.tingNameTF.placeholder = @"";
            self.tingNameTF.showHistoryList = NO;
            
//            if (self.hallName.length > 0) {
//                self.tingNameTF.textField.text = self.hallName;
//            }
            
            [cell.contentView addSubview:self.tingNameTF];
            [self.tingNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(cell.iconImgV.mas_bottom).mas_offset(15);
                make.right.mas_equalTo(-15);
                make.bottom.mas_equalTo(-10);
            }];
        }else if (indexPath.row == 4){
            YPTingSizeCell *cell = [YPTingSizeCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"宴会厅尺寸";
            
            self.changTF = cell.changTF;
            self.kuanTF = cell.kuanTF;
            self.gaoTF = cell.gaoTF;
            
//            NSArray *arr = [self.rummeryXls componentsSeparatedByString:@","];
//            if (arr.count > 0) {
//                cell.changTF.text = arr[0];
//                cell.kuanTF.text = arr[1];
//                cell.gaoTF.text = arr[2];
//            }
            
            return cell;
        }
        return cell;
        
    }else if (indexPath.section == 1){
        
        static NSString *WriteThreeCellIdentifier = @"WriteThirdTableViewCellIdentifier";
        WriteThirdImgTableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:WriteThreeCellIdentifier];
        
        if (!oneCell) {
            oneCell = [[[NSBundle mainBundle ]loadNibNamed:@"WriteThirdImgTableViewCell" owner:self options:nil] objectAtIndex:0]; //
        }
        
        oneCell.delegate = self;
        
        if (self.imgLists.count<3) {
            
            if (indexPath.row == 0) {
                YPOurNewWedsHeaderCell *cell = [YPOurNewWedsHeaderCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleLabel.text = @"宴会厅图片";
                return cell;
            }else{
                if (self.imgLists.count==0) {
                    [oneCell.bt1 setHidden:NO];
                    [oneCell.bt2 setHidden:YES];
                    [oneCell.bt3 setHidden:YES];
                }
                
                else  if (self.imgLists.count==1) {
                    [oneCell.bt1 setHidden:NO];
                    [oneCell.bt2 setHidden:NO];
                    [oneCell.bt3 setHidden:YES];
                    
                    
                    
                    UIImage *asset = [self.imgLists objectAtIndex:0];
                    
                    [oneCell.bt1 setImage:asset forState:UIControlStateNormal];
                    [oneCell.bt1 setTag:0];
                    //设置不同的selected标签来判断图片是否加载 区别按钮事件
                    [oneCell.bt1 setSelected:YES];
                    [oneCell.bt2 setSelected:NO];
                }
                else if (self.imgLists.count==2) {
                    [oneCell.bt1 setHidden:NO];
                    [oneCell.bt2 setHidden:NO];
                    [oneCell.bt3 setHidden:NO];
                    
                    //设置不同的selected标签来判断图片是否加载 区别按钮事件
                    [oneCell.bt1 setSelected:YES];
                    [oneCell.bt2 setSelected:YES];
                    [oneCell.bt3 setSelected:NO];
                    for (int i=1; i<3; i++) {
                        UIImage *asset = [self.imgLists objectAtIndex:i-1];
                        
                        switch (i) {
                            case 1:
                                [oneCell.bt1 setImage:asset forState:UIControlStateNormal];
                                [oneCell.bt1 setTag:0];
                                break;
                            case 2:
                                [oneCell.bt2 setImage:asset forState:UIControlStateNormal];
                                [oneCell.bt2 setTag:1];
                                break;
                            default:
                                break;
                        }
                        
                    }
                    
                }
            }

        }else if (self.imgLists.count>=3&&self.imgLists.count<6){
            
            if (indexPath.row == 0) {
                YPOurNewWedsHeaderCell *cell = [YPOurNewWedsHeaderCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleLabel.text = @"宴会厅图片";
                return cell;
            }else if (indexPath.row==1) {
                
                
                [oneCell.bt1 setHidden:NO];
                [oneCell.bt2 setHidden:NO];
                [oneCell.bt3 setHidden:NO];
                //设置不同的selected标签来判断图片是否加载 区别按钮事件
                [oneCell.bt1 setSelected:YES];
                [oneCell.bt2 setSelected:YES];
                [oneCell.bt3 setSelected:YES];
                for (int i=1; i<4; i++) {
                    UIImage *asset = [self.imgLists objectAtIndex:i-1];
                    switch (i) {
                        case 1:
                            [oneCell.bt1 setImage:asset forState:UIControlStateNormal];
                            [oneCell.bt1 setTag:0];
                            break;
                        case 2:
                            [oneCell.bt2 setImage:asset forState:UIControlStateNormal];
                            [oneCell.bt2 setTag:1];
                            break;
                        case 3:
                            [oneCell.bt3 setImage:asset forState:UIControlStateNormal];
                            [oneCell.bt3 setTag:2];
                            break;
                        default:
                            break;
                    }
                    
                }
                
                
            }else if (indexPath.row==2){
                
                if (self.imgLists.count==3) {
                    [oneCell.bt1 setHidden:NO];
                    [oneCell.bt2 setHidden:YES];
                    [oneCell.bt3 setHidden:YES];
                    
                    [oneCell.bt1 setSelected:NO];
                }
                else  if (self.imgLists.count==4) {
                    [oneCell.bt1 setHidden:NO];
                    [oneCell.bt2 setHidden:NO];
                    [oneCell.bt3 setHidden:YES];
                    
                    UIImage *asset = [self.imgLists objectAtIndex:3];
                    
                    [oneCell.bt1 setImage:asset forState:UIControlStateNormal];
                    [oneCell.bt1 setTag:3];
                    [oneCell.bt1 setSelected:YES];
                    
                    [oneCell.bt2 setSelected:NO];
                }
                else if (self.imgLists.count==5) {
                    [oneCell.bt1 setHidden:NO];
                    [oneCell.bt2 setHidden:NO];
                    [oneCell.bt3 setHidden:NO];
                    
                    [oneCell.bt3 setSelected:NO];
                    for (int i=3; i<5; i++) {
                        UIImage *asset = [self.imgLists objectAtIndex:i];
                        
                        switch (i) {
                            case 3:
                                [oneCell.bt1 setImage:asset forState:UIControlStateNormal];
                                [oneCell.bt1 setTag:3];
                                [oneCell.bt1 setSelected:YES];
                                break;
                            case 4:
                                [oneCell.bt2 setImage:asset forState:UIControlStateNormal];
                                [oneCell.bt2 setTag:4];
                                [oneCell.bt2 setSelected:YES];
                                break;
                            default:
                                break;
                        }
                        
                    }
                }
            }
        }else if (self.imgLists.count>=6&&self.imgLists.count<=9){
            
            if (indexPath.row == 0) {
                YPOurNewWedsHeaderCell *cell = [YPOurNewWedsHeaderCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleLabel.text = @"宴会厅图片";
                return cell;
            }else if (indexPath.row==1) {
                
                [oneCell.bt1 setHidden:NO];
                [oneCell.bt2 setHidden:NO];
                [oneCell.bt3 setHidden:NO];
                //设置不同的selected标签来判断图片是否加载 区别按钮事件
                [oneCell.bt1 setSelected:YES];
                [oneCell.bt2 setSelected:YES];
                [oneCell.bt3 setSelected:YES];
                for (int i=1; i<4; i++) {
                    UIImage *asset = [self.imgLists objectAtIndex:i-1];
                    switch (i) {
                        case 1:
                            [oneCell.bt1 setImage:asset forState:UIControlStateNormal];
                            [oneCell.bt1 setTag:0];
                            break;
                        case 2:
                            [oneCell.bt2 setImage:asset forState:UIControlStateNormal];
                            [oneCell.bt2 setTag:1];
                            break;
                        case 3:
                            [oneCell.bt3 setImage:asset forState:UIControlStateNormal];
                            [oneCell.bt3 setTag:2];
                            break;
                        default:
                            break;
                    }
                    
                }
                
                
            }else if (indexPath.row==2){
                
                [oneCell.bt1 setHidden:NO];
                [oneCell.bt2 setHidden:NO];
                [oneCell.bt3 setHidden:NO];
                //设置不同的selected标签来判断图片是否加载 区别按钮事件
                [oneCell.bt1 setSelected:YES];
                [oneCell.bt2 setSelected:YES];
                [oneCell.bt3 setSelected:YES];
                
                for (int i=3; i<6; i++) {
                    UIImage *asset = [self.imgLists objectAtIndex:i];
                    
                    switch (i) {
                        case 3:
                            [oneCell.bt1 setImage:asset forState:UIControlStateNormal];
                            [oneCell.bt1 setTag:3];
                            [oneCell.bt1 setSelected:YES];
                            break;
                        case 4:
                            [oneCell.bt2 setImage:asset forState:UIControlStateNormal];
                            [oneCell.bt2 setTag:4];
                            [oneCell.bt2 setSelected:YES];
                            break;
                        case 5:
                            [oneCell.bt3 setImage:asset forState:UIControlStateNormal];
                            [oneCell.bt3 setTag:5];
                            [oneCell.bt3 setSelected:YES];
                            break;
                        default:
                            break;
                    }
                    
                }
                
            }else if (indexPath.row == 3) {
                
                if (self.imgLists.count==6) {
                    [oneCell.bt1 setHidden:NO];
                    [oneCell.bt2 setHidden:YES];
                    [oneCell.bt3 setHidden:YES];
                    
                    [oneCell.bt1 setSelected:NO];
                    
                }else  if (self.imgLists.count==7) {
                    [oneCell.bt1 setHidden:NO];
                    [oneCell.bt2 setHidden:NO];
                    [oneCell.bt3 setHidden:YES];
                    
                    UIImage *asset = [self.imgLists objectAtIndex:6];
                    
                    [oneCell.bt1 setImage:asset forState:UIControlStateNormal];
                    [oneCell.bt1 setTag:6];
                    [oneCell.bt1 setSelected:YES];
                    
                    [oneCell.bt2 setSelected:NO];
                    
                }else if (self.imgLists.count==8) {
                    [oneCell.bt1 setHidden:NO];
                    [oneCell.bt2 setHidden:NO];
                    [oneCell.bt3 setHidden:NO];
                    
                    [oneCell.bt3 setSelected:NO];
                    for (int i=6; i<8; i++) {
                        UIImage *asset = [self.imgLists objectAtIndex:i];
                        
                        switch (i) {
                            case 6:
                                [oneCell.bt1 setImage:asset forState:UIControlStateNormal];
                                [oneCell.bt1 setTag:6];
                                [oneCell.bt1 setSelected:YES];
                                break;
                            case 7:
                                [oneCell.bt2 setImage:asset forState:UIControlStateNormal];
                                [oneCell.bt2 setTag:7];
                                [oneCell.bt2 setSelected:YES];
                                break;
                            default:
                                break;
                        }
                        
                    }
                }else if (self.imgLists.count == 9) {
                    [oneCell.bt1 setHidden:NO];
                    [oneCell.bt2 setHidden:NO];
                    [oneCell.bt3 setHidden:NO];
                    
                    [oneCell.bt3 setSelected:YES];
                    for (int i=6; i<9; i++) {
                        UIImage *asset = [self.imgLists objectAtIndex:i];
                        
                        switch (i) {
                            case 6:
                                [oneCell.bt1 setImage:asset forState:UIControlStateNormal];
                                [oneCell.bt1 setTag:6];
                                [oneCell.bt1 setSelected:YES];
                                break;
                            case 7:
                                [oneCell.bt2 setImage:asset forState:UIControlStateNormal];
                                [oneCell.bt2 setTag:7];
                                [oneCell.bt2 setSelected:YES];
                                break;
                            case 8:
                                [oneCell.bt3 setImage:asset forState:UIControlStateNormal];
                                [oneCell.bt3 setTag:5];
                                [oneCell.bt3 setSelected:YES];
                                break;
                            default:
                                break;
                        }
                        
                    }
                }
                
            }else{
                
                [oneCell.bt1 setHidden:NO];
            }
        }
        return oneCell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            return 103;
        }else if (indexPath.row == 4) {
            return 110;
        }else {
            return 130;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 44;
        }else{
            return [WriteThirdImgTableViewCell getHeight];
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneBtnClick{
    NSLog(@"doneBtnClick");
    
    if (self.nameTF.textField.text.length == 0) {
        
        [EasyShowTextView showText:@"请输入酒店名称"];
    }else if (self.addressTF.textField.text.length == 0){
        
        [EasyShowTextView showText:@"请输入酒店地址"];
    }else if (self.tableCountTF.text.length == 0){
        
        [EasyShowTextView showText:@"请输入桌数"];
    }else if (self.tingNameTF.textField.text.length == 0){
        
        [EasyShowTextView showText:@"请输入宴会厅名称"];
    }else if (self.imgLists.count == 0){
        
        [EasyShowTextView showText:@"请选择图片"];
    }else if (self.changTF.text.length == 0 || self.kuanTF.text.length == 0 || self.gaoTF.text.length == 0 ){
        
        [EasyShowTextView showText:@"请输入宴会厅尺寸"];
    }else{
        
        //上传图片
        [self uploadSelectImageRequest];
        
    }
}

//上传相册
-(void)uploadSelectImageRequest{
    [EasyShowLodingView showLoding];

    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:3];
    [dict setValue:@"2" forKey:@"os"];
    [dict setValue:@"0" forKey:@"ot"];
    [dict setValue:UserId_New forKey:@"oi"];
    [dict setValue:@"2" forKey:@"t"];
    
    BAImageDataEntity *imageEntity = [BAImageDataEntity new];
    imageEntity.urlString = @"http://121.42.156.151:93/FileStorage.aspx";
    imageEntity.needCache = NO;
    imageEntity.parameters = dict;
    imageEntity.imageArray = self.imgLists;
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0;
    imageEntity.fileNames = nil;
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        NSLog(@"相册返回：====%@",response);
        NSString *imgStr = [response objectForKey:@"Inform"];
        
        [self UpNewPeoplePublicWithImgStr:imgStr];
        
    } failurBlock:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    //     ba_uploadImageWithUrlString:@"http://121.42.156.151:93/FileStorage.aspx" parameters:dict imageArray:self.imgLists fileNames:nil imageType:@"png" imageScale:0 successBlock:^(id response) {
    //
    //    } failurBlock:^(NSError *error) {
    //
    //
    //    } uploadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    //
    //    }];
    
    
    
}

#pragma mark - TakePhoto
- (void)takePhoto:(id)sender {
    
    NSLog(@"takephoto");
    UIActionSheet *actionsheet =[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [actionsheet showInView:self.view];
    
}
#pragma TakePhoto

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self openCamera];
    }else if (buttonIndex==1)
    {
        [self LocalPhoto];
    }
    
}

- (void)openCamera{
    ZLCameraViewController *cameraVc = [[ZLCameraViewController alloc] init];
    // 拍照最多个数
    cameraVc.maxCount = 9-self.imgLists.count;
    
    cameraVc.callback = ^(NSArray *cameras){
        
        for (int i=0; i<cameras.count; i++) {
            ZLCamera *camera  =[cameras objectAtIndex:i];
            UIImage *image = camera.thumbImage;
            [self.imgLists addObject:image];
            if (self.imgLists.count>9) {
                Alertmsg(@"不能超过9张", nil);
                break;
            }
        }
    };
    [cameraVc showPickerVc:self];
}

- (void)LocalPhoto{
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.maxCount = 9-self.imgLists.count;
    pickerVc.delegate = self;
    [pickerVc showPickerVc:self];
}

// 代理回调方法
#pragma mark - 相册回调
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    //    _lastSelectedAssets=assets;
    for (int i=0; i<assets.count; i++) {
        ZLPhotoAssets *camera  =[assets objectAtIndex:i];
        UIImage *image = camera.originImage;
        [self.imgLists addObject:image];
        if (self.imgLists.count>9) {
            Alertmsg(@"不能超过9张", nil);
            break;
        }
    }
    
    [self.tableView reloadData];
}
-(void)onBtClickForPick
{
    [self takePhoto:nil];
}
-(void)onBtClickForDel:(NSUInteger)number
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:number inSection:0];
    // 图片游览器
    
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 淡入淡出效果
    // pickerBrowser.status = UIViewAnimationAnimationStatusFade;
    // 数据源/delegate
    pickerBrowser.editing = YES;
    NSMutableArray *photos=[[NSMutableArray alloc]initWithCapacity:self.imgLists.count];
    for (int i=0; i<self.imgLists.count; i++) {
        ZLPhotoPickerBrowserPhoto *photo=[ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:[self.imgLists objectAtIndex:i]];
        [photos addObject:photo];
        
    }
    pickerBrowser.photos = photos;
    // 能够删除
    pickerBrowser.delegate = self;
    // 当前选中的值
    pickerBrowser.currentIndexPath=indexPath;
    // 展示控制器
    [pickerBrowser showPickerVc:self];
    
    
}
- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"走方法");
    if (self.imgLists.count >indexPath.row) {
        [self.imgLists removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

#pragma mark 修改新人公共问题
- (void)UpNewPeoplePublicWithImgStr:(NSString *)imgStr{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpNewPeoplePublic";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"NewPeopleCustomID"] = self.peopleCustomID;
    params[@"UpType"] = @"1";//1酒店,2婚期,3led ,4邀请码,5预算,6特别说明
    params[@"Budget"] = @"000";//不修改 随便传
    params[@"WeddingDay"] = @"";
    params[@"HotelName"] = self.nameTF.textField.text;
    params[@"HotelAddress"] = self.addressTF.textField.text;
    params[@"HallName"] = self.tingNameTF.textField.text;
    params[@"TableCount"] = self.tableCountTF.text;
    params[@"RummeryImg"] = imgStr;
    params[@"RummeryXls"] = [NSString stringWithFormat:@"%@,%@,%@",self.changTF.text,self.kuanTF.text,self.gaoTF.text];
    params[@"IsLEDScreen"] = @"333";//不修改 随便传
    params[@"InvitationCode"] = @"";
    params[@"SpecialVersion"] = @"";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@""];
            
            if ([self.hotelDelegate respondsToSelector:@selector(yp_Hotel)]) {
                [self.navigationController popViewControllerAnimated:YES];
                [self.hotelDelegate yp_Hotel];
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

#pragma mark - getter
- (NSMutableArray *)imgLists{
    if (!_imgLists) {
        _imgLists = [NSMutableArray array];
    }
    return _imgLists;
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
