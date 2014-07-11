//
//  IncidentListItemButton.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 11/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "IncidentListItemButton.h"
#import "Constants.h"

@implementation IncidentListItemButton

@synthesize incident = _incident;

@synthesize statusIcon = _statusIcon;
@synthesize lblAddress = _lblAddress;
@synthesize lblDescription = _lblDescription;
@synthesize lblTime = _lblTime;
@synthesize arrowRight = _arrowRight;

- (id)initWithFrame:(CGRect)frame andIncident:(Incident*)incident
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithRed:(247/255.0) green:(247/255.0) blue:(247/255.0) alpha:1]];
        self.layer.borderColor = defaultDarkGrayBorder.CGColor;
        self.layer.borderWidth = 1;
        self.incident = incident;
        
        int statusIconDimension = 5;
        if([self.incident.status isEqual:@"pending"]){
            self.statusIcon = [Constants createImageView:[[NSBundle mainBundle] pathForResource:@"status_yellow" ofType:@"png" inDirectory:[NSString stringWithFormat:@"%@views/",imageDir]] andFrame:CGRectMake(incidentListItemStatusIconLeft, 36, statusIconDimension, statusIconDimension)];
        }else if([self.incident.status isEqual:@"active"]){
            self.statusIcon = [Constants createImageView:[[NSBundle mainBundle] pathForResource:@"status_green" ofType:@"png" inDirectory:[NSString stringWithFormat:@"%@views/",imageDir]] andFrame:CGRectMake(incidentListItemStatusIconLeft, 36, statusIconDimension, statusIconDimension)];
        }else if([self.incident.status isEqual:@"denied"]){
            self.statusIcon = [Constants createImageView:[[NSBundle mainBundle] pathForResource:@"status_red" ofType:@"png" inDirectory:[NSString stringWithFormat:@"%@views/",imageDir]] andFrame:CGRectMake(incidentListItemStatusIconLeft, 36, statusIconDimension, statusIconDimension)];
        }else if([self.incident.status isEqual:@"finished"]){
            self.statusIcon = [Constants createImageView:[[NSBundle mainBundle] pathForResource:@"status_grey" ofType:@"png" inDirectory:[NSString stringWithFormat:@"%@views/",imageDir]] andFrame:CGRectMake(incidentListItemStatusIconLeft, 36, statusIconDimension, statusIconDimension)];
        }
        [self addSubview:self.statusIcon];
        
        //ADDRESS LABEL
        self.lblAddress = [Constants createLabel:incident.address andFrame:CGRectMake(incidentListItemTextLeft, 14, incidentListItemTextWidth, 17) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentLeft andTextColor:incidentListItemTextColor andFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        [self addSubview:self.lblAddress];
        
        //DESCRIPTION LABEL
        self.lblDescription = [Constants createLabel:incident.description andFrame:CGRectMake(incidentListItemTextLeft, 31, incidentListItemTextWidth, 15) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentLeft andTextColor:incidentListItemTextColor andFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13]];
        [self addSubview:self.lblDescription];
        
        //TIME/DATE LABEL
        self.lblTime = [Constants createLabel:[self calculateDateDifference:self.incident.timeStamp] andFrame:CGRectMake(incidentListItemTextLeft, 47, incidentListItemTextWidth, 15) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentLeft andTextColor:incidentListItemTextColor andFont:[UIFont fontWithName:@"HelveticaNeue-Italic" size:12]];
        [self addSubview:self.lblTime];
        
        //ARROW RIGHT
        self.arrowRight = [Constants createImageView:[[NSBundle mainBundle] pathForResource:@"icon_arrow_right" ofType:@"png" inDirectory:[NSString stringWithFormat:@"%@views/",imageDir]] andFrame:CGRectMake(300, 32, 4, 14)];
        [self addSubview:self.arrowRight];
    }
    return self;
}

-(NSString*)calculateDateDifference:(NSString*)date{
    NSDate *date1 = [dateFormat dateFromString:date];
    NSDate *date2 = [Constants getCurrentDate];
    NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
    
    NSString *timeDifference;
    if(secondsBetween/minute < 60){
        //minutes
        if(secondsBetween/minute == 1){
            timeDifference = [NSString stringWithFormat:@"%d %@ %@",(int)secondsBetween/minute, NSLocalizedString(@"date_minute", @""), NSLocalizedString(@"date_ago", @"")];
        }else{
            timeDifference = [NSString stringWithFormat:@"%d %@ %@",(int)secondsBetween/minute, NSLocalizedString(@"date_minutes", @""), NSLocalizedString(@"date_ago", @"")];
        }
    }else if(secondsBetween/hour >= 1 && secondsBetween/hour < 24){
        //hours
        if(secondsBetween/hour == 1){
            timeDifference = [NSString stringWithFormat:@"%d %@ %@",(int)secondsBetween/hour, NSLocalizedString(@"date_hour", @""), NSLocalizedString(@"date_ago", @"")];
        }else{
            timeDifference = [NSString stringWithFormat:@"%d %@ %@",(int)secondsBetween/hour, NSLocalizedString(@"date_hours", @""), NSLocalizedString(@"date_ago", @"")];
        }
    }else if(secondsBetween/day >= 1 && secondsBetween/day < 7){
        //days
        if(secondsBetween/day == 1){
            timeDifference = NSLocalizedString(@"date_yesterday", @"");
        }else if(secondsBetween/day == 2){
            timeDifference = NSLocalizedString(@"date_day_before_yesterday", @"");
        }else{
            timeDifference = [NSString stringWithFormat:@"%d %@ %@",(int)secondsBetween/day, NSLocalizedString(@"date_days", @""), NSLocalizedString(@"date_ago", @"")];
        }
    }else if(secondsBetween/week >= 1 && secondsBetween/week <= 3){
        //weeks
        if(secondsBetween/week == 1){
            timeDifference = [NSString stringWithFormat:@"%d %@ %@",(int)secondsBetween/week, NSLocalizedString(@"date_week", @""), NSLocalizedString(@"date_ago", @"")];
        }else{
            timeDifference = [NSString stringWithFormat:@"%d %@ %@",(int)secondsBetween/week, NSLocalizedString(@"date_weeks", @""), NSLocalizedString(@"date_ago", @"")];
        }
    }else{
        //if longer than 3 weeks ago, just show date
        NSDateFormatter *customDateFormat = [[NSDateFormatter alloc] init];
        [customDateFormat setDateFormat:@"dd/MM/yyyy"];
        timeDifference = [customDateFormat stringFromDate:date1];
    }
    return timeDifference;
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
