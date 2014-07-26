//
//  MessageView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 23/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface MessageView : UIView

@property(nonatomic) int height;
@property(strong, nonatomic) NSString *imageDir;
@property(strong, nonatomic) Message *messageObject;
@property(strong, nonatomic) UIImageView *userProfilePic;
@property(strong, nonatomic) UILabel *lblMessage;
@property(strong, nonatomic) UIView *textFrameContainer;

- (id)initWithFrame:(CGRect)frame andMessage:(Message*)messageObject;

@end
