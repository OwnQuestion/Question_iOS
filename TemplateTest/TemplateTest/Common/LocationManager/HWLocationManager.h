//
//  HWLocationManager.h
//  TemplateTest
//
//  Created by hw500028 on 4/15/15.
//  Copyright (c) 2015 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface HWLocationManager : NSObject

@property (nonatomic, strong) CLLocationManager * manager;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, strong) NSString * locationAddress;
@property (nonatomic, assign) BOOL isLocationSuccess;
@property (nonatomic, strong) void (^locationSuccess) (CLLocation *loc);
@property (nonatomic, strong) void (^locationFailed) (void);


@end
