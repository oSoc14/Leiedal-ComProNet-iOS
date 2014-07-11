//
//  KaartView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "HeaderView.h"

@interface KaartView : UIView <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) HeaderView *headerV;
@property (strong, nonatomic) MKMapView *map;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
