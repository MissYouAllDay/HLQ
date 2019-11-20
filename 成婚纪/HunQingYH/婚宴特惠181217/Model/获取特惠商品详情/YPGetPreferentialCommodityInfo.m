//
//  YPGetPreferentialCommodityInfo.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/7.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPGetPreferentialCommodityInfo.h"

@implementation YPGetPreferentialCommodityInfo


- (void)getOtherModelValue:(HRTingModel *)banquetModel {
    
    self.Name = banquetModel.BanquetHallName;
    self.CoverMap = banquetModel.TypeContent;
    self.Discount = banquetModel.DiscountCharge;
    self.ServiceChargeProportion = banquetModel.ServiceCharge;
    //            self.EarnestMoney = banquetModel;
    self.MinTable = banquetModel.MinTableCount;
    self.MaxTable = banquetModel.MaxTableCount;
    //            self.DetaiMap = banquetModel.DetaiMap;
    self.FacilitatorName = banquetModel.HotelName;
    self.FacilitatorImage = banquetModel.HotelLogo;
    //            self.PresentDetailMap =banquetModel.PresentDetailMap;
    
    self.FacilitatorId = banquetModel.FacilitatorId;
    //            self.FacilitatorImage = banquetModel.FacilitatorImage;
    self.Address = banquetModel.Address;
    self.SalesVolume = banquetModel.SalesVolume;
    self.CaseInfoCount = banquetModel.CaseInfoCount;
    self.DynamicCount = banquetModel.DynamicCount;
    self.Acreage = banquetModel.Acreage;
    self.Length = banquetModel.Length;
    self.Width = banquetModel.Width;
    self.Height = banquetModel.Height;
    self.Column = banquetModel.Column;
    
}
@end
