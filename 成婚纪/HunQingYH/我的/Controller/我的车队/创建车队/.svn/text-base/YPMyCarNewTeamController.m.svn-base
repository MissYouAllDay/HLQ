//
//  YPMyCarNewTeamController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/15.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMyCarNewTeamController.h"
#import "YPNewCarTeamIconCell.h"
#import "YPNewCarTeamInputCell.h"
#import "UITextView+WZB.h"
#import <fmdb/FMDB.h>
#import "CJAreaPicker.h"//地址选择
#import "YPSelectNormalCell.h"

@interface YPMyCarNewTeamController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,ZLPhotoPickerViewControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate,UITextViewDelegate,CJAreaPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *iconImgs;
@property (nonatomic, copy) NSString *iconImgID;

@property (nonatomic, strong) UITextField *titleTF;
//简介
@property (nonatomic, strong) UITextView *inputView;

/***********************************地址选择*****************************************/
/**经纬度坐标*/
@property (strong, nonatomic) NSString *coordinates;
/**缓存城市*/
@property (strong, nonatomic) NSString *cityInfo;
/**缓存城市parentid*/
@property (assign, nonatomic) NSInteger  parentID;
/**地区ID*/
@property (strong, nonatomic) NSString *areaid;
/***********************************地址选择*****************************************/

@end

@implementation YPMyCarNewTeamController{
    UIView *_navView;
    CGFloat _cellHeight;
    FMDatabase *dataBase;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;

    //6-5 修改 只首页第一次进入迁移一次
//    [self moveToDBFile];//迁移数据库
//    [self selectDataBase];
    
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
    titleLab.text = @"创建车队";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        YPNewCarTeamIconCell *cell = [YPNewCarTeamIconCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.addIconBtn addTarget:self action:@selector(addIconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (self.iconImgs.count > 0) {
            [cell.addIconBtn setImage:self.iconImgs[0] forState:UIControlStateNormal];
            cell.addIconBtn.selected = YES;
        }else{
            [cell.addIconBtn setImage:[UIImage imageNamed:@"addImg"] forState:UIControlStateNormal];
            cell.addIconBtn.selected = NO;
        }
        return cell;
        
    }else if(indexPath.row == 1){
        
        YPNewCarTeamInputCell *cell = [YPNewCarTeamInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLabel.text = @"队名";
        cell.inputTF.placeholder = @"不超过15个字";
        self.titleTF = cell.inputTF;
        
        return cell;
        
    }else if (indexPath.row == 2){
        
        YPSelectNormalCell *cell = [YPSelectNormalCell cellWithTableView:tableView];
        cell.titleLabel.text = @"地区";
        cell.titleLabel.textColor = BlackColor;
        cell.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        if (self.cityInfo.length > 0 && self.areaid.length > 0) {
            cell.descLabel.text = self.cityInfo;
            cell.descLabel.textColor = BlackColor;
        }
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = CHJ_bgColor;
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(70);
            make.right.bottom.mas_equalTo(cell);
            make.height.mas_equalTo(1);
        }];
        return cell;
        
    }else if (indexPath.row == 3) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"简介";
//        [label setFont:[UIFont fontWithName:@"System-Semibold" size:17]];
        [label setFont:[UIFont boldSystemFontOfSize:17]];
        
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView).mas_offset(15);
            make.centerY.mas_equalTo(cell.contentView);
        }];
        
        
        [cell.contentView addSubview:self.inputView];
        [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(cell.contentView).mas_offset(70);
            make.right.mas_equalTo(cell.contentView).mas_offset(-15);
        }];
        
        __weak typeof (self) weakSelf = self;
        
        // 最大高度为100，监听高度改变的block
        [self.inputView wzb_autoHeightWithMaxHeight:100 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
            [weakSelf.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(currentTextViewHeight);
            }];
            
            _cellHeight = currentTextViewHeight;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 113;
        
    }else{
        
        if (indexPath.row == 3) {
            if (_cellHeight == 0) {
                return 50;
            }else{
                return _cellHeight;
            }
            
        }else{
            
            return 45;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 100;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
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
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
        picker.delegate = self;
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
        [self presentViewController:navc animated:YES completion:nil];
    }
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sureBtnClick{
    NSLog(@"sureBtnClick");

    if (self.titleTF.text.length == 0) {
        
        [EasyShowTextView showText:@"请输入标题"];
    }else if (self.iconImgs.count == 0){
        
        [EasyShowTextView showText:@"请选择图片"];
    }else if (self.cityInfo.length == 0 || self.areaid.length == 0){
        
        [EasyShowTextView showText:@"请选择地区"];
    }else if (self.inputView.text.length == 0){
        
        [EasyShowTextView showText:@"请输入简介"];
    }else{
        [self uploadIconImgRequest];
    }
}

- (void)addIconBtnClick:(UIButton *)sender{
    
    if (sender.selected) {
        //展示图片
        [self showPhotoBrowser:self.iconImgs];
    }else{
        //添加图片
        [self takePhoto:sender];
    }
    
}

#pragma mark - TakePhoto
- (void)takePhoto:(UIButton *)sender {
    
    NSLog(@"takephoto");
    UIActionSheet *actionsheet =[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    actionsheet.tag = sender.tag;
    [actionsheet showInView:self.view];
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        [self openCameraWithTag:actionSheet.tag];
    }else if (buttonIndex==1)
    {
        [self LocalPhotoWithTag:actionSheet.tag];
    }
    
}

- (void)openCameraWithTag:(NSInteger)tag{
    ZLCameraViewController *cameraVc = [[ZLCameraViewController alloc] init];
    
    // 拍照最多个数
    cameraVc.maxCount = 1-self.iconImgs.count;
    
    cameraVc.callback = ^(NSArray *cameras){
        
        //如果之前存有照片 清空
        if (self.iconImgs.count > 0) {
            [self.iconImgs removeAllObjects];
        }
        
        for (int i=0; i<cameras.count; i++) {
            ZLCamera *camera  =[cameras objectAtIndex:i];
            UIImage *image = camera.thumbImage;
            [self.iconImgs addObject:image];
            if (self.iconImgs.count > 1) {
                Alertmsg(@"不能超过1张", nil);
                break;
            }
            [self.tableView reloadData];
        }
    };
    
    [cameraVc showPickerVc:self];
}

- (void)LocalPhotoWithTag:(NSInteger)tag{
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.maxCount = 1 - self.iconImgs.count;
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
        [self.iconImgs addObject:image];
        
        //获取图片的ID
//        self.iconImgID = [Upload getUUID];
        
        if (self.iconImgs.count > 1) {
            Alertmsg(@"不能超过1张", nil);
            break;
        }
    }
    [self.tableView reloadData];
}

