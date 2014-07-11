//
//  ProfilePictureView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 11/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "ProfilePictureView.h"
#import "Constants.h"

@implementation ProfilePictureView

@synthesize blue = _blue;
@synthesize imgDir = _imgDir;
@synthesize profilePicture = _profilePicture;
@synthesize btnEditImage = _btnEditImage;

- (id)initWithFrame:(CGRect)frame andImgDir:(NSString*)imgDir
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.blue = [UIColor colorWithRed:(16/255.0) green:(135/255.0) blue:(218.0/255) alpha:1];
        self.imgDir = imgDir;
        
        //PROFILE PICTURE
        self.profilePicture = [Constants createImageView:[[NSBundle mainBundle] pathForResource:@"profile_picture" ofType:@"png" inDirectory:imgDir] andFrame:CGRectMake(80, 0, 86, 86)];
        //self.profilePicture.layer.borderWidth = 5;
        //self.profilePicture.layer.borderColor = self.blue.CGColor;
        [self addSubview:self.profilePicture];
        
        //EDIT IMAGE BUTTON
        NSLog(@"%f",([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2);
        self.btnEditImage = [Constants createCustomButton:[NSLocalizedString(@"profiel_edit_profile_picture", @"") uppercaseString] andTextColor:[UIColor whiteColor] andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, self.profilePicture.frame.origin.y + self.profilePicture.frame.size.height + 17, defaultContentWidth, 35) andBackgroundImagePath:[[NSBundle mainBundle] pathForResource:@"edit_profile_picture" ofType:@"png" inDirectory:self.imgDir] andBackgroundHoverImagePath:[[NSBundle mainBundle] pathForResource:@"edit_profile_picture_h" ofType:@"png" inDirectory:self.imgDir] andFont:[UIFont fontWithName:@"BrandonGrotesque-Black" size:22]];
        [self addSubview:self.btnEditImage];
        [self.btnEditImage addTarget:self action:@selector(editImage:) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@"%f", self.btnEditImage.frame.origin.x);
    }
    return self;
}

-(void)editImage:(id)sender{
    NSLog(@"[ProfilePictureView] edit image");
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
