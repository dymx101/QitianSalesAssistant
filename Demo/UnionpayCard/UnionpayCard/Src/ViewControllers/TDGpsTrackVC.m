//
//  TDGpsTrackVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 4/17/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDGpsTrackVC.h"

#define RUNTIME 60*60

@interface TDGpsTrackVC ()

@end

@implementation TDGpsTrackVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _backgroundUpdateInterval = RUNTIME;//设置计时器时间
    
    _saveLocations = [[NSMutableArray alloc] init];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    
    _mapView = [MKMapView new];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    [_mapView alignToView:self.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}



- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MKCoordinateSpan mySpan = [mapView region].span;
    _storedLatitudeDelta = mySpan.latitudeDelta;
    _storedLongitudeDelta = mySpan.longitudeDelta;
}


//吏新定位
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    //在地图上加大头针
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = newLocation.coordinate;
    [_mapView addAnnotation:annotation];//
    [_saveLocations addObject:annotation];
    
    
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
    {
        if (_backgroundTask != UIBackgroundTaskInvalid)//如果后台没有关闭，结束
        {
            [[UIApplication sharedApplication] endBackgroundTask:_backgroundTask];
            _backgroundTask = UIBackgroundTaskInvalid;
        }
        
        //显示所有的大头针
        for (MKPointAnnotation *annotation in _saveLocations)
        {
            CLLocationCoordinate2D coordinate = annotation.coordinate;
            
            MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(coordinate,_storedLatitudeDelta ,_storedLongitudeDelta);
            MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
            [_mapView setRegion:adjustedRegion animated:NO];
        }
    }
    else
    {
        NSLog(@"applicationD in Background,newLocation:%@", newLocation);
    }
}




//用定时器控制后台运行定位时间
-(void)applicationDidEnterBackground:(NSNotificationCenter *)notication{
    UIApplication* app = [UIApplication sharedApplication];
    
    _backgroundTask = [app beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"applicationD in Background");
    }];
    
    
    //加入定时器，用来控制后台运行时间
    _updateTimer = [NSTimer scheduledTimerWithTimeInterval:_backgroundUpdateInterval
                                                         target:self
                                                       selector:@selector(stopUpdate)
                                                       userInfo:nil
                                                        repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_updateTimer forMode:NSRunLoopCommonModes];
}




//时间到，停止后台运行定位
-(void)stopUpdate{
    [_locationManager stopUpdatingLocation];
    
    [_updateTimer invalidate];
    _updateTimer = nil;
    if (_backgroundTask != UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:_backgroundTask];
        _backgroundTask = UIBackgroundTaskInvalid;
    }
}

@end
