//
//  InstellingenView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "InstellingenView.h"
#import "Constants.h"
#import "Incident.h"

@implementation InstellingenView

@synthesize headerV = _headerV;
@synthesize settingActive = _settingActive;
@synthesize lblActiveInfo = _lblActiveInfo;
@synthesize btnSendNotification = _btnSendNotification;
@synthesize lblSendNotification = _lblSendNotification;
@synthesize confirmInactive = _confirmInactive;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:defaultGrayBackgroundColor];
        
        //HEADER
        self.headerV = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 65)];
        [self addSubview:self.headerV];
        
        //SETTING ACTIVE
        self.settingActive = [[SwitchView alloc] initWithFrame:CGRectMake(0, 78, [[UIScreen mainScreen] bounds].size.width, settingsItemHeight) andTitle:NSLocalizedString(@"instellingen_setting1", @"")];
        [self addSubview:self.settingActive];
        
        if(isUserActive){
            [self.settingActive.btnSwitch setOn:true animated:true];
        }
        [self.settingActive.btnSwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
        
        self.lblActiveInfo = [Constants createLabel:NSLocalizedString(@"instellingen_setting1_info", @"") andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, self.settingActive.frame.origin.y + self.settingActive.frame.size.height + 12, defaultContentWidth, 31) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentLeft andTextColor:[UIColor colorWithRed:(41/255.0) green:(98/255.0) blue:(149/255.0) alpha:1] andFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13]];
        self.lblActiveInfo.numberOfLines = 0;
        [self addSubview:self.lblActiveInfo];
        
        if(isUserActive){
            [self createUserNotificationOptionsWithFade:false];
        }
    }
    return self;
}

-(void)createUserNotificationOptionsWithFade:(bool)fade{
    NSLog(@"show user notification options");
    
    //SEND NOTIFICATION BUTTON
    /*self.btnSendNotification = [Constants createCustomButton:[NSLocalizedString(@"instellingen_send_notification", @"") uppercaseString] andTextColor:[UIColor whiteColor] andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, self.lblActiveInfo.frame.origin.y + self.lblActiveInfo.frame.size.height, defaultContentWidth, 35) andBackgroundImagePath:[[NSBundle mainBundle] pathForResource:@"edit_profile_picture" ofType:@"png" inDirectory:[NSString stringWithFormat:@"%@views/profile", imageDir]] andBackgroundHoverImagePath:[[NSBundle mainBundle] pathForResource:@"edit_profile_picture_h" ofType:@"png" inDirectory:[NSString stringWithFormat:@"%@views/profile", imageDir]] andFont:[UIFont fontWithName:@"BrandonGrotesque-Black" size:15]];
    [self addSubview:self.btnSendNotification];
    [self.btnSendNotification addTarget:self action:@selector(sendPushNotification:) forControlEvents:UIControlEventTouchUpInside];
    
    //SEND NOTIFICATION LABEL
    self.lblSendNotification = [Constants createLabel:NSLocalizedString(@"instellingen_send_notification_info", @"") andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, self.btnSendNotification.frame.origin.y + self.btnSendNotification.frame.size.height, defaultContentWidth, 70) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentLeft andTextColor:[UIColor colorWithRed:(41/255.0) green:(98/255.0) blue:(149/255.0) alpha:1] andFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13]];
    self.lblSendNotification.numberOfLines = 0;
    [self addSubview:self.lblSendNotification];
    
    if(fade){
        self.btnSendNotification.alpha = 0;
        self.lblSendNotification.alpha = 0;
        [UIView animateWithDuration:0.4 animations:^{
            self.btnSendNotification.alpha = 1;
            self.btnSendNotification.frame = CGRectMake(self.btnSendNotification.frame.origin.x, self.btnSendNotification.frame.origin.y+12, self.btnSendNotification.frame.size.width, self.btnSendNotification.frame.size.height);
        } completion:NULL];
        [UIView animateWithDuration:0.4 delay:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.lblSendNotification.alpha = 1;
            self.lblSendNotification.frame = CGRectMake(self.lblSendNotification.frame.origin.x, self.lblSendNotification.frame.origin.y+16, self.lblSendNotification.frame.size.width, self.lblSendNotification.frame.size.height);
        } completion:NULL];
    }else{
        self.btnSendNotification.frame = CGRectMake(self.btnSendNotification.frame.origin.x, self.btnSendNotification.frame.origin.y+12, self.btnSendNotification.frame.size.width, self.btnSendNotification.frame.size.height);
        self.lblSendNotification.frame = CGRectMake(self.lblSendNotification.frame.origin.x, self.lblSendNotification.frame.origin.y+16, self.lblSendNotification.frame.size.width, self.lblSendNotification.frame.size.height);
    }*/
}

-(void)fadeOutUserNotificationOptions{
    [self.btnSendNotification removeTarget:self  action:@selector(sendPushNotification:) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:0.4 animations:^{
        self.btnSendNotification.alpha = 0;
        self.btnSendNotification.frame = CGRectMake(self.btnSendNotification.frame.origin.x, self.btnSendNotification.frame.origin.y-12, self.btnSendNotification.frame.size.width, self.btnSendNotification.frame.size.height);
    } completion:^(BOOL finished){
        [self.btnSendNotification removeFromSuperview];
    }];
    [UIView animateWithDuration:0.4 delay:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.lblSendNotification.alpha = 0;
        self.lblSendNotification.frame = CGRectMake(self.lblSendNotification.frame.origin.x, self.lblSendNotification.frame.origin.y-16, self.lblSendNotification.frame.size.width, self.lblSendNotification.frame.size.height);
    } completion:^(BOOL finished){
        [self.lblSendNotification removeFromSuperview];
    }];
}

-(void)sendPushNotification:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SEND_PUSH_NOTIFICATION" object:nil];
}

-(void)changeSwitch:(id)sender{
    if([self.settingActive.btnSwitch isOn]){
        [self createUserNotificationOptionsWithFade:true];
        isUserActive = true;
    }else{
        [self.settingActive.btnSwitch setOn:true animated:true];
        bool activeIncidentAvailable = false;
        for(int i=0; i<[arrIncidents count]; i++){
            Incident *currentIncident = (Incident*)arrIncidents[i];
            if([currentIncident.status isEqual:@"active"]){
                activeIncidentAvailable = true;
            }
        }
        if(activeIncidentAvailable){
            NSLog(@"active incidents available!!");
            self.confirmInactive = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"instellingen_confirm_inactive", @"") message:@"" delegate:self cancelButtonTitle:NSLocalizedString(@"instellingen_confirm_option1", @"")  otherButtonTitles:NSLocalizedString(@"instellingen_confirm_option2", @""), nil];
            [self.confirmInactive show];
        }else{
            NSLog(@"no active incidents available");
            [self.settingActive.btnSwitch setOn:false animated:true];
            isUserActive = false;
            [self fadeOutUserNotificationOptions];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1){
        isUserActive = false;
        [self fadeOutUserNotificationOptions];
        [self.settingActive.btnSwitch setOn:false animated:true];
        //deny all active incidents
        for(int i=0; i<[arrIncidents count]; i++){
            Incident *currentIncident = (Incident*)arrIncidents[i];
            if([currentIncident.status isEqual:@"active"]){
                currentIncident.status = @"denied";
            }
        }
    }else{
        isUserActive = true;
        [self.settingActive.btnSwitch setOn:true animated:true];
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
