//
//  CJAreaPicker.m
//  CJAreaPicker
//
//  Created by 曹 景成 on 14-1-22.
//  Copyright (c) 2014年 JasonCao. All rights reserved.
//

#import "CJAreaPicker.h"
#import "JCGeocoderManager.h"
#import "FMDB.h"
@interface CJAreaPicker ()<JCGeocoderManagerDelegate>{
     FMDatabase *dataBase;
     int provinceID ;
    int  cityID;
}

@end

@implementation CJAreaPicker

-(NSMutableArray *)provinceArray{
    if (!_provinceArray) {
        _provinceArray =[NSMutableArray array];
    }
    return _provinceArray;
}
-(NSMutableArray *)cityesArray{
    if (!_cityesArray) {
        _cityesArray = [NSMutableArray array];
        
    }
    return _cityesArray;
}
-(NSMutableArray *)areaArray{
    if (!_areaArray) {
        _areaArray =[NSMutableArray array];
        
    }
    return _areaArray;
}
#pragma mark --------数据库-------

- (void)openDataBase{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];

        NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"region.db"];
    dataBase =[[FMDatabase alloc]initWithPath:dbFilePath];
    BOOL ret = [dataBase open];
    if (ret) {
        NSLog(@"打开数据库成功");
        
    }else{
        NSLog(@"打开数据库失败");
    }
    
}
- (void)closeDataBase{
    BOOL ret = [dataBase close];
    if (ret) {
        NSLog(@"关闭数据库成功");
    }else{
        NSLog(@"关闭数据库失败");
    }
}
-(void)selectDataBase{
    [self openDataBase];
    
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_NAME FROM Region WHERE PARENT_ID =1"];
    FMResultSet *set =[dataBase executeQuery:selectSql];
    while ([set next]) {
        
       NSString *provinceStr =[set stringForColumn:@"REGION_NAME"];
       
       
        [self.provinceArray addObject:provinceStr];
    }
    [self closeDataBase];
  
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarTintColor:WhiteColor];
    self.edgesForExtendedLayout =UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.type == CJPlaceTypeState) {
        [self selectDataBase];//查询省份
        self.title = @"选择地区";
       
        _places = [NSMutableArray array];
        [self.places removeAllObjects];
        _places = _provinceArray;
        [self.tableView reloadData];
        
        JCGeocoderManager *manager = [JCGeocoderManager sharedJCGeocoderManager];
        manager.delegate = self;
        [[JCGeocoderManager sharedJCGeocoderManager] start];
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissAnimated)];
//        backButton.tintColor =[UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = backButton;
    }else{
        
    }
    
}

