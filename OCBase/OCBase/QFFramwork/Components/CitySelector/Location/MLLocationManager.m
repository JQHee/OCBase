//
//  LocationManager.m
//  CityListDemo
//
//  Created by midland on 2018/11/12.
//  Copyright © 2018年 midland. All rights reserved.
//

#import "MLLocationManager.h"

#import <CoreLocation/CoreLocation.h>

@interface MLLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation MLLocationManager

- (instancetype)init {
    
    if (self = [super init]) {
        [self startPositioningSystem];
    }
    return self;
}

- (void)startPositioningSystem {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    if (self.delegate && [self.delegate respondsToSelector:@selector(locating)]) {
        [self.delegate locating];
    }
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (self.delegate && [self.delegate respondsToSelector:@selector(locating)]) {
//            [self.delegate locating];
//        }
//    });
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *location = [placemark addressDictionary];
            if (self.delegate && [self.delegate respondsToSelector:@selector(currentLocation:)]) {
                [self.delegate currentLocation:location];
            }
//            static dispatch_once_t onceToken;
//            dispatch_once(&onceToken, ^{
//                if (self.delegate && [self.delegate respondsToSelector:@selector(currentLocation:)]) {
//                    [self.delegate currentLocation:location];
//                }
//            });
        }
    }];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if ([error code] == kCLErrorDenied) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(refuseToUsePositioningSystem:)]) {
            [self.delegate refuseToUsePositioningSystem:@"已拒绝使用定位系统"];
        }
    }
    if ([error code] == kCLErrorLocationUnknown) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(locateFailure:)]) {
            [self.delegate locateFailure:@"无法获取位置信息"];
        }
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            if (self.delegate && [self.delegate respondsToSelector:@selector(locateFailure:)]) {
//                [self.delegate locateFailure:@"无法获取位置信息"];
//            }
//        });
    }
}

@end