//图片浏览器
-(void)showPhotoBrowser:(NSMutableArray *)imgsMarr{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    // 图片游览器
    
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 淡入淡出效果
    // pickerBrowser.status = UIViewAnimationAnimationStatusFade;
    // 数据源/delegate
    pickerBrowser.editing = YES;
    NSMutableArray *photos = [[NSMutableArray alloc]initWithCapacity:imgsMarr.count];
    for (int i = 0; i < imgsMarr.count; i ++) {
        ZLPhotoPickerBrowserPhoto *photo=[ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:[imgsMarr objectAtIndex:i]];
        [photos addObject:photo];
        
    }
    pickerBrowser.photos = photos;
    // 能够删除
    pickerBrowser.delegate = self;
    // 当前选中的值
    pickerBrowser.currentIndexPath = indexPath;
    // 展示控制器
    [pickerBrowser showPickerVc:self];
}

- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"走方法");
    if (self.iconImgs.count >indexPath.row) {
        [self.iconImgs removeObjectAtIndex:indexPath.row];
    }
    [self.tableView reloadData];
}

#pragma mark - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID = parentID;

    NSLog(@"缓存城市设置为%@",address);
    self.cityInfo = address;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self selectDataBase];
    
}

- (void)areaPicker:(CJAreaPicker *)picker didClickCancleWithAddress:(NSString *)address parentID:(NSInteger)parentID{
    
}

#pragma mark --------数据库-------
-(void)moveToDBFile
{       //1、获得数据库文件在工程中的路径——源路径。
    NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"region"ofType:@"db"];
    
    NSLog(@"sourcesPath %@",sourcesPath);
    //2、获得沙盒中Document文件夹的路径——目的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSLog(@"documentPath %@",documentPath);
    
    NSString *desPath = [documentPath stringByAppendingPathComponent:@"region.db"];
    //3、通过NSFileManager类，将工程中的数据库文件复制到沙盒中。
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:desPath])
    {
        NSError *error ;
        if ([fileManager copyItemAtPath:sourcesPath toPath:desPath error:&error]) {
            NSLog(@"数据库移动成功");
        }
        else {
            NSLog(@"数据库移动失败");
        }
    }
    
}
//打开数据库
- (void)openDataBase{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"region.db"];
    
    dataBase =[[FMDatabase alloc]initWithPath:dbFilePath];
    BOOL ret = [dataBase open];
    if (ret) {
        NSLog(@"打开数据库成功");
        
    }else{
        NSLog(@"打开数据库成功");
    }
    
}
//关闭数据库
- (void)closeDataBase{
    BOOL ret = [dataBase close];
    if (ret) {
        NSLog(@"关闭数据库成功");
    }else{
        NSLog(@"关闭数据库失败");
    }
}
//查询数据库
-(void)selectDataBase{
    [self openDataBase];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    NSLog(@"缓存城市为%@",huanCun);
    NSLog(@"_cityInfo*$#$#$##$$%@",self.cityInfo);
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'AND PARENT_ID =%ld",self.cityInfo,(long)_parentID];
    FMResultSet *set =[dataBase executeQuery:selectSql];
    while ([set next]) {
        int ID = [set intForColumn:@"REGION_ID"];
        NSLog(@"==*****%d",ID);
        NSString *idStr = [NSString stringWithFormat:@"%d",ID];
        //6-5
//        [[NSUserDefaults standardUserDefaults]setObject:idStr forKey:@"areaid"];
//        NSLog(@"areaid ------- %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"areaid"]);
        self.areaid =idStr;
    }
    [self closeDataBase];
    
    [self.tableView reloadData];
    NSLog(@"~~~~~~ huanCun:%@ cityInfo:%@ areaid:%@ ",huanCun,self.cityInfo,self.areaid);
    
}

