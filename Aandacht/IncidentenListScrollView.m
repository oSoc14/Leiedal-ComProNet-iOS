//
//  IncidentenListScrollView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 10/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "IncidentenListScrollView.h"
#import "IncidentListItemButton.h"
#import "Constants.h"

@implementation IncidentenListScrollView

@synthesize arrIncidents = _arrIncidents;
@synthesize arrIncidentListViews = _arrIncidentListViews;
@synthesize currentSelectedIncident = _currentSelectedIncident;
@synthesize isAnimated = _isAnimated;
@synthesize lblNoIncidentsAvailable = _lblNoIncidentsAvailable;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.isAnimated = false;
        [self setBackgroundColor: defaultGrayBackgroundColor];
        self.arrIncidentListViews = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)updateIncidentsList{
    for(int i = 0; i<[self.arrIncidentListViews count]; i++){
        [self.arrIncidentListViews[i] removeFromSuperview];
    }
    
    self.arrIncidents = arrSelectedIncidents;
    for(int i=0; i<[self.arrIncidents count]; i++){
        IncidentListItemButton *incidentListItemBtn = [[IncidentListItemButton alloc] initWithFrame:CGRectMake(0, i*(incidentListItemViewHeight-1), [[UIScreen mainScreen] bounds].size.width, incidentListItemViewHeight) andIncident:self.arrIncidents[i]];
        [self.arrIncidentListViews addObject:incidentListItemBtn];
        [incidentListItemBtn addTarget:self action:@selector(tappedIncident:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:incidentListItemBtn];
        
        //fadein
        if(self.isAnimated){
            [incidentListItemBtn setAlpha:0];
            [UIView animateWithDuration:0.4 delay:i*0.05 options:UIViewAnimationOptionLayoutSubviews animations:^{
                incidentListItemBtn.alpha = 1;
            } completion:^(BOOL finished){}];
        }
    }
    
    if([self.arrIncidents count] == 0){
        self.lblNoIncidentsAvailable = [Constants createLabel:NSLocalizedString(@"incidenten_none_available", @"") andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, 15, defaultContentWidth, 20) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentLeft andTextColor:[UIColor colorWithRed:(41/255.0) green:(98/255.0) blue:(149/255.0) alpha:1] andFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13]];
        self.lblNoIncidentsAvailable.numberOfLines = 0;
        [self addSubview:self.lblNoIncidentsAvailable];
    }
}

-(void)tappedIncident:(id)sender{
    self.currentSelectedIncident = ((IncidentListItemButton*)sender).incident;
    currentSelectedIncident = self.currentSelectedIncident;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TAPPED_INCIDENT" object:nil];
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
