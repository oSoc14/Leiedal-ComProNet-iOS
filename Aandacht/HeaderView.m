//
//  HeaderView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "HeaderView.h"
#import "Constants.h"

@implementation HeaderView

@synthesize imagesDir = _imagesDir;
@synthesize imgLogo = _imgLogo;
@synthesize lblTitle = _lblTitle;
@synthesize btnLogout = _btnLogout;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imagesDir = [NSString stringWithFormat:@"%@/views",imageDir];
        
        [self setBackgroundColor:headerBackgroundColor];
        self.layer.borderColor = defaultDarkGrayBorder.CGColor;
        self.layer.borderWidth = 1;
        
        NSString *pathLogo = [[NSBundle mainBundle] pathForResource:@"logo_small" ofType:@"png" inDirectory:self.imagesDir];
        UIImage *imageLogo = [[UIImage alloc] initWithContentsOfFile:pathLogo];
        self.imgLogo = [[UIImageView alloc] initWithImage:imageLogo];
        self.imgLogo.frame = CGRectMake(107, 32, imageLogo.size.width, imageLogo.size.height);
        [self addSubview:self.imgLogo];
        
        self.lblTitle = [Constants createLabel:NSLocalizedString(@"app_title", @"") andFrame:CGRectMake(128, 35, 75, 14) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentCenter andTextColor:[UIColor colorWithRed:(16/255.0) green:(135/255.0) blue:(218/255.0) alpha:1] andFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16]];
        [self addSubview:self.lblTitle];
        
        self.btnLogout = [Constants createCustomButton:@"" andTextColor:[UIColor clearColor] andFrame:CGRectMake(290, 33, 22, 18) andBackgroundImagePath:[[NSBundle mainBundle] pathForResource:@"logout" ofType:@"png" inDirectory:self.imagesDir] andBackgroundHoverImagePath:[[NSBundle mainBundle] pathForResource:@"logout_h" ofType:@"png" inDirectory:self.imagesDir] andFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16]];
        [self.btnLogout addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnLogout];
    }
    return self;
}

-(void)logoutUser:(id)sender{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"USER_LOGOUT" object:nil];
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
