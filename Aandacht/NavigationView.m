//
//  NavigationView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 21/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "NavigationView.h"
#import "Constants.h"

@implementation NavigationView

@synthesize imageDir = _imageDir;
@synthesize lblTitle = _lblTitle;
@synthesize btnLeft = _btnLeft;
@synthesize btnRight = _btnRight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageDir = [[NSString alloc] initWithFormat:@"%@views/",imageDir];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = defaultLightGrayBorder.CGColor;
        self.layer.borderWidth = 0.5;
        
        //TITLE LABEL
        self.lblTitle = [Constants createLabel:NSLocalizedString(@"profiel_stats_title", "") andFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, self.frame.size.height) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentCenter andTextColor:[UIColor colorWithRed:(0/255.0) green:(117/255.0) blue:(198/255.0) alpha:1] andFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size:25]];
        [self addSubview:self.lblTitle];
        
        //BUTTON LEFT
        [self createButtonWidthDirection:@"left"];
        
        //BUTTON RIGHT
        [self createButtonWidthDirection:@"right"];
    }
    return self;
}

-(void)createButtonWidthDirection:(NSString*)direction{
    NSLog(@"createButtonWidthDirection");
    NSString *btnBgPath;
    NSString *btnBgPathH;
    UIButton *button;
    int offsetLeft = 0;
    if([direction isEqualToString:@"left"]){
        btnBgPath = [[NSBundle mainBundle] pathForResource:@"icon_arrow_left_inactive" ofType:@"png" inDirectory:self.imageDir];
        btnBgPathH = [[NSBundle mainBundle] pathForResource:@"icon_arrow_left_back_h" ofType:@"png" inDirectory:self.imageDir];
        button = self.btnLeft;
        offsetLeft = 10;
    }else if([direction isEqualToString:@"right"]){
        if([arrUserMetaData count] > 2){
            btnBgPath = [[NSBundle mainBundle] pathForResource:@"icon_arrow_right" ofType:@"png" inDirectory:self.imageDir];
        }else{
            btnBgPath = [[NSBundle mainBundle] pathForResource:@"icon_arrow_right_inactive" ofType:@"png" inDirectory:self.imageDir];
        }
        btnBgPathH = [[NSBundle mainBundle] pathForResource:@"icon_arrow_right_h" ofType:@"png" inDirectory:self.imageDir];
        button = self.btnRight;
        offsetLeft = 300;
    }
    button = [Constants createCustomButton:@"" andTextColor:[UIColor clearColor] andFrame:CGRectMake(offsetLeft, 12, 12, 20) andBackgroundImagePath:btnBgPath andBackgroundHoverImagePath:btnBgPathH andFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15]];
    if(([arrUserMetaData count] <= 2 && [direction isEqualToString:@"right"]) || [direction isEqualToString:@"left"]){
        [button setEnabled:NO];
    }
    [self addSubview:button];
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
