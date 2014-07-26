//
//  IncidentenDetailInfoView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 22/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "IncidentenDetailInfoView.h"
#import "Constants.h"

@implementation IncidentenDetailInfoView

@synthesize map = _map;
@synthesize contentContainer = _contentContainer;
@synthesize lblTitle = _lblTitle;
@synthesize lblCity = _lblCity;
@synthesize lblDescription = _lblDescription;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.map = [[MKMapView alloc] initWithFrame:frame];
        self.map.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 115);
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(currentSelectedIncident.latitude, currentSelectedIncident.longitude);
        self.map.region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
        self.map.showsUserLocation = YES;
        
        /*UIImage *mapMarker = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"logo_big" ofType:@"png" inDirectory:[NSString stringWithFormat:@"%@views/kaart/",imageDir]]];
         MKMapPoint annotationCoordinates = MKMapPointForCoordinate(CLLocationCoordinate2DMake(currentSelectedIncident.latitude, currentSelectedIncident.latitude));*/
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = CLLocationCoordinate2DMake(currentSelectedIncident.latitude, currentSelectedIncident.longitude);
        annotationPoint.title = currentSelectedIncident.address;
        annotationPoint.subtitle = currentSelectedIncident.description;
        //annotationPoint.image
        [self.map addAnnotation:annotationPoint];
        
        //user location
        //MKMapPoint annotationCoordinates = MKMapPointForCoordinate(self.map.userLocation.coordinate);
        
        MKPointAnnotation *annotationPoint2 = [[MKPointAnnotation alloc] init];
        annotationPoint2.coordinate = CLLocationCoordinate2DMake(50.825457, 3.268784);
        annotationPoint2.title = @"You";
        [self.map addAnnotation:annotationPoint2];
        
        
        self.map.delegate = self;
        [self addSubview:self.map];
        
        //CREATE TEXT CONTENT CONTAINER
        self.contentContainer = [[UIView alloc] initWithFrame:CGRectMake(0, self.map.frame.origin.y + self.map.frame.size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - self.map.frame.origin.y + self.map.frame.size.height)];
        self.contentContainer.layer.borderColor = defaultDarkGrayBorder.CGColor;
        self.contentContainer.layer.borderWidth = 1;
        [self addSubview:self.contentContainer];
        
        //TITLE
        self.lblTitle = [Constants createLabel:[currentSelectedIncident.address uppercaseString] andFrame:CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 15) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentCenter andTextColor:incidentListItemTextColor andFont:[UIFont fontWithName:@"BrandonGrotesque-Black" size:18]];
        [self.contentContainer addSubview:self.lblTitle];
        
        //CITY
        self.lblCity = [Constants createLabel:[currentSelectedIncident.city uppercaseString] andFrame:CGRectMake(0, self.lblTitle.frame.origin.y + self.lblTitle.frame.size.height + 6, [[UIScreen mainScreen] bounds].size.width, 15) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentCenter andTextColor:incidentListItemTextColor andFont:[UIFont fontWithName:@"BrandonGrotesque-Regular" size:9]];
        [self.contentContainer addSubview:self.lblCity];
        
        //DESCRIPTION
        self.lblDescription = [Constants createLabel:currentSelectedIncident.description andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, self.lblCity.frame.origin.y + self.lblCity.frame.size.height + 20, defaultContentWidth, 1000) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentLeft andTextColor:incidentListItemTextColor andFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        self.lblDescription.adjustsFontSizeToFitWidth = NO;
        self.lblDescription.numberOfLines = 0;
        [self.lblDescription sizeToFit];
        [self.contentContainer addSubview:self.lblDescription];
        
        NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
        style.minimumLineHeight = 24.f;
        style.maximumLineHeight = 24.f;
        NSDictionary *attributes = @{NSParagraphStyleAttributeName : style,};
        self.lblDescription.attributedText = [[NSAttributedString alloc] initWithString:self.lblDescription.text attributes:attributes];
        [self.lblDescription sizeToFit];
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
            pinView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"marker_default" ofType:@"png" inDirectory:[[NSString alloc] initWithFormat:@"%@views/kaart/", imageDir]]];
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
