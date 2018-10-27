//
//  BaiduCoreLocation.h
//  EsaiRecharge
//
//  Created by HJQ on 15-1-29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import "LocationModel.h"

@protocol BaiduCoreLocationDelegate <NSObject>

@optional
-(void)locationFinish:(CLLocation *)UserLocation;
-(void)locationServicesEnabled;
//反编译地理位置完成 
-(void)getGeoCodeFinishResult:(CLLocationCoordinate2D )coordinate2D;

@end

@interface BaiduCoreLocation : NSObject<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKReverseGeoCodeOption *reverseGeoCodeOption;//逆地理编码
    BMKGeoCodeSearch *geoCodeSearch;
    BMKGeoCodeSearchOption *geocodeSearchOption;
    BOOL IsBool;
    CLLocationManager *locationManager;
    LocationModel *currentLocation;
    BOOL Istruelocation;
}

@property (nonatomic,weak) id<BaiduCoreLocationDelegate> delegate;
@property (strong,nonatomic) BMKLocationService *locService;

//
@property (nonatomic,strong) BMKAddressComponent *addressDetail;
//当前地址
@property (strong,nonatomic) NSString *address;

//用户位置
@property (strong,nonatomic)CLLocation *userLocation;


- (id)initWithgetAddress:(BOOL)isbool truelocation:(BOOL)truelocation;

/**
 *  打开定位服务
 */
-(void)startLocation;
/**
 *  关闭定位服务
 */
-(void)stopLocation;
/**
 *  通过地址获取坐标系
 */
-(void)geocodeSearchOption:(NSString *)city address:(NSString *)address;

// 返回两点经纬度距离
+ (CGFloat) getBetweenMapPointsDistance:(CLLocationCoordinate2D)point1 point2:(CLLocationCoordinate2D)point2;

+ (double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2;

@end
