//
//  TDGpsTrackVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 4/17/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDGpsTrackVC.h"

#define RUNTIME (60)

@interface TDGpsTrackVC () {
    NSDate                      *_updateDate;
    UIBackgroundTaskIdentifier  _bgTask;
}

@end

@implementation TDGpsTrackVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _updateDate = [NSDate date];
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}



- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MKCoordinateSpan mySpan = [mapView region].span;
    _storedLatitudeDelta = mySpan.latitudeDelta;
    _storedLongitudeDelta = mySpan.longitudeDelta;
}


-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSDate *now = [NSDate date];
    if (_saveLocations.count > 0 && [now timeIntervalSinceDate:_updateDate] < RUNTIME) {
        return;
    }
    
    _updateDate = now;
    
    
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        
        [self handleBackGroundLocation:newLocation];
        
    } else {
        [self handleForeGroundLocation:newLocation];
    }
}

-(void)recordLocation:(CLLocation *)newLocation {
    
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    annotation.coordinate = newLocation.coordinate;
    [_mapView addAnnotation:annotation];
    [_saveLocations addObject:annotation];
    
}

-(void)handleForeGroundLocation:(CLLocation *)newLocation {
    [self recordLocation:newLocation];
    
    //显示所有的大头针
    for (MKPointAnnotation *annotation in _saveLocations)
    {
        CLLocationCoordinate2D coordinate = annotation.coordinate;

        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate,_storedLatitudeDelta ,_storedLongitudeDelta);
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
        [_mapView setRegion:adjustedRegion animated:NO];
    }
}

-(void)handleBackGroundLocation:(CLLocation *)newLocation {
    
    _bgTask = [[UIApplication sharedApplication]
              beginBackgroundTaskWithExpirationHandler: ^{
                  [[UIApplication sharedApplication] endBackgroundTask:_bgTask];
              }];
                  
    [self recordLocation:newLocation];
    
    if (_bgTask != UIBackgroundTaskInvalid) {
       [[UIApplication sharedApplication] endBackgroundTask:_bgTask];
       _bgTask = UIBackgroundTaskInvalid;
    }
}


////吏新定位
//- (void)locationManager:(CLLocationManager *)manager
//    didUpdateToLocation:(CLLocation *)newLocation
//           fromLocation:(CLLocation *)oldLocation
//{
//    //在地图上加大头针
//    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
//    annotation.coordinate = newLocation.coordinate;
//    [_mapView addAnnotation:annotation];//
//    [_saveLocations addObject:annotation];
//    
//    
//    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
//    {
//        if (_backgroundTask != UIBackgroundTaskInvalid)//如果后台没有关闭，结束
//        {
//            [[UIApplication sharedApplication] endBackgroundTask:_backgroundTask];
//            _backgroundTask = UIBackgroundTaskInvalid;
//        }
//        
//        //显示所有的大头针
//        for (MKPointAnnotation *annotation in _saveLocations)
//        {
//            CLLocationCoordinate2D coordinate = annotation.coordinate;
//            
//            MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(coordinate,_storedLatitudeDelta ,_storedLongitudeDelta);
//            MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
//            [_mapView setRegion:adjustedRegion animated:NO];
//        }
//    }
//    else
//    {
//        NSLog(@"applicationD in Background,newLocation:%@", newLocation);
//    }
//}


-(void) applicationDidEnterBackground:(UIApplication *) application
{
    // You will also want to check if the user would like background location
    // tracking and check that you are on a device that supports this feature.
    // Also you will want to see if location services are enabled at all.
    // All this code is stripped back to the bare bones to show the structure
    // of what is needed.
    [_locationManager stopUpdatingLocation];
    [_locationManager startMonitoringSignificantLocationChanges];
}

-(void) applicationDidBecomeActive:(UIApplication *) application
{
    [_locationManager stopMonitoringSignificantLocationChanges];
    [_locationManager startUpdatingLocation];
}

@end
