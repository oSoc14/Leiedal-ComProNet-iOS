//
//  IncidentDetailView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 11/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "HeaderView.h"

@interface IncidentDetailView : UIView <MKMapViewDelegate, CLLocationManagerDelegate>

@property(strong, nonatomic) HeaderView *headerV;
@property(strong, nonatomic) MKMapView *map;
@property(strong, nonatomic) UIView *contentContainer;
@property(strong, nonatomic) UILabel *lblTitle;
@property(strong, nonatomic) UILabel *lblCity;
@property(strong, nonatomic) UILabel *lblDescription;

@end
