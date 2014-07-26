//
//  MessageView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 23/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "MessageView.h"
#import "Constants.h"
#import <Parse/Parse.h>

@implementation MessageView

@synthesize height = _height;
@synthesize imageDir = _imageDir;
@synthesize messageObject = _messageObject;
@synthesize userProfilePic = _userProfilePic;
@synthesize lblMessage = _lblMessage;
@synthesize textFrameContainer = _textFrameContainer;

- (id)initWithFrame:(CGRect)frame andMessage:(Message*)messageObject
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageDir = [NSString stringWithFormat:@"%@views/incidenten/",imageDir];
        self.messageObject = messageObject;
        NSLog(@"%@", self.messageObject.description);
        
        int profilePicOffsetLeft;
        int textFrameContainerOffsetLeft;
        if([self.messageObject.sender isEqualToString:@"Police"]){
            [[userPolice objectForKey:@"userProfilePic"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (!error) {
                    UIImage *image = [UIImage imageWithData:data];
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                    imageView.frame = CGRectMake(0, 0, userIconDimension, userIconDimension);
                    [self addSubview:imageView];
                }
            }];
            textFrameContainerOffsetLeft = userIconDimension+1;
        }else if([self.messageObject.sender length] == 0){
            profilePicOffsetLeft = self.frame.size.width - userIconDimension+1;
        }else{
            [[userCurrent objectForKey:@"userProfilePic"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (!error) {
                    UIImage *image = [UIImage imageWithData:data];
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                    imageView.frame = CGRectMake(self.frame.size.width-userIconDimension+1, 0, userIconDimension, userIconDimension);
                    imageView.layer.cornerRadius = 21;
                    imageView.clipsToBounds = YES;
                    [self addSubview:imageView];
                }
            }];

            profilePicOffsetLeft = self.frame.size.width - userIconDimension+1;
            textFrameContainerOffsetLeft = 0;
        }
        
        self.textFrameContainer = [[UIView alloc] initWithFrame:CGRectMake(textFrameContainerOffsetLeft, 0, 245, 207)];
        [self addSubview:self.textFrameContainer];
        
        UIView *mainFrame;
        NSLog(@"%lu", (unsigned long)[self.messageObject.sender length]);
        if([self.messageObject.sender length] > 0){
            UIImageView *chatboxPointer = [Constants createImageView:[[NSBundle mainBundle] pathForResource:@"chat_box_pointer_left" ofType:@"png" inDirectory:self.imageDir] andFrame:CGRectMake(0, 0, 37, 38)];
            [self.textFrameContainer addSubview:chatboxPointer];
            
            mainFrame = [[UIView alloc] initWithFrame:CGRectMake(12, 0, self.textFrameContainer.frame.size.width-12, self.textFrameContainer.frame.size.height)];
            mainFrame.backgroundColor = [UIColor whiteColor];
            mainFrame.layer.cornerRadius = 5;
            mainFrame.clipsToBounds = YES;
            [self.textFrameContainer addSubview:mainFrame];

            if(textFrameContainerOffsetLeft == 0){
                chatboxPointer.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"chat_box_pointer_right" ofType:@"png" inDirectory:self.imageDir]];
                chatboxPointer.frame = CGRectMake(self.frame.size.width-42-chatboxPointer.frame.size.width-3, chatboxPointer.frame.origin.y, chatboxPointer.frame.size.width, chatboxPointer.frame.size.height);
                mainFrame.frame = CGRectMake(0, mainFrame.frame.origin.y, mainFrame.frame.size.width, mainFrame.frame.size.height);
            }
            
            self.lblMessage = [Constants createLabel:self.messageObject.description andFrame:CGRectMake(mainFrame.frame.origin.x + (mainFrame.frame.size.width - (mainFrame.frame.size.width-24))/2, (mainFrame.frame.size.height - (mainFrame.frame.size.height-messageTextTopOffset*2))/2, mainFrame.frame.size.width-24, mainFrame.frame.size.height-24) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentLeft andTextColor:[UIColor blackColor] andFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
            self.lblMessage.numberOfLines = 0;
            [self.textFrameContainer addSubview:self.lblMessage];
            
            NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
            style.minimumLineHeight = 20.f;
            style.maximumLineHeight = 20.f;
            NSDictionary *attributes = @{NSParagraphStyleAttributeName : style,};
            self.lblMessage.attributedText = [[NSAttributedString alloc] initWithString:self.lblMessage.text attributes:attributes];
            [self.lblMessage sizeToFit];
            
            mainFrame.frame = CGRectMake(mainFrame.frame.origin.x, mainFrame.frame.origin.y, mainFrame.frame.size.width, self.lblMessage.frame.size.height + messageTextTopOffset*2 + 4);
            
            int frameHeight = mainFrame.frame.size.height;
            if(frameHeight < userIconDimension){
                frameHeight = userIconDimension;
            }
            self.height = frameHeight + 15;
        }else{
            self.lblMessage = [Constants createLabel:self.messageObject.description andFrame:CGRectMake(0, 0, self.frame.size.width, 20) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentLeft andTextColor:[UIColor blackColor] andFont:[UIFont fontWithName:@"HelveticaNeue-Italic" size:14]];
            self.lblMessage.numberOfLines = 1;
            self.lblMessage.textColor = [UIColor colorWithRed:(41/255.0) green:(98/255.0) blue:(149/255.0) alpha:1];
            self.lblMessage.textAlignment = NSTextAlignmentCenter;
            [self.textFrameContainer addSubview:self.lblMessage];
            
            self.height = self.lblMessage.frame.size.height+15;
        }
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
