//
//  IncidentenDetailMessagesScrollView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 23/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "IncidentenDetailMessagesScrollView.h"
#import "Constants.h"
#import "MessageView.h"
#import "UIImage+animatedGIF.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@implementation IncidentenDetailMessagesScrollView

@synthesize totalHeight = _totalHeight;
@synthesize numMessages = _numMessages;
@synthesize loading = _loading;
@synthesize arrMessages = _arrMessages;
@synthesize arrMessageViews = _arrMessageViews;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.numMessages = 0;
        self.totalHeight = 0;
        self.arrMessages = [[NSMutableArray alloc] init];
        PFQuery *query = [PFQuery queryWithClassName:@"Message"];
        
        UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif" inDirectory:imageDir]]];
        self.loading = [[UIImageView alloc] initWithImage:image];
        self.loading.frame = CGRectMake((self.frame.size.width - 100)/2, (self.frame.size.height - 100)/2, 100, 100);
        [self addSubview:self.loading];
        
        int incidentId =currentSelectedIncident.incidentId;
        id convertedIncidentId = [NSNumber numberWithInteger: incidentId];
        [query whereKey:@"incidentId" equalTo:convertedIncidentId];
        
        //POLICE MESSAGES
        PFQuery *receivedMessages = query;
        [receivedMessages findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
            for(int i = 0; i<[objects count]; i++){
                for(int j = 0; j<[objects[i][@"userReceiverName"] count]; j++){
                    if([objects[i][@"userReceiverName"][j] isEqualToString:userName]){
                        [self.arrMessages addObject:[self createMessage:objects[i]]];
                    }
                }
            }
            
            PFQuery *sentMessages = query;
            [sentMessages whereKey:@"userSenderName" equalTo:userName];
            [sentMessages findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                for(int i = 0; i<[objects count]; i++){
                    [self.arrMessages addObject:[self createMessage:objects[i]]];
                }
                
                [UIView animateWithDuration:0.2 animations:^{
                    self.loading.alpha = 0;
                } completion:^(BOOL finished){
                    [self.loading removeFromSuperview];
                }];
                
                NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"messageId" ascending:YES];
                NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
                NSArray *sortedArray = [self.arrMessages sortedArrayUsingDescriptors:sortDescriptors];
                
                self.arrMessageViews = [[NSMutableArray alloc] init];
                for(int j = 0; j<[sortedArray count]; j++){
                    Message *currentMessage = (Message*)sortedArray[j];
                    MessageView *messageV = [[MessageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, 13+(120*j), defaultContentWidth, 100) andMessage:currentMessage];
                    messageV.frame = CGRectMake(messageV.frame.origin.x, 13+self.totalHeight, messageV.frame.size.width, messageV.height);
                    [self.arrMessageViews addObject:messageV];
                    [self addSubview:messageV];
                    self.totalHeight += messageV.height;
                }
                self.totalHeight += 10;
                self.contentSize = CGSizeMake(self.frame.size.width, self.totalHeight);
                
                MessageView *lastMessageV = (MessageView*)self.arrMessageViews[[self.arrMessageViews count]-1];
                CGPoint point = CGPointMake(0, lastMessageV.frame.origin.y - (self.frame.size.height - lastMessageV.frame.size.height));
                [self setContentOffset:point animated:YES];
                
                self.numMessages = (int)[self.arrMessages count];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MESSAGES_LOADED" object:nil];
            }];
        }];
    }
    return self;
}

-(void)addNewMessage:(Message*)message{
    NSLog(@"addNewMessage");
    MessageView *messageV = [[MessageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, 13+(120*self.numMessages), defaultContentWidth, 100) andMessage:message];
    messageV.frame = CGRectMake(messageV.frame.origin.x, 13+(self.totalHeight-10), messageV.frame.size.width, messageV.height);
    [self.arrMessageViews addObject:messageV];
    [self addSubview:messageV];
    
    [messageV.textFrameContainer setAlpha:0];
    [UIView animateWithDuration:0.8 delay:0.5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        messageV.textFrameContainer.alpha = 1;
    } completion:NULL];
    
    self.totalHeight += messageV.height;
    self.contentSize = CGSizeMake(self.frame.size.width, self.totalHeight);
    
    CGPoint point = CGPointMake(0, messageV.frame.origin.y - (self.frame.size.height - messageV.frame.size.height));
    [self setContentOffset:point animated:YES];
}

-(Message*)createMessage:(NSDictionary*)object{
    Message *messageObject = [[Message alloc] initWithIncidentId:(int)[object[@"incidentId"] integerValue] andMessageId:(int)[object[@"messageId"] integerValue] andDescription:object[@"description"] andSender:object[@"userSenderName"] andReceivers:object[@"userReceiverName"]];
    return messageObject;
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
