//
//  ProfilePictureView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 11/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilePictureView : UIView

@property(strong, nonatomic) UIColor *blue;
@property(strong, nonatomic) NSString *imgDir;
@property(strong, nonatomic) UIImage *imageMask;
@property(strong, nonatomic) UIImageView *profilePicture;
@property(strong, nonatomic) UIButton *btnEditImage;

- (id)initWithFrame:(CGRect)frame andImgDir:(NSString*)imgDir;
-(void)updateProfilePictureWithImage:(UIImage*)image;

@end
