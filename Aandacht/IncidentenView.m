//
//  IncidentenView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "IncidentenView.h"
#import "Constants.h"

@implementation IncidentenView

@synthesize imageDir = _imageDir;
@synthesize headerV = _headerV;

@synthesize btnCall = _btnCall;
@synthesize confirmCall = _confirmCall;

@synthesize filterV = _filterV;
@synthesize arrIncidentenList = _arrIncidentenList;
@synthesize incidentenListScrollV = _incidentenListScrollV;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageDir = [NSString stringWithFormat:@"%@/views/incidenten/",imageDir];
        [self setBackgroundColor:defaultGrayBackgroundColor];
        
        //EVENT LISTENERS
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateIncidentsList:) name:@"UPDATE_SELECTED_INCIDENTS" object:nil];
        
        //HEADER
        self.headerV = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 65)];
        [self addSubview:self.headerV];
        
        //CALL BUTTON
        self.btnCall = [Constants createCustomButton:[NSLocalizedString(@"incidenten_call_button", @"") uppercaseString] andTextColor:[UIColor whiteColor] andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, self.headerV.frame.origin.y + self.headerV.frame.size.height + 15, defaultContentWidth, 37.5) andBackgroundImagePath:[[NSBundle mainBundle] pathForResource:@"call_112" ofType:@"png" inDirectory:self.imageDir] andBackgroundHoverImagePath:[[NSBundle mainBundle] pathForResource:@"call_112_h" ofType:@"png" inDirectory:self.imageDir] andFont:[UIFont fontWithName:@"BrandonGrotesque-Black" size:24]];
        [self addSubview:self.btnCall];
        [self.btnCall addTarget:self action:@selector(callEmergencyService:) forControlEvents:UIControlEventTouchUpInside];
        
        //INCIDENTEN SCROLLVIEW
        self.incidentenListScrollV = [[IncidentenListScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 1)];
        self.incidentenListScrollV.delegate = self.incidentenListScrollV;
        self.incidentenListScrollV.scrollEnabled = YES;
        self.incidentenListScrollV.delaysContentTouches = YES;
        self.incidentenListScrollV.canCancelContentTouches = NO;
        [self.incidentenListScrollV setShowsHorizontalScrollIndicator:NO];
        [self.incidentenListScrollV setShowsVerticalScrollIndicator:NO];
        [self addSubview:self.incidentenListScrollV];
        
        //FILTER
        self.filterV = [[FilterView alloc] initWithFrame:CGRectMake(0, self.btnCall.frame.origin.y + self.btnCall.frame.size.height + 15, [[UIScreen mainScreen] bounds].size.width, 81)];
        [self addSubview:self.filterV];
        
        //set scrollview frame
        float negativeSpace = self.filterV.frame.origin.y + self.filterV.frame.size.height - 1;
        self.incidentenListScrollV.frame = CGRectMake(0, negativeSpace, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - negativeSpace);
    }
    return self;
}

-(void)callEmergencyService:(id)sender{
    self.confirmCall = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"incidenten_call_alert", @"") message:@"" delegate:self cancelButtonTitle:@"Annuleer" otherButtonTitles:@"Bel", nil];
    [self.confirmCall show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        //Confirmed - call
        NSLog(@"Confirmed call: call emergency services");
        
        NSString *phoneNumber = @"+112";
        NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phoneNumber]];
        if([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        }
    }
}

-(void)updateIncidentsList:(id)sender{
    NSLog(@"[IncidentenView] updateIncidentsList: %lu", (unsigned long)[arrSelectedIncidents count]);
    [self.incidentenListScrollV updateIncidentsList];
    self.incidentenListScrollV.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, [arrSelectedIncidents count]*(incidentListItemViewHeight+9));
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UPDATE_SELECTED_INCIDENTS" object:nil];
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
