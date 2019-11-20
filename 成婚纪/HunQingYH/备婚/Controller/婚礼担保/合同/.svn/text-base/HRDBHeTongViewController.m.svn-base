//
//  HRDBHeTongViewController.m
//  HunQingYH
//
//  Created by Hiro on 2017/12/18.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRDBHeTongViewController.h"
#import "HRHTTopCell.h"//顶部甲乙方部分
#import "HRTitleOneLineCell.h"//单行不用折叠标题cell
#import "HRHTBottomCell.h"//底部签字及日期部分
@interface HRDBHeTongViewController () <YUFoldingTableViewDelegate>

@property (nonatomic, weak) YUFoldingTableView *foldingTableView;


@end

@implementation HRDBHeTongViewController{
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

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNav];
    [self setupUI];
    
}

#pragma mark - UI
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
    titleLab.text = @"担保合同";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
        self.view.backgroundColor = CHJ_bgColor;
}

- (void)setupUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
//    CGFloat topHeight = [[UIApplication sharedApplication] statusBarFrame].size.height + 44;
    YUFoldingTableView *foldingTableView = [[YUFoldingTableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50)];
    _foldingTableView = foldingTableView;
    
    [self.view addSubview:foldingTableView];
    foldingTableView.foldingDelegate = self;
    

        foldingTableView.foldingState = YUFoldingSectionStateShow;
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_foldingTableView.frame), ScreenWidth, 50)];
    bottomView.backgroundColor =WhiteColor;
    [self.view addSubview:bottomView];
    UIButton *LingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [LingBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [LingBtn setTitle:@"打印" forState:UIControlStateNormal];
    LingBtn.frame =CGRectMake(10, 5, ScreenWidth-20, 40);
    LingBtn.clipsToBounds =YES;
    LingBtn.layer.cornerRadius =5;
    LingBtn.backgroundColor =RGB(251, 209, 56);
    [LingBtn addTarget:self action:@selector(lingClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:LingBtn];
}


#pragma mark - YUFoldingTableViewDelegate / required（必须实现的代理）
// 返回箭头的位置
- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    // 没有赋值，默认箭头在左
//    return self.arrowPosition ? :YUFoldingSectionHeaderArrowPositionLeft;
    return YUFoldingSectionHeaderArrowPositionRight;
}
- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return 25;
}
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section
{
    if (section ==0) {
        return 1;
    }else if (section ==1){
        return 1;
    }else if (section ==2){
        return 1;
    }else if (section ==3){
        return 1;
    }else if (section ==4){
        return 12;
    }else if (section ==5){
        return 6;
    }else if (section ==6){
        return 1;
    }else if (section ==7){
        return 3;
    }else if (section ==8){
        return 3;
    }else if (section ==9){
        return 9;
    }else if (section ==10){
        return 7;
    }else if (section ==11){
        return 3;
    }else if (section ==12){
        return 6;
    }else if (section ==13){
        return 1;
    }else if (section ==14){
        return 4;
    }else if (section ==15){
        return 5;
    }else if (section ==16){
        return 7;
    }else if (section ==17){
        return 4;
    }else if (section ==18){
        return 4;
    }else if (section ==19){
        return 3;
    }else if (section ==20){
        return 1;
    }
    else if (section ==21){
        return 1;
    }
    else if (section ==22){
        return 3;
    }else if (section ==23){
        return 1;
    }
    else{
          return 1;
    }
  
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section
{
    if (section ==0 ){
        return 0;
    }else if (section ==1){
        return 0;
    }else if (section ==2){
        return 0;
    }else if (section ==3){
        return 0;
    }else if (section ==4){
        return 50;
    }else if (section ==5){
        return 50;
    }else if (section ==6){
        return 0;
    }else if (section ==7){
        return 50;
    }else if (section ==8){
        return 50;
    }else if (section ==9){
        return 50;
    }else if (section ==10){
        return 50;
    }else if (section ==11){
        return 50;
    }else if (section ==12){
        return 50;
    }else if (section ==13){
        return 0;
    }else if (section ==14){
        return 50;
    }else if (section ==15){
        return 50;
    }else if (section ==16){
        return 50;
    }else if (section ==17){
        return 50;
    }else if (section ==18){
        return 50;
    }else if (section ==19){
        return 50;
    }else if (section ==20){
        return 50;
    }else if (section ==21){
        return 50;
    }else if (section ==22){
        return 50;
    }else if (section ==23){
        return 50;
    }
    
    else{
         return 0;
    }
  
}
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return nil;
        
    }else if (section ==1){
        return nil;
    }else if (section ==2){
        return nil;
    }else if (section ==3){
        return nil;
    }
    else if (section ==4){
        return @"四、婚礼服务项目";
    } else if (section ==5){
        return @"五、服务费用及支付";
    }else if (section ==6){
        return nil;
    }else if (section ==7){
        return @"    1、策划服务";
    }else if (section ==8){
        return @"    2、主持服务";
    }else if (section ==9){
        return @"    3、摄像服务";
    }else if (section ==10){
        return @"    4、摄影服务 ";
    }else if (section ==11){
        return @"    5、化妆服务 ";
    }else if (section ==12){
        return @"    6、推荐婚车服务 ";
    }else if (section ==13){
        return nil;
    }else if (section ==14){
        return @"    总则：";
    }else if (section ==15){
        return @"    策划服务：";
    }else if (section ==16){
        return @"    摄像、摄影服务：";
    }else if (section ==17){
        return @"    化妆服务：";
    }else if (section ==18){
        return @"    婚车服务：";
    }else if (section ==19){
        return @"八、合同的解除";
    }else if (section ==20){
        return @"九、不可抗力";
    }else if (section ==21){
        return @"十、合同签订地的确认";
    }else if (section ==22){
        return @"十一、合同争议的解决办法";
    }
    else if (section ==23) {
        return @"十二、其他约定事项:  ";
    }else{
        return nil;
    }
    
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 120;
    }else if (indexPath.section ==1){
        return [self getHeighWithTitle:@"一、服务内容：甲方委托乙方为新郎：_____和新娘：_____的婚礼仪式提供相关服务。" font: kFont(17) width:  ScreenWidth-10]+20;
    }else if (indexPath.section ==2){
        return [self getHeighWithTitle:@"二、婚礼仪式开始时间：____年___月___日___时___分。" font: kFont(17) width:  ScreenWidth-10]+20;
    }else if (indexPath.section ==3){
        return [self getHeighWithTitle:@"三、婚礼仪式举行地点：____市____区（县）_____路（街）___号 ____酒店 。" font: kFont(17) width:  ScreenWidth-10]+20;
    }else if (indexPath.section==4){
        if (indexPath.row==0) {
             return [self getHeighWithTitle:@"1、主持：收费_____元 "font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==1){
            return [self getHeighWithTitle:@"2、摄像：收费_____元"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==2){
             return [self getHeighWithTitle:@"3、摄影：收费_____元"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==3){
              return [self getHeighWithTitle:@"4、化妆及礼服：收费_____元"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==4){
            return [self getHeighWithTitle:@"5、策划及布场：收费_____元"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==5){
             return [self getHeighWithTitle:@"6、音响：收费_____元"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==6){
             return [self getHeighWithTitle:@"7、鲜花系列：  收费_____元" font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==7){
            return [self getHeighWithTitle:@"8、庆典乐队：  收费_____元"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==8){
             return [self getHeighWithTitle:@"9、代租车辆：  收费_____元"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==9){
            return [self getHeighWithTitle:@"10、其他项目 ：收费_____元，备注："font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==10){
            
            return [self getHeighWithTitle:@"           以上合计为______元。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else {
            
            return [self getHeighWithTitle:@"    本合同签订后双方约定新增加或取消服务项目的，相应费用应计入服务费用总额或从服务费用总额进行增加或扣除。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
     
        


        
    }
    else if (indexPath.section==5){
        if (indexPath.row ==0) {
             return [self getHeighWithTitle:@"1、本合同生效后即日内，甲方应按总费用_____元（大写）的30% 即元支付给乙方作为预款。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==1){
            return [self getHeighWithTitle:@"2、策划方案经确认（含签字、微信、电话等不同方式）后，甲方应向乙方支付费用总额的60%，即_____元。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==2){
            return [self getHeighWithTitle:@"3、乙方代为租赁车辆的，租车费用应在合同生效即日内支付全款_____元。"font: kFont(13) width:  ScreenWidth-10]+20;
        } else if (indexPath.row==3){
            return [self getHeighWithTitle:@"4、10%的余款_____元，应在婚礼仪式举行之前付清。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==4){
              return [self getHeighWithTitle:@"5、增加服务项目的，服务费用应即时结清。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else{
            return [self getHeighWithTitle:@"6、乙方收到钱款，应即时向甲方开具收款凭证。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
    }
    else if (indexPath.section ==6){
        return [self getHeighWithTitle:@"六、双方主要权利义务  \n 　　甲方应积极配合乙方完成合同约定的各项服务；乙方提供的各项服务以及服务中所使用的各种产品，均应符合国家有关规定或行业有关规范确定的标准。" font: kFont(17) width:  ScreenWidth-10]+40;
    }
    else if (indexPath.section==7){
        if (indexPath.row ==0) {
            return [self getHeighWithTitle:@"策划师：______联系电话：______"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==1){
            return [self getHeighWithTitle:@"（1）策划方案为乙方智力成果，仅供甲方在本合同约定范围内使用。甲方不得擅自将策划方案用于合同约定以外的其他用途或提交给第三方使用。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else{
            return [self getHeighWithTitle:@"（2）乙方应于_____年_____月_____日前向甲方提交策划方案，策划方案经验收合格，甲方应予以确认（含签字、微信、电话等不同方式）。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
    }
    else if (indexPath.section==8){
        if (indexPath.row ==0) {
            return [self getHeighWithTitle:@"主持人姓名：______技能：______到婚礼现场的时间：______预计结束时间：______是否佩带助理：______"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==1){
            return [self getHeighWithTitle:@"（1）乙方应根据甲方需求提供合格主持人供甲方选择。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else{
            return [self getHeighWithTitle:@"（2）婚礼仪式举行当日，甲方指定的主持人由于生病等不可抗拒的原因无法亲自主持的，乙方应及时提供同级别以上的主持人代为提供服务。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
    }
    else if (indexPath.section==9){
        if (indexPath.row==0) {
            return [self getHeighWithTitle:@"团队名称：______具体人的姓名：______到达婚礼时间：______预计结束时间：______所用器材品牌和型号：______预计在______年_____月_____日制作出婚礼实况片，为甲方提供普通话版DVD光盘2碟"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==1){
            return [self getHeighWithTitle:@"（1）甲方变更拍摄时间应提前1日书面通知乙方。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==2){
            return [self getHeighWithTitle:@"（2）甲方应于拍摄前提供活动流程并注明必拍场景。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==3){
            return [self getHeighWithTitle:@"（3）乙方应为婚礼仪式配备合格的摄像、摄影师和设备。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==4){
            return [self getHeighWithTitle:@"（4）除署名权外，乙方对于摄影、摄像作品著作权中的其他权利，只有在取得甲方书面同意后方可行使。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==5){
            return [self getHeighWithTitle:@"（5）乙方留有原始图像文件或复制件的三个月，妥善保管，并不得提供给第三方。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==6){
            return [self getHeighWithTitle:@"（6）乙方应保守因签订和履行本合同而获悉的甲方隐私。" font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==7){
            return [self getHeighWithTitle:@"（7）外地拍摄业务需要在原有服务基础上加收30%费用（以及车费，过路费等等），具体视情况而定。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        
        else {
            
            return [self getHeighWithTitle:@"（8）甲方应保证摄像师的人生安全，拍摄结束后送摄像师回到市区"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        
        
        
        
        
    }
    else if (indexPath.section==10){
        if (indexPath.row==0) {
            return [self getHeighWithTitle:@"团队名称：______具体人的姓名：______ 到达婚礼时间：______预计结束时间：______ 所用器材品牌和型号：______预计在______年_____月_____日制作出婚礼实况片，至少提供  张照片"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==1){
            return [self getHeighWithTitle:@"（1）甲方变更拍摄时间应提前1日书面通知乙方。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==2){
            return [self getHeighWithTitle:@"（2）甲方应于拍摄前提供活动流程并注明必拍场景。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==3){
            return [self getHeighWithTitle:@"（3）乙方应为婚礼仪式配备合格的摄像、摄影师和设备。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==4){
            return [self getHeighWithTitle:@"（4）除署名权外，乙方对于摄影、摄像作品著作权中的其他权利，只有在取得甲方书面同意后方可行使。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==5){
            return [self getHeighWithTitle:@"（5）乙方留有原始图像文件或复制件的，应妥善保管，并不得提供给第三方。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else {
            return [self getHeighWithTitle:@"（6）乙方应保守因签订和履行本合同而获悉的甲方隐私。" font: kFont(13) width:  ScreenWidth-10]+20;
        }
        
        
    }
    else if (indexPath.section==11){
        if (indexPath.row ==0) {
            return [self getHeighWithTitle:@"化妆师姓名：______试妆时间地点：______婚礼当天到达时间：______婚礼当天到达地点：______预计结束时间：______婚礼当天做妆容造型次数：______造型配套化妆品和饰品：______是否包含试妆、妈妈妆、伴娘妆及花童的妆：______"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==1){
            return [self getHeighWithTitle:@"（1）乙方应根据甲方需求提供试妆服务，以确定化妆师的具体人选和测试被化妆人员有无过敏反应；因化妆产生过敏反应的，应允许调换化妆品，如皮肤仍无法适应的，甲方可取消本项服务；对乙方提供的化妆师均不满意的，甲方也可取消本项服务。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else{
            return [self getHeighWithTitle:@"（2）化妆师人选及使用的化妆品一经确定，双方均不得随意更换。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
    }
    
    else if (indexPath.section==12){
        if (indexPath.row ==0) {
            return [self getHeighWithTitle:@"头车品牌及型号：_____数量：______颜色：______"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==1){
            return [self getHeighWithTitle:@"随车品牌及型号：______数量：______ 颜色：______婚车到达时间：______"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==2){
            return [self getHeighWithTitle:@"（1）乙方应根据甲方需求，为其推荐符合汽车运营管理规定的汽车租赁企业提供婚车租赁服务。"font: kFont(13) width:  ScreenWidth-10]+20;
        } else if (indexPath.row==3){
            return [self getHeighWithTitle:@"（2）甲方应自行与乙方推荐的汽车租赁企业洽谈签约，婚庆公司仅负责联络推荐"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==4){
            return [self getHeighWithTitle:@"（3）婚车租赁费是甲方所应支付的婚车租用费用，其中包含车辆使用费、燃油费、驾驶员服务费，停车费、过桥费等其他费用由甲方另行支付。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else{
            return [self getHeighWithTitle:@"（4）甲方不得要求婚车驾驶员违反交通法规。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
    }
    else if (indexPath.section ==13){
        return [self getHeighWithTitle:@"    7、其他服务约定：______" font: kFont(17) width:  ScreenWidth-10]+20;
    }
    else if (indexPath.section==14){
        if (indexPath.row ==0) {
            return [self getHeighWithTitle:@"1、因自身原因，任何一方于婚礼仪式14日之前（不含14日）要求取消具体服务项目的，应以该项目服务费的30%作为违约金；于婚礼仪式7日之前（不含7日）要求取消具体服务项目的，应以该项目服务费的70%作为违约金；于婚礼仪式7日之内（含7日）要求取消具体服务项目的，应以该项目服务费的100%作为违约金。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if(indexPath.row==1) {
            return [self getHeighWithTitle:@"2、除本合同另有约定以外，由于甲方原因导致合同不能按照约定履行的，由甲方自行承担相应责任，并应支付乙方实际支出的费用；由于乙方原因导致提供的服务不符合约定要求的，乙方应退还该项目服务费，并按该具体项目服务费的10%支付违约金。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if(indexPath.row==2) {
            return [self getHeighWithTitle:@"3、由于一方原因给另一方或第三方造成人身伤害或财产损失的，责任方应承担赔偿责任。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else {
            return [self getHeighWithTitle:@"4、新郎或新娘自定的项目，即：非婚庆公司提供的，不受本合同约束，有新人自行承担责任。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        
        
    }
    else if (indexPath.section==15){
        if (indexPath.row ==0) {
            return [self getHeighWithTitle:@"1、甲方提出单方解除合同的，乙方应采取适当措施防止损失扩大，并有权要求甲方在7日内按总则条款支付违约金，同时甲方应当支付乙方已实际支出的费用。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==1){
            return [self getHeighWithTitle:@"2、乙方提出单方解除合同的，甲方有权要求乙方7日内按总则条款支付违约金，并有权要求乙方同时退还已收取的所有款项。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==2){
            return [self getHeighWithTitle:@"3、由于乙方的原因，导致甲方庆典的有关资料灭失或者毁损时，乙方除尽力予以补救外，应在7日内按照该具体服务项目服务费的三倍向甲方赔偿。"font: kFont(13) width:  ScreenWidth-10]+20;
        } else if (indexPath.row==3){
            return [self getHeighWithTitle:@"4、乙方提供的服务不符合约定要求的，乙方应当在7日内按该具体项目服务费的10%支付违约金；因乙方提供的服务给甲方造成人身、财产损害的，由乙方承担损害赔偿责任。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else{
            return [self getHeighWithTitle:@"5、发生不可抗力致使本合同无法履行时，双方互不承担违约责任。但是，因一方发生不可抗力致使本合同不能继续履行时，应向另一方支付已经实际发生的费用。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
    }
    
    else if (indexPath.section==16){
        if (indexPath.row==0) {
            return [self getHeighWithTitle:@"1、若甲方已确认的订单未执行状态时要求取消订单，需向乙方支付摄像师劳务费作为损失补偿；"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==1){
            return [self getHeighWithTitle:@"2、若乙方拍摄或设备出现故障（严重马赛克、黑屏、无声音、影像丢失等），对甲方造成的损失按三倍赔偿由乙方承担；"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==2){
            return [self getHeighWithTitle:@"3、由于任一方的原因，给对方或者第三方造成人身、财产损失的，由责任方承担损害赔偿责任。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==3){
            return [self getHeighWithTitle:@"4、甲方需对拍摄现场进行组织、安排、明确具体拍摄要求，配合乙方现场拍摄，如因组织安排不力而影响拍摄效果，均由甲方承担责任。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==4){
            return [self getHeighWithTitle:@"5、摄影、摄像师无法按约定时间提供摄影、摄像服务的，经甲方同意，乙方应及时安排职业等级或技术水平相当的其他摄影、摄像师；乙方未做出替换安排或甲方不同意替换安排的，乙方应按该项服务费用的3倍支付违约金。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        else if (indexPath.row==5){
            return [self getHeighWithTitle:@"6、由于乙方原因导致照片、影像全部或部分灭失的，乙方应退还相应服务费用，并按相应服务费用的3倍支付违约金。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
        
        else {
            
            return [self getHeighWithTitle:@"7、乙方交付的拍摄成品质量不符合约定要求的，应按该项目费用的一倍的标准支付违约金。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
    
    }

    else if (indexPath.section==17){
        if (indexPath.row ==0) {
            return [self getHeighWithTitle:@"1、若甲方已确认的订单未执行状态时要求取消订单，需向乙方支付化妆师劳务费作为损失补偿；"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==1){
            return [self getHeighWithTitle:@"2、若甲方未告知化妆师有过敏反应，甲方承担责任。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==2){
            return [self getHeighWithTitle:@"3、化妆师无法按约定时间提供化妆服务的，经甲方同意，乙方应及时安排职业等级或技术水平相当的其他化妆师；乙方未做出替换安排或甲方不同意替换安排的，乙方应按该项服务费用的3倍支付违约金。"font: kFont(13) width:  ScreenWidth-10]+20;
        } else{
            return [self getHeighWithTitle:@"4、因化妆属于即时可以看到效果，所以一经确认即为双方合同成立。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
    }
    else if (indexPath.section==18){
        if (indexPath.row ==0) {
            return [self getHeighWithTitle:@"1、乙方代租车辆的，如无法按约定时间提供服务，乙方除应及时通知甲方，并应当及时为甲方提供同级别车辆替代，如替代车辆级别低于合同约定级别的，应按约定租车款（每辆）的10%向甲方赔偿；如不能提供任何替代车辆的，应按约定租车款（每辆）的二倍向甲方赔偿。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==1){
            return [self getHeighWithTitle:@"2、实际婚车数量少于约定的，乙方应退还代租服务费和相应的租赁费用，并支付相应租赁费用的10%作为违约金。"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==2){
            return [self getHeighWithTitle:@"3、婚车未在约定时间内到达起始地点超过30分钟以上的，乙方应支付相应租赁费用的10%作为违约金。若因婚礼当天堵车事宜，不作为违约责任"font: kFont(13) width:  ScreenWidth-10]+20;
        }else{
            return [self getHeighWithTitle:@"4、由于甲方原因导致婚车毁损或违反交通法规的，车辆维修费、罚款及其他相关费用由甲方承担。\n新人自定人员及服务\n新人自定服务的含义是指在整个婚礼的过程中部分所需要的人员（如主持，摄像，摄影，化妆，婚车等等）和其他的服务是有新人一方自己寻找确认的第三方，跟婚庆公司无关，婚庆公司不承担任何责任。"font: kFont(13) width:  ScreenWidth-10]+40;
        }
    }
    
    else if (indexPath.section==19){
        if (indexPath.row ==0) {
            return [self getHeighWithTitle:@"1、甲、乙双方可协商一致解除本合同；"font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==1){
            return [self getHeighWithTitle:@"2、一方有下列情形之一的，另一方有权单方解除合同并要求其赔偿损失：\n（1）一方明确表示或者以自己的行为表明不履行全部或部分约定义务的；\n（2）甲方迟延支付全部或部分服务费用，经乙方催告后3日内仍未支付的；\n（3）乙方未经甲方同意，擅自改变服务内容、降低服务标准或增加服务费用，经甲方催告后仍未改正的； "font: kFont(13) width:  ScreenWidth-10]+40;
        }else{
            return [self getHeighWithTitle:@"3、在婚礼仪式举行前，一方因上述以外的原因提出单方解除合同的，另一方应采取适当措施防止损失扩大，并有权要求解约方在7日内按服务费用总额的30%支付违约金。已支付定金的，也可选择适用定金规则：甲方违反约定解除合同的，无权要求返还定金；乙方违反约定解除合同的，应双倍返还定金。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
    }
    
    else if (indexPath.section==20){
      
        return [self getHeighWithTitle:@"任何一方当事人因不可抗力不能履行合同的，根据不可抗力的影响，可以部分或者全部免除责任，但应及时通知另一方并在合理期限内提供有关证明。"font: kFont(13) width:  ScreenWidth-10]+20;
        
    }
    else if (indexPath.section==21){
      
            return [self getHeighWithTitle:@"   本合同以婚宴举办所在地的酒店作为本合同的签订地"font: kFont(13) width:  ScreenWidth-10]+20;
        
    }
    else if (indexPath.section==22){
        if (indexPath.row ==0) {
            return [self getHeighWithTitle:@"　本合同项下发生的争议，由双方协商解决或申请调解解决，协商、调解解决不成的，可选择以下第______种方式解决："font: kFont(13) width:  ScreenWidth-10]+20;
        }else if (indexPath.row==1){
            return [self getHeighWithTitle:@"（一）向______人民法院提起诉讼；"font: kFont(13) width:  ScreenWidth-10]+20;
        }else{
            return [self getHeighWithTitle:@"（二）向 ______仲裁委员会申请仲裁。"font: kFont(13) width:  ScreenWidth-10]+20;
        }
    }
    else if (indexPath.section==23){
     
        return [self getHeighWithTitle:@"　　本合同经双方签字、盖章后生效。双方对合同内容的变更或补充应采用书面形式，作为本合同的附件。附件与本合同具有同等的法律效力。"font: kFont(13) width:  ScreenWidth-10]+20;
        
    }
  
    else{
        return 250;
    }
    
}

- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0){
        HRHTTopCell *cell = [HRHTTopCell cellWithTableView:yuTableView];
        return cell;
}else if (indexPath.section ==1)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.text =@" 一、服务内容：甲方委托乙方为新郎：_____和新娘：_____的婚礼仪式提供相关服务。";
    return cell;
}else if (indexPath.section ==2)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.text =@"二、婚礼仪式开始时间：____年___月___日___时___分。" ;
    return cell;
}else if (indexPath.section ==3)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.text =@"三、婚礼仪式举行地点：____市____区（县）_____路（街）___号 ____酒店 。";
    return cell;
}else if (indexPath.section ==4)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
    switch (indexPath.row) {
        case 0:
            cell.textLab.text =@"1、主持：收费_____元 ";
            break;
        case 1:
            cell.textLab.text =@"2、摄像：收费_____元";
            break;
        case 2:
            cell.textLab.text =@"3、摄影：收费_____元";
            break;
        case 3:
            cell.textLab.text =@"4、化妆及礼服：收费_____元";
            break;
        case 4:
            cell.textLab.text =@"5、策划及布场：收费_____元";
            break;
        case 5:
            cell.textLab.text =@"6、音响：收费_____元";
            break;
        case 6:
            cell.textLab.text =@"7、鲜花系列：  收费_____元";
            break;
        case 7:
            cell.textLab.text =@"8、庆典乐队：  收费_____元";
            break;
        case 8:
            cell.textLab.text =@"9、代租车辆：  收费_____元";
            break;
        case 9:
            cell.textLab.text =@"10、其他项目 ：收费______ 元，备注：";
            break;
        case 10:
            cell.textLab.text =@"           以上合计为______元。";
            break;
        case 11:
            cell.textLab.text =@"    本合同签订后双方约定新增加或取消服务项目的，相应费用应计入服务费用总额或从服务费用总额进行增加或扣除。";
            break;
        default:
            break;
    }
    return cell;
}
    
else if (indexPath.section ==5)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
    switch (indexPath.row) {
        case 0:
            cell.textLab.text =@"1、本合同生效后即日内，甲方应按总费用_____元（大写）的30% 即元支付给乙方作为预款。";
            break;
        case 1:
            cell.textLab.text =@"2、策划方案经确认（含签字、微信、电话等不同方式）后，甲方应向乙方支付费用总额的60%，即_____元。";
            break;
        case 2:
            cell.textLab.text =@"3、乙方代为租赁车辆的，租车费用应在合同生效即日内支付全款_____元。";
            break;
        case 3:
            cell.textLab.text =@"4、10%的余款_____元，应在婚礼仪式举行之前付清。";
            break;
        case 4:
            cell.textLab.text =@"5、增加服务项目的，服务费用应即时结清。";
            break;
        case 5:
            cell.textLab.text =@"6、乙方收到钱款，应即时向甲方开具收款凭证。";
            break;
        
        default:
            break;
    }
    return cell;
}
else if (indexPath.section ==6)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.text =@"六、双方主要权利义务  \n 　　甲方应积极配合乙方完成合同约定的各项服务；乙方提供的各项服务以及服务中所使用的各种产品，均应符合国家有关规定或行业有关规范确定的标准。";
    return cell;
}
else if (indexPath.section ==7)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
    switch (indexPath.row) {
        case 0:
            cell.textLab.text =@"策划师：______联系电话______ ";
            break;
        case 1:
            cell.textLab.text =@"（1）策划方案为乙方智力成果，仅供甲方在本合同约定范围内使用。甲方不得擅自将策划方案用于合同约定以外的其他用途或提交给第三方使用。";
            break;
        case 2:
            cell.textLab.text =@"（2）乙方应于______年______月______日前向甲方提交策划方案，策划方案经验收合格，甲方应予以确认（含签字、微信、电话等不同方式）。";
            break;
   
            
        default:
            break;
    }
    return cell;
}
else if (indexPath.section ==8)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
    switch (indexPath.row) {
        case 0:
            cell.textLab.text =@"主持人姓名：______ 技能：______到婚礼现场的时间：______预计结束时间：______是否佩带助理：______";
            break;
        case 1:
            cell.textLab.text =@"（1）乙方应根据甲方需求提供合格主持人供甲方选择。";
            break;
        case 2:
            cell.textLab.text =@"（2）婚礼仪式举行当日，甲方指定的主持人由于生病等不可抗拒的原因无法亲自主持的，乙方应及时提供同级别以上的主持人代为提供服务。";
            break;
            
            
        default:
            break;
    }
    return cell;
}
  
    

else if (indexPath.section ==9)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
    switch (indexPath.row) {
        case 0:
            cell.textLab.text =@"团队名称：______具体人的姓名：______到达婚礼时间：______ 预计结束时间：______所用器材品牌和型号：______预计在______年_____月_____日制作出婚礼实况片，为甲方提供普通话版DVD光盘2碟";
            break;
        case 1:
            cell.textLab.text =@"（1）甲方变更拍摄时间应提前1日书面通知乙方。";
            break;
        case 2:
            cell.textLab.text =@"（2）甲方应于拍摄前提供活动流程并注明必拍场景。";
            break;
        case 3:
            cell.textLab.text =@"（3）乙方应为婚礼仪式配备合格的摄像、摄影师和设备。";
            break;
        case 4:
            cell.textLab.text =@"（4）除署名权外，乙方对于摄影、摄像作品著作权中的其他权利，只有在取得甲方书面同意后方可行使。";
            break;
        case 5:
            cell.textLab.text =@"（5）乙方留有原始图像文件或复制件的三个月，妥善保管，并不得提供给第三方。";
            break;
        case 6:
            cell.textLab.text =@"（6）乙方应保守因签订和履行本合同而获悉的甲方隐私。";
            break;
        case 7:
            cell.textLab.text =@"（7）外地拍摄业务需要在原有服务基础上加收30%费用（以及车费，过路费等等），具体视情况而定。";
            break;
        case 8:
            cell.textLab.text =@"（8）甲方应保证摄像师的人生安全，拍摄结束后送摄像师回到市区";
            break;
       
        default:
            break;
    }
    return cell;
}
    
 
    else if (indexPath.section ==10)
    {
        HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
        cell.textLab.font =kFont(13);
        switch (indexPath.row) {
            case 0:
                cell.textLab.text =@"团队名称：______具体人的姓名：______到达婚礼时间：______ 预计结束时间：______所用器材品牌和型号：______预计在______年_____月_____日制作出婚礼实况片，至少提供______张照片";
                break;
            case 1:
                cell.textLab.text =@"（1）甲方变更拍摄时间应提前1日书面通知乙方。";
                break;
            case 2:
                cell.textLab.text =@"（2）甲方应于拍摄前提供活动流程并注明必拍场景。";
                break;
            case 3:
                cell.textLab.text =@"（3）乙方应为婚礼仪式配备合格的摄像、摄影师和设备。";
                break;
            case 4:
                cell.textLab.text =@"（4）除署名权外，乙方对于摄影、摄像作品著作权中的其他权利，只有在取得甲方书面同意后方可行使。";
                break;
            case 5:
                cell.textLab.text =@"（5）乙方留有原始图像文件或复制件的，应妥善保管，并不得提供给第三方。";
                break;
            case 6:
                cell.textLab.text =@"（6）乙方应保守因签订和履行本合同而获悉的甲方隐私。" ;
                break;
                
            default:
                break;
        }
        return cell;
    }

    else if (indexPath.section ==11)
    {
        HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
        cell.textLab.font =kFont(13);
        switch (indexPath.row) {
            case 0:
                cell.textLab.text =@"化妆师姓名：_____试妆时间地点：______婚礼当天到达时间：______婚礼当天到达地点：______预计结束时间：______婚礼当天做妆容造型次数：______造型配套化妆品和饰品：______是否包含试妆、妈妈妆、伴娘妆及花童的妆：______";
                break;
            case 1:
                cell.textLab.text =@"（1）乙方应根据甲方需求提供试妆服务，以确定化妆师的具体人选和测试被化妆人员有无过敏反应；因化妆产生过敏反应的，应允许调换化妆品，如皮肤仍无法适应的，甲方可取消本项服务；对乙方提供的化妆师均不满意的，甲方也可取消本项服务。";
                break;
            case 2:
                cell.textLab.text =@"（2）化妆师人选及使用的化妆品一经确定，双方均不得随意更换。";
                break;
                
                
            default:
                break;
        }
        return cell;
    }
   
    else if (indexPath.section ==12)
    {
        HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
        cell.textLab.font =kFont(13);
        switch (indexPath.row) {
            case 0:
                cell.textLab.text =@"头车品牌及型号：______数量：______颜色：______";
                break;
            case 1:
                cell.textLab.text =@"随车品牌及型号：______ 数量：______ 颜色：______婚车到达时间：______";
                break;
            case 2:
                cell.textLab.text =@"（1）乙方应根据甲方需求，为其推荐符合汽车运营管理规定的汽车租赁企业提供婚车租赁服务。";
                break;
            case 3:
                cell.textLab.text =@"（2）甲方应自行与乙方推荐的汽车租赁企业洽谈签约，婚庆公司仅负责联络推荐";
                break;
            case 4:
                cell.textLab.text =@"（3）婚车租赁费是甲方所应支付的婚车租用费用，其中包含车辆使用费、燃油费、驾驶员服务费，停车费、过桥费等其他费用由甲方另行支付。";
                break;
            case 5:
                cell.textLab.text =@"（4）甲方不得要求婚车驾驶员违反交通法规。";
                break;
                
            default:
                break;
        }
        return cell;
    }
    else if (indexPath.section ==13)
    {
        HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
        cell.textLab.text =@"    7、其他服务约定：______";
        return cell;
    }
    

else if (indexPath.section ==14)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
    switch (indexPath.row) {
        case 0:
            cell.textLab.text =@"1、因自身原因，任何一方于婚礼仪式14日之前（不含14日）要求取消具体服务项目的，应以该项目服务费的30%作为违约金；于婚礼仪式7日之前（不含7日）要求取消具体服务项目的，应以该项目服务费的70%作为违约金；于婚礼仪式7日之内（含7日）要求取消具体服务项目的，应以该项目服务费的100%作为违约金。";
            break;
        case 1:
            cell.textLab.text =@"2、除本合同另有约定以外，由于甲方原因导致合同不能按照约定履行的，由甲方自行承担相应责任，并应支付乙方实际支出的费用；由于乙方原因导致提供的服务不符合约定要求的，乙方应退还该项目服务费，并按该具体项目服务费的10%支付违约金。";
            break;
        case 2:
            cell.textLab.text =@"3、由于一方原因给另一方或第三方造成人身伤害或财产损失的，责任方应承担赔偿责任。";
            break;
        case 3:
            cell.textLab.text =@"4、新郎或新娘自定的项目，即：非婚庆公司提供的，不受本合同约束，有新人自行承担责任。";
            break;
            
        default:
            break;
    }
    return cell;
}
  

else if (indexPath.section ==15)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
    switch (indexPath.row) {
        case 0:
            cell.textLab.text =@"1、甲方提出单方解除合同的，乙方应采取适当措施防止损失扩大，并有权要求甲方在7日内按总则条款支付违约金，同时甲方应当支付乙方已实际支出的费用。";
            break;
        case 1:
            cell.textLab.text =@"2、乙方提出单方解除合同的，甲方有权要求乙方7日内按总则条款支付违约金，并有权要求乙方同时退还已收取的所有款项。";
            break;
        case 2:
            cell.textLab.text =@"3、由于乙方的原因，导致甲方庆典的有关资料灭失或者毁损时，乙方除尽力予以补救外，应在7日内按照该具体服务项目服务费的三倍向甲方赔偿。";
            break;
        case 3:
            cell.textLab.text =@"4、乙方提供的服务不符合约定要求的，乙方应当在7日内按该具体项目服务费的10%支付违约金；因乙方提供的服务给甲方造成人身、财产损害的，由乙方承担损害赔偿责任。";
            break;
        case 4:
            cell.textLab.text =@"5、发生不可抗力致使本合同无法履行时，双方互不承担违约责任。但是，因一方发生不可抗力致使本合同不能继续履行时，应向另一方支付已经实际发生的费用。";
            break;
     
            
        default:
            break;
    }
    return cell;
}
else if (indexPath.section ==16)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
    switch (indexPath.row) {
        case 0:
            cell.textLab.text =@"1、若甲方已确认的订单未执行状态时要求取消订单，需向乙方支付摄像师劳务费作为损失补偿；";
            break;
        case 1:
            cell.textLab.text =@"2、若乙方拍摄或设备出现故障（严重马赛克、黑屏、无声音、影像丢失等），对甲方造成的损失按三倍赔偿由乙方承担；";
            break;
        case 2:
            cell.textLab.text =@"3、由于任一方的原因，给对方或者第三方造成人身、财产损失的，由责任方承担损害赔偿责任。";
            break;
        case 3:
            cell.textLab.text =@"4、甲方需对拍摄现场进行组织、安排、明确具体拍摄要求，配合乙方现场拍摄，如因组织安排不力而影响拍摄效果，均由甲方承担责任。";
            break;
        case 4:
            cell.textLab.text =@"5、摄影、摄像师无法按约定时间提供摄影、摄像服务的，经甲方同意，乙方应及时安排职业等级或技术水平相当的其他摄影、摄像师；乙方未做出替换安排或甲方不同意替换安排的，乙方应按该项服务费用的3倍支付违约金。";
            break;
        case 5:
            cell.textLab.text =@"6、由于乙方原因导致照片、影像全部或部分灭失的，乙方应退还相应服务费用，并按相应服务费用的3倍支付违约金。";
            break;
        case 6:
            cell.textLab.text =@"7、乙方交付的拍摄成品质量不符合约定要求的，应按该项目费用的一倍的标准支付违约金。";
            break;
            
        default:
            break;
    }
    return cell;
}
else if (indexPath.section ==17)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
    switch (indexPath.row) {
        case 0:
            cell.textLab.text =@"1、若甲方已确认的订单未执行状态时要求取消订单，需向乙方支付化妆师劳务费作为损失补偿；";
            break;
        case 1:
            cell.textLab.text =@"2、若甲方未告知化妆师有过敏反应，甲方承担责任。";
            break;
        case 2:
            cell.textLab.text =@"3、化妆师无法按约定时间提供化妆服务的，经甲方同意，乙方应及时安排职业等级或技术水平相当的其他化妆师；乙方未做出替换安排或甲方不同意替换安排的，乙方应按该项服务费用的3倍支付违约金。";
            break;
        case 3:
            cell.textLab.text =@"4、因化妆属于即时可以看到效果，所以一经确认即为双方合同成立。";
            break;
       
            
        default:
            break;
    }
    return cell;
}
else if (indexPath.section ==18)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
    switch (indexPath.row) {
        case 0:
            cell.textLab.text =@"1、乙方代租车辆的，如无法按约定时间提供服务，乙方除应及时通知甲方，并应当及时为甲方提供同级别车辆替代，如替代车辆级别低于合同约定级别的，应按约定租车款（每辆）的10%向甲方赔偿；如不能提供任何替代车辆的，应按约定租车款（每辆）的二倍向甲方赔偿。";
            break;
        case 1:
            cell.textLab.text =@"2、实际婚车数量少于约定的，乙方应退还代租服务费和相应的租赁费用，并支付相应租赁费用的10%作为违约金。";
            break;
        case 2:
            cell.textLab.text =@"3、婚车未在约定时间内到达起始地点超过30分钟以上的，乙方应支付相应租赁费用的10%作为违约金。若因婚礼当天堵车事宜，不作为违约责任";
            break;
        case 3:
            cell.textLab.text =@"4、由于甲方原因导致婚车毁损或违反交通法规的，车辆维修费、罚款及其他相关费用由甲方承担。\n新人自定人员及服务\n新人自定服务的含义是指在整个婚礼的过程中部分所需要的人员（如主持，摄像，摄影，化妆，婚车等等）和其他的服务是有新人一方自己寻找确认的第三方，跟婚庆公司无关，婚庆公司不承担任何责任。";
            break;
     
            
        default:
            break;
    }
    return cell;
}
else if (indexPath.section ==19)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
    switch (indexPath.row) {
        case 0:
            cell.textLab.text =@"1、甲、乙双方可协商一致解除本合同；";
            break;
        case 1:
            cell.textLab.text =@"2、一方有下列情形之一的，另一方有权单方解除合同并要求其赔偿损失：\n（1）一方明确表示或者以自己的行为表明不履行全部或部分约定义务的；\n（2）甲方迟延支付全部或部分服务费用，经乙方催告后3日内仍未支付的；\n（3）乙方未经甲方同意，擅自改变服务内容、降低服务标准或增加服务费用，经甲方催告后仍未改正的； ";
            break;
        case 2:
            cell.textLab.text =@"3、婚车未在约定时间内到达起始地点超过30分钟以上的，乙方应支付相应租赁费用的10%作为违约金。若因婚礼当天堵车事宜，不作为违约责任";
            break;
        case 3:
            cell.textLab.text =@"3、在婚礼仪式举行前，一方因上述以外的原因提出单方解除合同的，另一方应采取适当措施防止损失扩大，并有权要求解约方在7日内按服务费用总额的30%支付违约金。已支付定金的，也可选择适用定金规则：甲方违反约定解除合同的，无权要求返还定金；乙方违反约定解除合同的，应双倍返还定金。";
            break;
            
            
        default:
            break;
    }
    return cell;
}

else if (indexPath.section ==20)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
    cell.textLab.text =@"任何一方当事人因不可抗力不能履行合同的，根据不可抗力的影响，可以部分或者全部免除责任，但应及时通知另一方并在合理期限内提供有关证明。";
       
    return cell;
}
else if (indexPath.section ==21)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
    cell.textLab.text =@"   本合同以婚宴举办所在地的酒店作为本合同的签订地";

    return cell;
}
else if (indexPath.section ==22)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
    switch (indexPath.row) {
        case 0:
            cell.textLab.text =@"本合同项下发生的争议，由双方协商解决或申请调解解决，协商、调解解决不成的，可选择以下第     种方式解决：";
            break;
        case 1:
            cell.textLab.text =@"（一）向 ______人民法院提起诉讼；";
            break;
        case 2:
            cell.textLab.text =@"（二）向______仲裁委员会申请仲裁。";
            break;
       
            
        default:
            break;
    }
    return cell;
}
else if (indexPath.section ==23)
{
    HRTitleOneLineCell *cell = [HRTitleOneLineCell cellWithTableView:yuTableView];
    cell.textLab.font =kFont(13);
   cell.textLab.text =@"　　本合同经双方签字、盖章后生效。双方对合同内容的变更或补充应采用书面形式，作为本合同的附件。附件与本合同具有同等的法律效力。";

    
    return cell;
}
    
    


    
    else{
        HRHTBottomCell *cell = [HRHTBottomCell cellWithTableView:yuTableView];
       return cell;
}
    
   
}
- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - YUFoldingTableViewDelegate / optional （可选择实现的）

- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView descriptionForHeaderInSection:(NSInteger )section
{
    return @"";
}
#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//动态计算label高度
- (CGFloat )getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
    
}
-(void)lingClick{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"为保证给您提供优质的婚礼担保服务，请联系您的婚庆公司制定您的专属担保合同" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}
@end
