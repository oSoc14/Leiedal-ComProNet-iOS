//
//  IncidentenListScrollView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 10/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Incident.h"

@interface IncidentenListScrollView : UIScrollView <UIScrollViewDelegate>

@property(strong, nonatomic) NSArray *arrIncidents;
@property(strong, nonatomic) NSMutableArray *arrIncidentListViews;
@property(strong, nonatomic) Incident *currentSelectedIncident;

-(void)updateIncidentsList;

@end
