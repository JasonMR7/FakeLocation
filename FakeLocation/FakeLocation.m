//
//  FakeLocation.m
//  FakeLocation
//
//  Created by Jason Ruan on 2019/2/12.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

// Action Menu developed by Ryan Petrich

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <objc/runtime.h>
#import "LocationControlView.h"

static NSString *const kSwizzleCLLocationUpdateNotificationName = @"kSwizzleCLLocationUpdateNotificationName";
static double northStep = 0;
static double eastStep = 0;

@implementation CLLocation (Fake)

+ (void)load {
    Method m1 = class_getInstanceMethod(self, @selector(coordinate));
    Method m2 = class_getInstanceMethod(self, @selector(fake_coordinate));
    
    method_exchangeImplementations(m1, m2);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 按键手柄视图
        LocationControlView *controlView = [LocationControlView controlView];
        controlView.northButtonClickBlock = ^{
            northStep += 1;
            [[NSNotificationCenter defaultCenter] postNotificationName:kSwizzleCLLocationUpdateNotificationName object:nil];
        };
        controlView.southButtonClickBlock = ^{
            northStep -= 1;
            [[NSNotificationCenter defaultCenter] postNotificationName:kSwizzleCLLocationUpdateNotificationName object:nil];
        };
        controlView.eastButtonClickBlock = ^{
            eastStep += 1;
            [[NSNotificationCenter defaultCenter] postNotificationName:kSwizzleCLLocationUpdateNotificationName object:nil];
        };
        controlView.westButtonClickBlock = ^{
            eastStep -= 1;
            [[NSNotificationCenter defaultCenter] postNotificationName:kSwizzleCLLocationUpdateNotificationName object:nil];
        };
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        controlView.center = CGPointMake(window.frame.size.width / 2, window.frame.size.height / 2);
        [window addSubview:controlView];
    });
}

/**
 hook坐标，按一下经纬度动0.001(大概一百米)
 */
- (CLLocationCoordinate2D)fake_coordinate {
    CLLocationCoordinate2D pos = [self fake_coordinate];
    pos.longitude += eastStep * 0.001;
    pos.latitude += northStep * 0.001;
    return pos;
}

@end

@implementation CLLocationManager(Fake)

+ (void)load {
    Method m1 = class_getInstanceMethod(self, @selector(init));
    Method m2 = class_getInstanceMethod(self, @selector(init_));
    method_exchangeImplementations(m1, m2);
}


/**
 hook初始化方法，加个通知
 这里是为了能及时刷新页面，模拟CLLocationManager调用代理的方法
 */
- (instancetype)init_ {
    self = [self init_];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLocation:) name:kSwizzleCLLocationUpdateNotificationName object:nil];
    return self;
}

- (void)updateLocation:(NSNotification *)noti {
    if ([self.delegate respondsToSelector:@selector(locationManager:didUpdateLocations:)]) {
        [self.delegate locationManager:self didUpdateLocations:@[self.location]];
    }
}

@end
