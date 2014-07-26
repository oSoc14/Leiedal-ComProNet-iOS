//
//  ProfilePictureView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 11/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "ProfilePictureView.h"
#import "Constants.h"
#import <Parse/Parse.h>

@implementation ProfilePictureView

@synthesize blue = _blue;
@synthesize imgDir = _imgDir;
@synthesize imageMask = _imageMask;
@synthesize profilePicture = _profilePicture;
@synthesize btnEditImage = _btnEditImage;

- (id)initWithFrame:(CGRect)frame andImgDir:(NSString*)imgDir
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.blue = [UIColor colorWithRed:(16/255.0) green:(135/255.0) blue:(218.0/255) alpha:1];
        self.imgDir = imgDir;
        
        //PROFILE PICTURE IMAGE
        /*UIImage *imgProfilePicture = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"profile_picture" ofType:@"png" inDirectory:self.imgDir]];
        [self updateProfilePictureWithImage:imgProfilePicture];*/
        
        [[userCurrent objectForKey:@"userProfilePic"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                [self updateProfilePictureWithImage: image];
                
                //EDIT IMAGE BUTTON
                self.btnEditImage = [Constants createCustomButton:[NSLocalizedString(@"profiel_edit_profile_picture", @"") uppercaseString] andTextColor:[UIColor whiteColor] andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, self.profilePicture.frame.origin.y + self.profilePicture.frame.size.height + 17, defaultContentWidth, 35) andBackgroundImagePath:[[NSBundle mainBundle] pathForResource:@"edit_profile_picture" ofType:@"png" inDirectory:self.imgDir] andBackgroundHoverImagePath:[[NSBundle mainBundle] pathForResource:@"edit_profile_picture_h" ofType:@"png" inDirectory:self.imgDir] andFont:[UIFont fontWithName:@"BrandonGrotesque-Black" size:22]];
                [self addSubview:self.btnEditImage];
                [self.btnEditImage addTarget:self action:@selector(editImage:) forControlEvents:UIControlEventTouchUpInside];
            }
        }];
    }
    return self;
}

-(void)updateProfilePictureWithImage:(UIImage*)image{
    [self.profilePicture removeFromSuperview];
    int profilePictureDimension = 86;
    
    //PROFILE PICTURE
    self.profilePicture = [[UIImageView alloc] initWithImage:image];
    [self.profilePicture setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 86)/2, 0, profilePictureDimension, profilePictureDimension)];
    self.profilePicture.layer.cornerRadius = 45;
    self.profilePicture.clipsToBounds = YES;
    [self addSubview:self.profilePicture];
    
    //UPDATE BACKEND USER
    //PFQuery *query = [PFQuery queryWithClassName:@"User"];
    
    // Retrieve the object by id
    /*[query whereKey:@"name" equalTo:userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.05f);
        PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
        for(int i = 0; i<[objects count]; i++){
            PFObject *object = (PFObject*)objects[i];
            object[@"userProfilePic"] = imageFile;
            object.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            [object saveInBackground];
        }
    }];*/
}

-(void)editImage:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EDIT_PROFILE_PICTURE" object:nil];
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
