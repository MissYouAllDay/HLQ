//
//  YPAddYanHuiTingController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/15.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#warning 弃用

#import "YPAddYanHuiTingController.h"
#import "YPAddYHTInputCell.h"
#import "YPAddYHTTableCountCell.h"
#import "WriteThirdImgTableViewCell.h"
#import "BANetManager.h"
@interface YPAddYanHuiTingController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,ZLPhotoPickerBrowserViewControllerDelegate,ZLPhotoPickerViewControllerDelegate,DeleteImgDelegate>
{
//    MBProgressHUD *hud ;
    NSString *upXCString;//添加相册网络请求字段
}
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation YPAddYanHuiTingController{
    UIView *_navView;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
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
    if ([self.typeStr isEqualToString:@"1"]) {
           titleLab.text = @"添加宴会厅";
    }else{
           titleLab.text = self.tingName;
    }
 
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
 
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        if (self.imgLists.count<3) {
            return 1;
        }else if (self.imgLists.count>=3&&self.imgLists.count<6){
            return 2;
        }else if (self.imgLists.count>=6&&self.imgLists.count<=9){
            return 3;
        }else{
            return 1;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            YPAddYHTInputCell *cell = [YPAddYHTInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleLabel.text = @"宴会厅名";
            
            if ([self.typeStr isEqualToString:@"1"]) {
                  cell.inputTF.placeholder = @"15个字以内";
            }else{
                cell.inputTF.text =self.tingName;
            }
          
            self.titleTF = cell.inputTF;
            return cell;
            
        }else if (indexPath.row == 1) {
            
            YPAddYHTTableCountCell *cell = [YPAddYHTTableCountCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"最低价位";
            if ([self.typeStr isEqualToString:@"1"]) {
               cell.countTF.placeholder = @"请输入最低价位";
            }else{
                cell.countTF.text =[NSString stringWithFormat:@"%.2f",self.lowestPrice];
            }
            
            self.priceTF = cell.countTF;
            cell.unitLabel.text = @"元";
            return cell;
        
        }else if (indexPath.row == 2) {
            
            YPAddYHTTableCountCell *cell = [YPAddYHTTableCountCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"容纳桌数";
              if ([self.typeStr isEqualToString:@"1"]) {
                  cell.countTF.placeholder = @"请输入容纳桌数";
              }else{
                  cell.countTF.text =[NSString stringWithFormat:@"%zd",self.tableNum];
              }
            
            self.countTF = cell.countTF;
            cell.unitLabel.text = @"桌";
            return cell;
            
        }
        
    }else if (indexPath.section == 1){

        static NSString *WriteThreeCellIdentifier = @"WriteThirdTableViewCellIdentifier";
        WriteThirdImgTableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:WriteThreeCellIdentifier];
        
        if (!oneCell) {
            oneCell = [[[NSBundle mainBundle ]loadNibNamed:@"WriteThirdImgTableViewCell" owner:self options:nil] objectAtIndex:0]; //
        }
        
        oneCell.delegate = self;

        if (self.imgLists.count<3) {
            
            
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
            
        }else if (self.imgLists.count>=3&&self.imgLists.count<6){
            
            if (indexPath.row==0) {
                
                
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
                
                
            }else if (indexPath.row==1){
                
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
            
            if (indexPath.row==0) {

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
                
                
            }else if (indexPath.row==1){
                
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
                
            }else if (indexPath.row == 2) {
                
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
        return 45;
    }else if (indexPath.section == 1) {
        return [WriteThirdImgTableViewCell getHeight];
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 100;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return  [self addFooterView];
    }else{
        return nil;
    }
}

- (UIView *)addFooterView{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = CHJ_bgColor;
    [self.view addSubview:view];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundColor:NavBarColor];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sureBtn];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(view).mas_offset(50);
        make.height.mas_equalTo(45);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sureBtnClick{
    NSLog(@"sureBtnClick");
    
    if (self.titleTF.text.length == 0) {
        Alertmsg(@"请输入标题", nil)
    }else if (self.priceTF.text.length == 0){
        Alertmsg(@"请输入最低价位", nil)
    }else if (self.countTF.text.length == 0){
        Alertmsg(@"请输入容纳桌数", nil)
    }else{
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
        upXCString =[response objectForKey:@"Inform"];
        [self AddBanquetHallInfo];
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

#pragma mark - 网络请求
#pragma mark 添加厅信息
- (void)AddBanquetHallInfo{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/AddBanquetHallInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"BanquetHallName"] = self.titleTF.text;
    params[@"MaxTableCount"] = self.countTF.text;
    params[@"FloorPrice"] = self.priceTF.text;
    params[@"HotelLogo"] = upXCString;//图片
    params[@"TypeQuestion"] = @"";//图片
    NSLog(@"%@",params);

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"添加宴会厅成功!"];
            [self.navigationController popViewControllerAnimated:YES];
            
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
