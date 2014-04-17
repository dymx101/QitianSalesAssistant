//
//  TDGpsTrackVC.h
//  UnionpayCard
//
//  Created by Dong Yiming on 4/17/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDBaseVC.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface TDGpsTrackVC : TDBaseVC <CLLocationManagerDelegate, MKMapViewDelegate>
{
    CLLocationDistance _storedLatitudeDelta;
    CLLocationDistance _storedLongitudeDelta;
    
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong)  MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *saveLocations;
@property (nonatomic, strong) NSTimer *updateTimer;

@end
