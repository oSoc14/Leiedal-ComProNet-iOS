//
//  FilterView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "FilterView.h"
#import "Constants.h"

@implementation FilterView

@synthesize lblIncidenten = _lblIncidenten;
@synthesize arrFilterItems = _arrFilterItems;
@synthesize segmentedControl = _segmentedControl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = defaultDarkGrayBorder.CGColor;
        self.layer.borderWidth = 1;
        
        self.lblIncidenten = [Constants createLabel:NSLocalizedString(@"incidenten_filter_title", @"") andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, 12, defaultContentWidth, 15) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentCenter andTextColor:[UIColor colorWithRed:(0/255.0) green:(117/255.0) blue:(198/255.0) alpha:1] andFont:[UIFont fontWithName:@"HelveticaNeue" size:19]];
        [self addSubview:self.lblIncidenten];
        
        [self updateSegmentedControl];
    }
    return self;
}

-(void)updateSegmentedControl{
    //SEGMENTED CONTROL
    [self.segmentedControl removeFromSuperview];
    if(isUserActive){
        self.arrFilterItems = [NSArray arrayWithObjects: NSLocalizedString(@"incidenten_filter1", @""), NSLocalizedString(@"incidenten_filter2", @""), NSLocalizedString(@"incidenten_filter3", @""), nil];
    }else{
        self.arrFilterItems = [NSArray arrayWithObjects: NSLocalizedString(@"incidenten_filter2", @""), NSLocalizedString(@"incidenten_filter3", @""), nil];
    }
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.arrFilterItems];
    self.segmentedControl.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, 37, defaultContentWidth, 30);
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"HelveticaNeue" size:11] forKey:NSFontAttributeName];
    [self.segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.segmentedControl addTarget:self action:@selector(changeFilter:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self addSubview: self.segmentedControl];
    
    [self updateSelectedIncidents];
}

-(void)changeFilter:(id)sender{
    [self updateSelectedIncidents];
}

-(void)updateSelectedIncidents{
    if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] isEqualToString:@""]){
        float offset = 3 - [self.arrFilterItems count];
        if (self.segmentedControl.selectedSegmentIndex+offset == 0) {
            //active incidents
            [Constants setSelectedIncidentsWithMultipleStatuses:[[NSArray alloc] initWithObjects:@"active", nil]];
        } else if(self.segmentedControl.selectedSegmentIndex+offset == 1){
            //all incidents
            [Constants setSelectedIncidentsWithMultipleStatuses:[[NSArray alloc] initWithObjects:@"pending", @"active", @"denied", @"finished", nil]];
        } else if(self.segmentedControl.selectedSegmentIndex+offset == 2){
            //my incidents
            [Constants setSelectedIncidentsWithMultipleStatuses:[[NSArray alloc] initWithObjects:@"pending", @"active", @"denied", nil]];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATE_SELECTED_INCIDENTS" object:nil];
    }
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
