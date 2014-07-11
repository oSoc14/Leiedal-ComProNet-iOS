//
//  ProfielView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderView.h"
#import "LoggedInStatusView.h"
#import "ProfilePictureView.h"

@interface ProfielView : UIView

@property(strong, nonatomic) NSString *imgDir;

@property(strong, nonatomic) HeaderView *headerV;
@property(strong, nonatomic) LoggedInStatusView *loggedInStatusV;
@property(strong, nonatomic) ProfilePictureView *profilePictureV;

@end
