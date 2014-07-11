//
//  SwitchView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 10/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "SwitchView.h"
#import "Constants.h" 

@implementation SwitchView

@synthesize lblTitle = _lblTitle;

- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = defaultDarkGrayBorder.CGColor;
        self.layer.borderWidth = 1;
        
        self.lblTitle = [Constants createLabel:title andFrame:CGRectMake(16, 14, [[UIScreen mainScreen] bounds].size.width, 14) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentLeft andTextColor:[UIColor colorWithRed:(41/255.0) green:(98/255.0) blue:(149/255.0) alpha:1] andFont:[UIFont fontWithName:@"HelveticaNeue" size:17]];
        [self addSubview:self.lblTitle];
        
        UISwitch *btnSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(253, 5, 50, 32)];
        [self addSubview:btnSwitch];
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
