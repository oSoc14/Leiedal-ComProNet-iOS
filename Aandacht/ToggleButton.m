//
//  ToggleButton.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 18/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "ToggleButton.h"
#import "Constants.h"

@implementation ToggleButton

@synthesize imageDir = _imageDir;
@synthesize pathActive = _pathActive;
@synthesize pathInactive = _pathInactive;
@synthesize isActive = _isActive;
//@synthesize button = _button;

- (id)initWithFrame:(CGRect)frame andToggleKind:(NSString*)kind
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageDir = [[NSString alloc] initWithFormat:@"%@views/", imageDir];
        self.isActive = false;
        
        if([kind isEqual:@"accept"]){
            self.pathActive = pathAcceptedActive;
            self.pathInactive = pathAcceptedInactive;
        }else{
            self.pathActive = pathDeniedActive;
            self.pathInactive = pathDeniedInactive;
        }
        
        /*self.button = [Constants createCustomButton:@"" andTextColor:[UIColor clearColor] andFrame:CGRectMake(0, 0, 22, 22) andBackgroundImagePath:[[NSBundle mainBundle] pathForResource:self.pathInactive ofType:@"png" inDirectory:self.imageDir] andBackgroundHoverImagePath:self.pathInactive andFont:[UIFont fontWithName:@"BrandonGrotesque-Black" size:24]];
        [self addSubview:self.button];*/
        
        UIImage *buttonBg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.pathInactive ofType:@"png" inDirectory:self.imageDir]];
        [self setBackgroundImage:buttonBg forState:UIControlStateNormal];
    }
    return self;
}

- (void)setInactive{
    self.isActive = false;
    /*[self.button removeFromSuperview];
    self.button = [Constants createCustomButton:@"" andTextColor:[UIColor clearColor] andFrame:CGRectMake(0, 0, 22, 22) andBackgroundImagePath:[[NSBundle mainBundle] pathForResource:self.pathInactive ofType:@"png" inDirectory:self.imageDir] andBackgroundHoverImagePath:self.pathInactive andFont:[UIFont fontWithName:@"BrandonGrotesque-Black" size:24]];
    [self addSubview:self.button];*/
    UIImage *buttonBg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.pathInactive ofType:@"png" inDirectory:self.imageDir]];
    [self setBackgroundImage:buttonBg forState:UIControlStateNormal];
}

- (void)setActive{
    self.isActive = true;
    /*[self.button removeFromSuperview];
    self.button = [Constants createCustomButton:@"" andTextColor:[UIColor clearColor] andFrame:CGRectMake(0, 0, 22, 22) andBackgroundImagePath:[[NSBundle mainBundle] pathForResource:self.pathActive ofType:@"png" inDirectory:self.imageDir] andBackgroundHoverImagePath:self.pathActive andFont:[UIFont fontWithName:@"BrandonGrotesque-Black" size:24]];
    [self addSubview:self.button];*/
    UIImage *buttonBg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.pathActive ofType:@"png" inDirectory:self.imageDir]];
    [self setBackgroundImage:buttonBg forState:UIControlStateNormal];
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
