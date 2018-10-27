//
//  BaiduCoreLocation.m
//  EsaiRecharge
//
//  Created by HJQ on 15-1-29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaiduCoreLocation.h"
#import "NetworkVerification.h"

@interface BaiduCoreLocation()
{
    
    NSTimer *timer;

}

@end

@implementation BaiduCoreLocation


- (id)initWithgetAddress:(BOOL)isbool truelocation:(BOOL)truelocation {
    
    self = [super init];
    
    if (self != nil) {
        [self initBMKUserLocation];
        IsBool = isbool;
        Istruelocation = truelocation;
       
    }
    
    return self;
}

#pragma mark: - 获取两个经纬度间的距离
+ (CGFloat) getBetweenMapPointsDistance:(CLLocationCoordinate2D)point1 point2:(CLLocationCoordinate2D)point2 {
    // 百度地图获取两点的距离
    BMKMapPoint mapPoint1 = BMKMapPointForCoordinate(point1);
    BMKMapPoint MapPoint2 = BMKMapPointForCoordinate(point2);
    // 返回的是米的距离
    CLLocationDistance distance = BMKMetersBetweenMapPoints(mapPoint1,MapPoint2);
    return distance / 1000.0;

}

+ (double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2 {
    //    CLLocation *curLocation = [[CLLocation alloc] initWithLatitude:[QFLocationInfo shareInfo].latitude longitude:[QFLocationInfo shareInfo].longtitude];
    //    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:[locationArray.lastObject doubleValue] longitude:[locationArray.firstObject floatValue]];
    //    double  distance  = [curLocation distanceFromLocation:otherLocation];
    //    cell.distanceLb.text = [NSString stringWithFormat:@"%.1fkm",distance / 1000.0];
    
    CLLocation *curLocation = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    double  distance  = [curLocation distanceFromLocation:otherLocation];
    return  distance;
    
}

#pragma 初始化百度地图用户位置管理类
/**
 *  初始化百度地图用户位置管理类
 */
- (void)initBMKUserLocation {
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    
    geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
    geoCodeSearch.delegate = self;
    //初始化逆地理编码类
    reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    
    currentLocation = [[LocationModel alloc] init];
   
}

#pragma 打开定位服务
/**
 *  打开定位服务
 */
-(void)startLocation {
    //是否需要实时定位功能1
    if (Istruelocation) {
        
        [self BMKLocation];
    }
    else{
        [self BMKLocation];
    }
}

-(void)BMKLocation {

    NSInteger netWortStateInteger = [NetworkVerification verificationCurrentNetwork];
    if(netWortStateInteger != -1)
    {
        // 判断定位操作是否被允许(GPS是否开启)
        if([CLLocationManager locationServicesEnabled]) {
            
            // IOS 8 定位之前特殊处理
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
            {
                locationManager = [[CLLocationManager  alloc] init];
                //获取授权认证
                [locationManager requestAlwaysAuthorization ];
                [locationManager requestWhenInUseAuthorization ];
            }
            
            [_locService startUserLocationService];
            
        }else {
            
            //应用未授权，提示
            if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized) {
                
                debugLog(@"定位失败，请开启定位服务!");
            }
        }
        
    }
    else {
        if ([_delegate respondsToSelector:@selector(locationServicesEnabled)]) {
            
            //隐藏调用委托, 不然alertView会出现卡顿
            [self performSelector:@selector(locationServicesEnabled) withObject:nil afterDelay:0.01];
        }
    }

}

/**
 *  通过地址获取坐标系
 */
-(void)geocodeSearchOption:(NSString *)city address:(NSString *)address {
    
    geocodeSearchOption.city= city;
    geocodeSearchOption.address = address;
    [geoCodeSearch geoCode:geocodeSearchOption];
}

/**
 *  关闭定位服务
 */
-(void)stopLocation {
    [_locService stopUserLocationService];
}
#pragma BMKLocationServiceDelegate
/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser {
    
    NSLog(@"开始定位");
    
    //设置网络请求超时时间(秒)
    timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(locationServicesEnabled) userInfo:nil repeats:NO];
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser {
    
    [self invalidateTimer];
    NSLog(@"停止定位");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{

    _userLocation = userLocation.location;
    //需要逆地理编码的坐标位置
    if (userLocation.location.coordinate.latitude != 0 && userLocation.location.coordinate.longitude != 0) {
        
        //停止定位
        [self stopLocation];
        currentLocation.location = userLocation.location;
        
        if(IsBool){
            
            geoCodeSearch = nil;
            geoCodeSearch.delegate = nil;
            
            geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
            geoCodeSearch.delegate = self;
            
            reverseGeoCodeOption.reverseGeoPoint = _userLocation.coordinate;
            [geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
            NSLog(@"开始反编译");
        }
        else{
            
            if (_delegate) {
                if ([_delegate respondsToSelector:@selector(locationFinish:)]) {
                    [_delegate locationFinish:_userLocation];
                }
            }
            
            //保存当前地理信息
            [self saveLocation];
            
           // [self invalidateTimer];
            
        }
        
    }
    
}
/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error{
    
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse && [[[UIDevice currentDevice] name] isEqualToString:@"iPhone Simulator"])
    {
        //模拟器上定位
        
        return;
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        debugLog(@"请在iPhone设置->隐私->定位服务中允许本应用定位!");
    }
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //BMKReverseGeoCodeResult是编码的结果，包括地理位置，道路名称，uid，城市名等信息
    _address = result.address;
    _addressDetail = result.addressDetail;
   
    if (error == 0) {
        
        
        if (_delegate) {
            if ([_delegate respondsToSelector:@selector(locationFinish:)]) {
                [_delegate locationFinish:_userLocation];
            }
        }
        currentLocation.streetNumber = _addressDetail.streetNumber;
        currentLocation.streetName = _addressDetail.streetName;
        currentLocation.district = _addressDetail.district;
        currentLocation.city = _addressDetail.city;
        currentLocation.province = _addressDetail.province;
        
        
        //保存当前地理信息
        //[self saveLocation];
        
         //[self invalidateTimer];
    }
    else{
        debugLog(@"获取地理坐标失败，请检查是否开启定位服务!");
        
        
    }
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
   
    CLLocationCoordinate2D coordinate2D = result.location;
   
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(getGeoCodeFinishResult:)]) {
            
            [_delegate getGeoCodeFinishResult:coordinate2D];
        }
    }
    
   [self invalidateTimer];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ([_delegate respondsToSelector:@selector(locationServicesEnabled)]) {
        
        //隐藏调用委托, 不然alertView会出现卡顿
        [self performSelector:@selector(locationServicesEnabled) withObject:nil afterDelay:0.01];
    }
    
    
}

//定位失败
- (void) locationServicesEnabled
{
    [self invalidateTimer];
    if (_delegate) {
        
        if ([_delegate respondsToSelector:@selector(locationServicesEnabled)]) {
            [self stopLocation];
            [_delegate locationServicesEnabled];
        }
    }
}

//保存当前地理信息
-(void)saveLocation{

}


//停止定时器
- (void) invalidateTimer
{
    if(timer != nil)
    {
        [timer invalidate];
        timer = nil;
    }
}

-(void)dealloc{

    _locService.delegate = nil;
    geoCodeSearch.delegate = nil;
    geocodeSearchOption = nil;
    _locService = nil;
    geoCodeSearch = nil;
    reverseGeoCodeOption = nil;
    locationManager = nil;
    currentLocation = nil;
    _userLocation = nil;
}
@end