-(void)dismissAnimated{
    
    if (_delegate && [_delegate respondsToSelector:@selector(areaPicker:didClickCancleWithAddress:parentID:)]) {
        
        [_delegate areaPicker:self didClickCancleWithAddress:@"黄岛区" parentID:171];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Action

/**
 *    @brief    选定地区事件
 *
 *    @param     sender         事件传递值
 */
- (void)comfirmAction:(id)sender {
    
    NSString *place;
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    switch (self.type) {
        case CJPlaceTypeState:
            
            if (indexPath.section == 1) {
                place =  _provinceArray[indexPath.row];
                if (_delegate && [_delegate respondsToSelector:@selector(areaPicker:didSelectAddress:parentID:)]) {
                    
                    [_delegate areaPicker:self didSelectAddress:place parentID:1];
                    
                }
            }else{
                place = _userlocation;
                
                NSInteger parentid =0;
                [self openDataBase];
                NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'",_userlocation_parent];
                FMResultSet *set =[dataBase executeQuery:selectSql];
                while ([set next]) {
                    parentid = [set intForColumn:@"REGION_ID"];
                }
                
                [self closeDataBase];
                
                
                if (_delegate && [_delegate respondsToSelector:@selector(areaPicker:didSelectAddress:parentID:)]) {
                    
                    [_delegate areaPicker:self didSelectAddress:place parentID:parentid];
                    
                }
            }
            
            break;
        case CJPlaceTypeCity:
            
            place = [NSString stringWithFormat:@"%@ %@",_placeName,_places[indexPath.row]];
            if (_delegate && [_delegate respondsToSelector:@selector(areaPicker:didSelectAddress:parentID:)]) {
                
                [_delegate areaPicker:self didSelectAddress:_areaArray[0] parentID:_parentID];
                
            }
            break;
        case CJPlaceTypeArea:  //最后县级
            self.addressInfoDetail = [NSString stringWithFormat:@"%@ %@",self.addressInfoDetail,self.places[indexPath.row]];

            place = [NSString stringWithFormat:@"%@ %@",_placeName,_places[indexPath.row]];
            if (_delegate && [_delegate respondsToSelector:@selector(areaPicker:didSelectAddress:parentID:)]) {
                
                if (indexPath.row ==0) {
                    [_delegate areaPicker:self didSelectAddress:_places[indexPath.row] parentID:_parentID_regionID];
                    
                }else{
                    [_delegate areaPicker:self didSelectAddress:_places[indexPath.row] parentID:_parentID];
                    
                }
            }
            break;
        default:
            break;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(areaPicker:didSelectAddress:withFullAddress:parentID:)]) {
        [_delegate areaPicker:self didSelectAddress:_places[indexPath.row] withFullAddress:self.addressInfoDetail parentID:self.parentID];
    }
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.type == CJPlaceTypeState) {
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.type == CJPlaceTypeState) {
        return 1;
    }else if (section == 1 && self.type == CJPlaceTypeState) {
        return self.provinceArray.count;
    }else if (self.type == CJPlaceTypeCity){
        return _places.count;
    }else if (self.type == CJPlaceTypeArea){
        return _places.count;
    }else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"UITableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    
    switch (self.type) {
        case CJPlaceTypeState:
            if (indexPath.section == 0) {
                
                cell.textLabel.text = _userlocation.length > 0 ? [NSString stringWithFormat:@"%@",_userlocation] : @"正在定位...";
            }else{
                cell.textLabel.text = _provinceArray[indexPath.row];
            }
            break;
        case CJPlaceTypeCity:
            
       
            cell.textLabel.text = _places[indexPath.row];
            break;
        case CJPlaceTypeArea:
            cell.textLabel.text = _places[indexPath.row];
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.type == CJPlaceTypeState) {
        switch (section) {
            case 0:
                return @"当前地区";
//                return nil;
                break;
            case 1:
                return @"全国";
                break;
                
            default:
                return Nil;
                break;
        }
    }else{
        return nil;
    }
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CJAreaPicker *nextPicker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];
    nextPicker.delegate = self.delegate;
    nextPicker.endType = self.endType;
    switch (self.type) {
        case CJPlaceTypeState:
            if (indexPath.section == 0) {
                
            }else{
                
                [self openDataBase];
                [self.cityesArray removeAllObjects];
                NSString *selectProvince = _provinceArray[indexPath.row];
                NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'",selectProvince];
                FMResultSet *set =[dataBase executeQuery:selectSql];
                while ([set next]) {
                    provinceID = [set intForColumn:@"REGION_ID"];
                }
 
                NSString *selectSql1 =[NSString stringWithFormat:@"SELECT REGION_NAME FROM Region WHERE  PARENT_ID = %d",provinceID];
                FMResultSet *set1 =[dataBase executeQuery:selectSql1];
                
                while ([set1 next]) {
                    NSString *cityStr  = [set1 stringForColumn:@"REGION_NAME"];
                    
                    [self.cityesArray addObject:cityStr];
                    
                }
                [self closeDataBase];
                
                nextPicker.places    =  _cityesArray;
                nextPicker.type = CJPlaceTypeCity;
                nextPicker.title =  _provinceArray[indexPath.row];
                
                nextPicker.placeName = nextPicker.title;
                nextPicker.addressInfoDetail = _provinceArray[indexPath.row];
            }
 
            break;
        case CJPlaceTypeCity:
            if (indexPath.section==0) {

                NSMutableArray *markIds = [[NSMutableArray alloc] init];
                [self.areaArray removeAllObjects];
                [self openDataBase];
                NSString *selectCity = _places[indexPath.row];
                [self.areaArray addObject:selectCity];

                NSString *selectSql3 =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'AND PARENT_ID =%d",selectCity,_parentID];
                 nextPicker.parentID_regionID =_parentID;
                FMResultSet *set3 =[dataBase executeQuery:selectSql3];
                while ([set3 next]) {
                    cityID = [set3 intForColumn:@"REGION_ID"];
     
                }
         
                NSString *selectSql4 =[NSString stringWithFormat:@"SELECT REGION_NAME FROM Region WHERE  PARENT_ID = %d",cityID];
                FMResultSet *set4 =[dataBase executeQuery:selectSql4];
                
                while ([set4 next]) {
                    NSString *cityStr  = [set4 stringForColumn:@"REGION_NAME"];
                    [self.areaArray addObject:cityStr];
                }
                [self closeDataBase];
                nextPicker.places   = _areaArray;
                nextPicker.type = CJPlaceTypeArea;
                nextPicker.title =  _cityesArray[indexPath.row];
                nextPicker.placeName = nextPicker.title;
                nextPicker.addressInfoDetail = [NSString stringWithFormat:@"%@ %@",self.addressInfoDetail,self.places[indexPath.row]];
            }
          
            break;
        case CJPlaceTypeArea:

            break;
        default:
            break;
    }
    
    if (self.type == CJPlaceTypeState && self.endType == CJPlaceEndState) {
        _parentID =cityID;
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(comfirmAction:)];
        self.navigationItem.rightBarButtonItem = rightItem;
        return;
    }
    if (self.type == CJPlaceTypeCity && self.endType == CJPlaceEndCity) {
        _parentID =cityID;
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(comfirmAction:)];
        self.navigationItem.rightBarButtonItem = rightItem;
        return;
    }

    if (nextPicker.places.count>0) {
        if (self.type ==CJPlaceTypeState) {
             nextPicker.parentID =provinceID;
        }
        if (self.type ==CJPlaceTypeCity) {
            nextPicker.parentID =cityID;
        }
//         [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController pushViewController:nextPicker animated:YES];
                
    }else{
        if (indexPath.row ==0) {
            _parentID =cityID;
        }
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(comfirmAction:)];
//        rightItem.tintColor =[UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return (_userlocation.length<1 && self.type ==CJPlaceTypeState &&indexPath.section == 0) ? nil : indexPath;
}

#pragma mark -- JCGeocoderManagerDelegate

- (void)JCGeocoderManager:(JCGeocoderManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", [NSString stringWithFormat:@"无法确定您所在的城市:%@", [error localizedDescription]]);
}

- (void)JCGeocoderManager:(JCGeocoderManager *)manager didFindPlacemark:(MKPlacemark *)placemark {
    
    NSDictionary *addressDictionary = placemark.addressDictionary;
  
//    _userlocation = [NSString stringWithFormat:@"%@ %@ %@",[addressDictionary objectForKey:(id)kABPersonAddressStateKey],[addressDictionary objectForKey:(id)kABPersonAddressCityKey],[addressDictionary objectForKey:@"SubLocality"]];
    
    _userlocation = [NSString stringWithFormat:@"%@",[addressDictionary objectForKey:@"SubLocality"]];
    self.userlocation_parent =[NSString stringWithFormat:@"%@",[addressDictionary objectForKey:@"City"]];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
