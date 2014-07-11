//
//  InstellingenView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "InstellingenView.h"
#import "Constants.h"

@implementation InstellingenView

@synthesize headerV = _headerV;
@synthesize settingActive = _settingActive;
@synthesize lblActiveInfo = _lblActiveInfo;
@synthesize settingSound = _settingSound;
@synthesize lblSoundInfo = _lblSoundInfo;

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
        
        self.lblActiveInfo = [Constants createLabel:NSLocalizedString(@"instellingen_setting1_info", @"") andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, self.settingActive.frame.origin.y + self.settingActive.frame.size.height + 12, defaultContentWidth, 31) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentLeft andTextColor:[UIColor colorWithRed:(41/255.0) green:(98/255.0) blue:(149/255.0) alpha:1] andFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13]];
        self.lblActiveInfo.numberOfLines = 0;
        [self addSubview:self.lblActiveInfo];
        
        //SETTING SOUND
        self.settingSound = [[SwitchView alloc] initWithFrame:CGRectMake(0, self.lblActiveInfo.frame.origin.y + self.lblActiveInfo.frame.size.height + 10, [[UIScreen mainScreen] bounds].size.width, settingsItemHeight) andTitle:NSLocalizedString(@"instellingen_setting2", @"")];
        [self addSubview:self.settingSound];
        
        self.lblSoundInfo = [Constants createLabel:NSLocalizedString(@"instellingen_setting2_info", @"") andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, self.settingSound.frame.origin.y + self.settingSound.frame.size.height + 12, defaultContentWidth, 31) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentLeft andTextColor:[UIColor colorWithRed:(41/255.0) green:(98/255.0) blue:(149/255.0) alpha:1] andFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13]];
        self.lblSoundInfo.numberOfLines = 0;
        [self addSubview:self.lblSoundInfo];

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
