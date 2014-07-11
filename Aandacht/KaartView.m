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

@synthesize headerV = _headerV;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:defaultGrayBackgroundColor];
        
        //HEADER
        self.headerV = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 65)];
        [self addSubview:self.headerV];
        
        self.map = [[MKMapView alloc] initWithFrame:frame];
        self.map.frame = CGRectMake(0, self.headerV.frame.size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - self.headerV.frame.size.height - bottomBarHeight);
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(50.825118, 3.251460);
        self.map.region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
        self.map.showsUserLocation = YES;
        
        NSArray *arrAllIncidents = [Constants selectIncidentsWithMultipleStatuses:[[NSArray alloc] initWithObjects:@"pending", @"active", @"denied", nil]];
        UIImage *mapMarker = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"logo_big" ofType:@"png" inDirectory:[NSString stringWithFormat:@"%@views/kaart/",imageDir]]];
        for(int i = 0; i<[arrAllIncidents count]; i++){
            Incident *currentIncident = (Incident*)arrAllIncidents[i];
            
            MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
            annotationPoint.coordinate = CLLocationCoordinate2DMake(currentIncident.latitude, currentIncident.longitude);
            annotationPoint.title = currentIncident.address;
            annotationPoint.subtitle = currentIncident.description;
            //annotationPoint.image
            [self.map addAnnotation:annotationPoint];
        }
        
        //user location
        //MKMapPoint annotationCoordinates = MKMapPointForCoordinate(self.map.userLocation.coordinate);
        
        MKMapPoint annotationCoordinates = MKMapPointForCoordinate(CLLocationCoordinate2DMake(50.825457, 3.268784));
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = CLLocationCoordinate2DMake(50.825457, 3.268784);
        annotationPoint.title = @"You";
        [self.map addAnnotation:annotationPoint];
        
        //annotationPoint.subtitle = @"The best of the best!";
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
        
        /*if([CLLocationManager locationServicesEnabled]){
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            self.locationManager.distanceFilter = 1;
            
            [self.locationManager startUpdatingLocation];
        }*/
        
        self.map.delegate = self;
        
        [self addSubview:self.map];
    }
    return self;
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