#pragma mark - 懒加载
- (NSMutableArray *)iconImgs{
    if (!_iconImgs) {
        _iconImgs = [NSMutableArray array];
    }
    return _iconImgs;
}

#pragma mark - getter
- (UITextView *)inputView{
    if (!_inputView) {
        _inputView = [[UITextView alloc]init];
        // 设置文本框占位图文字
        _inputView.wzb_placeholder = @"请输入车队的简要介绍,不超过150字";
        _inputView.wzb_placeholderColor = LightGrayColor;
        _inputView.font = kNormalFont;
        _inputView.wzb_minHeight = 40;
        _inputView.delegate = self;
    }
    return _inputView;
}

-(NSString *)areaid{
    if (!_areaid) {
        self.areaid =[[NSUserDefaults standardUserDefaults]objectForKey:@"region_New"];
    }
    return _areaid;
}
-(NSString *)cityInfo{
    if (!_cityInfo) {
        self.cityInfo = @"黄岛区";
    }
    return _cityInfo;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 150) {
        textView.textColor = [UIColor redColor];
        Alertmsg(@"您输入的字数超出已限制", nil)
    }else{
        textView.textColor = BlackColor;
    }
}

#pragma mark - 网络请求
#pragma mark - 上传图片
-(void)uploadIconImgRequest{
    
    [EasyShowLodingView showLoding];
    
    NSMutableDictionary *fmdict = [NSMutableDictionary dictionaryWithCapacity:3];
    [fmdict setValue:@"2" forKey:@"os"];//0惠约、1汇码、2婚庆、3减肥
    [fmdict setValue:@"0" forKey:@"ot"];//0用户图、1公司、2平台
    [fmdict setValue:UserId_New forKey:@"oi"];
    [fmdict setValue:@"2" forKey:@"t"];//用户：1认证相关、2功能相关、3其他
    
    BAImageDataEntity *imageEntity = [BAImageDataEntity new];
    imageEntity.urlString = @"http://121.42.156.151:93/FileStorage.aspx";
    imageEntity.needCache = NO;
    imageEntity.parameters = fmdict;
    imageEntity.imageArray = self.iconImgs;
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0;
    imageEntity.fileNames = nil;
    
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        NSLog(@"创建车队 返回：====%@",response);
        
        [self AddSupplierInfoWithIconID:[response objectForKey:@"Inform"]];
    } failurBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
     
//     ba_uploadImageWithUrlString:@"http://121.42.156.151:93/FileStorage.aspx" parameters:fmdict imageArray:self.iconImgs fileNames:nil imageType:@"png" imageScale:0 successBlock:^(id response) {
//        
//        
//        
//    } failurBlock:^(NSError *error) {
//        
//    } uploadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//        
//    }];
    
}

#pragma mark 创建车队
- (void)AddSupplierInfoWithIconID:(NSString *)iconID{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/AddSupplierInfo";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    params[@"Region"] = self.areaid;
    params[@"Adress"] = @"";
    params[@"Name"] = self.titleTF.text;
    params[@"BriefinTroduction"] = self.inputView.text;
    params[@"OwnedCompany"] = @"";
    params[@"Logo"] = iconID;//Logo
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"创建成功!"];
            
            //保存修改后的供应商ID
            [[NSUserDefaults standardUserDefaults] setObject:[object valueForKey:@"SupplierID"] forKey:@"SupplierID"];
            //车手创建车队后 职业改为 婚车
            [[NSUserDefaults standardUserDefaults] setObject:HunChe_New forKey:@"Profession"];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
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
