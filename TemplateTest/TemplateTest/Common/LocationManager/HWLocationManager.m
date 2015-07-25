//
//  HWLocationManager.m
//  TemplateTest
//
//  Created by hw500028 on 4/15/15.
//  Copyright (c) 2015 caijingpeng.haowu. All rights reserved.
//

#import "HWLocationManager.h"
@interface HWLocationManager()<CLLocationManagerDelegate>

@end

@implementation HWLocationManager

+ (HWLocationManager *)shareManager
{
    
    static HWLocationManager *sharedLoactionManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedLoactionManagerInstance = [[self alloc] init];
    });
    return sharedLoactionManagerInstance;
    
}

- (BOOL)startLocating
{
    if ([CLLocationManager locationServicesEnabled])
    {
        self.manager = [[CLLocationManager alloc]init];
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        self.manager.distanceFilter = kCLLocationAccuracyKilometer;
   
        if (IOS8)
        {
            [self.manager requestWhenInUseAuthorization];
        }
        [self.manager startUpdatingLocation];
        return true;

    }
    return false;
}

#pragma mark - 定位成功以后的回调

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    self.coordinate = location.coordinate;
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    __block  CLPlacemark * p;
    self.isLocationSuccess = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationSuccessNotification object:nil];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
       
        if (error != nil) {
            return;
        }
        NSArray * pm = placemarks;
        if (pm.count > 0)
        {
            p = (CLPlacemark *)pm[0];
            self.cityName = [p.addressDictionary stringObjectForKey:@"State"];
           
            NSArray * address = [p.addressDictionary arrayObjectForKey:@"FormattedAddressLines"];
            self.locationAddress = [address pObjectAtIndex:0];
        }
        else
        {
            NSLog(@"No Placemarks!");
        }
        
    }];
    
    if (self.locationSuccess)
    {
        _locationSuccess(location);
        
    
    }

    [self.manager stopUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationFailNotification object:nil];
    self.isLocationSuccess = NO;
    if (_locationFailed)
    {
        _locationFailed();
    }

}


@end
