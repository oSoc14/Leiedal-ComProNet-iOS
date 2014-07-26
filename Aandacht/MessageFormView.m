//
//  MessageFormView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 24/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "MessageFormView.h"
#import "Constants.h"
#import <Parse/Parse.h>

@implementation MessageFormView

@synthesize numMessages = _numMessages;
@synthesize txtMessage = _txtMessage;
@synthesize btnSend = _btnSend;
@synthesize lastSentMessage = _lastSentMessage;

- (id)initWithFrame:(CGRect)frame andNumMessages:(int)numMessages;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithRed:(247/255.0) green:(247/255.0) blue:(247/255.0) alpha:1]];
        self.layer.borderColor = defaultLightGrayBorder.CGColor;
        self.layer.borderWidth = 0.5;
        self.numMessages = numMessages;
        
        //MESSAGE TEXTFIELD
        self.txtMessage = [Constants createTextField:NSLocalizedString(@"incidenten_textfield_message_placeholder", @"") andFrame:CGRectMake(16, 8, 253-10, 28) andBackgroundImagePath:@"" andTextAlignment:NSTextAlignmentLeft andTextColor:[UIColor colorWithRed:(41/255.0) green:(98/255.0) blue:(149/255.0) alpha:1] andFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]
                                  andPlaceHolderColor:inputPlaceHolderColor];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        self.txtMessage.leftView = paddingView;
        self.txtMessage.leftViewMode = UITextFieldViewModeAlways;
        self.txtMessage.delegate = self;
        self.txtMessage.autocorrectionType = UITextAutocorrectionTypeNo;
        self.txtMessage.backgroundColor = [UIColor whiteColor];
        self.txtMessage.layer.cornerRadius = 5;
        self.txtMessage.clipsToBounds = YES;
        self.txtMessage.layer.borderColor = defaultLightGrayBorder.CGColor;
        self.txtMessage.layer.borderWidth = 0.3;
        [self addSubview:self.txtMessage];
        
        //SEND BUTTON
        self.btnSend = [Constants createCustomButton:@"Send" andTextColor:[UIColor colorWithRed:(41/255.0) green:(98/255.0) blue:(149/255.0) alpha:1] andFrame:CGRectMake(self.txtMessage.frame.origin.x + self.txtMessage.frame.size.width + 11, self.txtMessage.frame.origin.y, 40, self.txtMessage.frame.size.height) andBackgroundImagePath:@"" andBackgroundHoverImagePath:@"" andFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16]];
        [self.btnSend setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [self.btnSend addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnSend];
    }
    return self;
}

-(void)sendMessage:(id)sender{
    NSLog(@"sendMessage");
    
    if([self.txtMessage.text length] > 0){
        NSLog(@"message longer than 1 char");
        
        PFObject *newMessage = [PFObject objectWithClassName:@"Message"];
        id messageId = [NSNumber numberWithInteger:self.numMessages];
        newMessage[@"messageId"] = messageId;
        newMessage[@"description"] = self.txtMessage.text;
        newMessage[@"userSenderName"] = userCurrent[@"name"];
        newMessage[@"userReceiverName"] = [[NSArray alloc] initWithObjects:@"Police", nil];
        id incidentId = [NSNumber numberWithInteger:currentSelectedIncident.incidentId];
        newMessage[@"incidentId"] = incidentId;
        [newMessage saveInBackground];
        
        self.lastSentMessage = [[Message alloc] initWithIncidentId:currentSelectedIncident.incidentId andMessageId:self.numMessages andDescription:self.txtMessage.text andSender:userCurrent[@"name"] andReceivers:[[NSArray alloc] initWithObjects:@"Police", nil]];
        
        [self hideTextField];
        self.txtMessage.text = @"";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MESSAGE_SENT" object:nil];
    }
}

-(void)hideTextField{
    [self.txtMessage resignFirstResponder];
}

//UITEXTFIELD CALLBACKS
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TEXTFIELD_FOCUS" object:nil];
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
