//
//  KaartView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "KaartView.h"
#import "Incident.h"
#import "Constants.h"

@implementation KaartView

@synthesize imageDir = _imageDir;
@synthesize defaultUserLocation = _defaultUserLocation;

@synthesize headerV = _headerV;
@synthesize map = _map;
@synthesize locationManager = _locationManager;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageDir = [[NSString alloc] initWithFormat:@"%@views/kaart/",imageDir];
        self.defaultUserLocation = CLLocationCoordinate2DMake(50.825457, 3.268784);
        [self setBackgroundColor:defaultGrayBackgroundColor];
        
        //HEADER
        self.headerV = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 65)];
        [self addSubview:self.headerV];
        
        self.map = [[MKMapView alloc] initWithFrame:frame];
        self.map.delegate = self;
        self.map.frame = CGRectMake(0, self.headerV.frame.size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - self.headerV.frame.size.height - bottomBarHeight);
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(50.825118, 3.251460);
        self.map.region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
        self.map.showsUserLocation = YES;
        
        NSArray *arrAllIncidents = [Constants selectIncidentsWithMultipleStatuses:[[NSArray alloc] initWithObjects:@"pending", @"active", @"denied", nil]];
        for(int i = 0; i<[arrAllIncidents count]; i++){
            Incident *currentIncident = (Incident*)arrAllIncidents[i];
            
            MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
            annotationPoint.coordinate = CLLocationCoordinate2DMake(currentIncident.latitude, currentIncident.longitude);
            annotationPoint.title = currentIncident.address;
            annotationPoint.subtitle = currentIncident.description;
            [self.map addAnnotation:annotationPoint];
        }
        
        //user location
        //MKMapPoint annotationCoordinates = MKMapPointForCoordinate(self.map.userLocation.coordinate);
        
        MKMapPoint annotationCoordinates = MKMapPointForCoordinate(CLLocationCoordinate2DMake(50.825457, 3.268784));
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = CLLocationCoordinate2DMake(self.defaultUserLocation.latitude, self.defaultUserLocation.longitude);
        annotationPoint.title = @"You";
        [self.map addAnnotation:annotationPoint];
        
        MKMapRect zoomRect = MKMapRectMake(annotationCoordinates.x, annotationCoordinates.y, 0.1, 0.1);
        
        for (id <MKAnnotation> annotation in self.map.annotations)
        {
            MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
            MKMapRect pointRect = MKMapRectMake(annotationPoint.x+1000, annotationPoint.y+1000, 0.1, 0.1);
            MKMapRect pointRect2 = MKMapRectMake(annotationPoint.x-1000, annotationPoint.y-1000, 0.1, 0.1);
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
            zoomRect = MKMapRectUnion(zoomRect, pointRect2);
        }
        [self.map setVisibleMapRect:zoomRect animated:YES];
        
        if([CLLocationManager locationServicesEnabled]){
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            self.locationManager.distanceFilter = 1;
            
            [self.locationManager startUpdatingLocation];
        }
        
        [self addSubview:self.map];
    }
    return self;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"marker_default" ofType:@"png" inDirectory:self.imageDir]];
            pinView.calloutOffset = CGPointMake(0, -5);
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
