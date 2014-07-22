//
//  ProfielView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "ProfielView.h"
#import "Constants.h"

@implementation ProfielView

@synthesize imgDir = _imgDir;

@synthesize headerV = _headerV;
@synthesize loggedInStatusV = _loggedInStatusV;
@synthesize profilePictureV = _profilePictureV;
@synthesize statsV = _statsV;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imgDir = [NSString stringWithFormat:@"%@views/profile", imageDir];
        [self setBackgroundColor:defaultGrayBackgroundColor];
        
        //HEADER
        self.headerV = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 65)];
        [self addSubview:self.headerV];
        
        //LOGGED IN STATUS
        self.loggedInStatusV = [[LoggedInStatusView alloc] initWithFrame:CGRectMake(0, self.headerV.frame.origin.y + self.headerV.frame.size.height -1, [[UIScreen mainScreen] bounds].size.width, 27)];
        [self addSubview:self.loggedInStatusV];
        
        //PROFILE PICTURE
        self.profilePictureV = [[ProfilePictureView alloc] initWithFrame:CGRectMake(0, self.loggedInStatusV.frame.origin.y + self.loggedInStatusV.frame.size.height + 16, defaultContentWidth, 148) andImgDir:self.imgDir];
        [self addSubview:self.profilePictureV];
        
        //STATSVIEW
        self.statsV = [[StatsView alloc] initWithFrame:CGRectMake(0, self.profilePictureV.frame.origin.y + self.profilePictureV.frame.size.height + 20, [[UIScreen mainScreen] bounds].size.width, 244)];
        [self addSubview:self.statsV];
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
