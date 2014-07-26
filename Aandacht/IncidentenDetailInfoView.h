//
//  IncidentenDetailInfoView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 22/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface IncidentenDetailInfoView : UIView <MKMapViewDelegate, CLLocationManagerDelegate>

@property(strong, nonatomic) MKMapView *map;
@property(strong, nonatomic) UIView *contentContainer;
@property(strong, nonatomic) UILabel *lblTitle;
@property(strong, nonatomic) UILabel *lblCity;
@property(strong, nonatomic) UILabel *lblDescription;

@end
