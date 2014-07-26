//
//  MessageFormView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 24/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface MessageFormView : UIView <UITextFieldDelegate>

@property(nonatomic) int numMessages;
@property(strong, nonatomic) UITextField *txtMessage;
@property(strong, nonatomic) UIButton *btnSend;
@property(strong, nonatomic) Message *lastSentMessage;

- (id)initWithFrame:(CGRect)frame andNumMessages:(int)numMessages;
-(void)hideTextField;

@end
