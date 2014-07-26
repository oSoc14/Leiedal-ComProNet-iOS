//
//  IncidentDetailView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 11/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "IncidentDetailView.h"
#import "Constants.h"

@implementation IncidentDetailView

@synthesize headerV = _headerV;
@synthesize currentShownView = _currentShownView;
@synthesize incidentenDetailInfoV = _incidentenDetailInfoV;
@synthesize messagesContainerScrollV = _messagesContainerScrollV;
@synthesize incidentenDetailMessagesScrollV = _incidentenDetailMessagesScrollV;
@synthesize messageFormV = _messageFormV;
@synthesize btnResignTextfield = _btnResignTextfield;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:defaultGrayBackgroundColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showIncidentInfo:) name:@"SHOW_INCIDENT_INFO" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showIncidentMessages:) name:@"SHOW_INCIDENT_MESSAGES" object:nil];
        
        //HEADER
        self.headerV = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 65)];
        [self.headerV showBackButton];
        [self addSubview:self.headerV];
        int contentHeight = 413;
        if([currentSelectedIncident.status isEqualToString:@"active"] || [currentSelectedIncident.status isEqualToString:@"pending"]){
            [self.headerV showSegmentedControl];
            contentHeight = 455;
            
            //INCIDENTEN DETAIL MESSAGES
            self.messagesContainerScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerV.frame.origin.y + self.headerV.frame.size.height, [[UIScreen mainScreen] bounds].size.width, contentHeight)];
            self.messagesContainerScrollV.delegate = self.incidentenDetailMessagesScrollV;
            self.messagesContainerScrollV.scrollEnabled = YES;
            self.messagesContainerScrollV.delaysContentTouches = YES;
            self.messagesContainerScrollV.canCancelContentTouches = NO;
            [self.messagesContainerScrollV setShowsHorizontalScrollIndicator:NO];
            [self.messagesContainerScrollV setShowsVerticalScrollIndicator:NO];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMessageForm:) name:@"MESSAGES_LOADED" object:nil];
            
            self.incidentenDetailMessagesScrollV = [[IncidentenDetailMessagesScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 369)];
            self.incidentenDetailMessagesScrollV.delegate = self.incidentenDetailMessagesScrollV;
            self.incidentenDetailMessagesScrollV.scrollEnabled = YES;
            self.incidentenDetailMessagesScrollV.delaysContentTouches = YES;
            self.incidentenDetailMessagesScrollV.canCancelContentTouches = NO;
            [self.incidentenDetailMessagesScrollV setShowsHorizontalScrollIndicator:NO];
            [self.incidentenDetailMessagesScrollV setShowsVerticalScrollIndicator:NO];
            [self.messagesContainerScrollV addSubview:self.incidentenDetailMessagesScrollV];
            
            self.btnResignTextfield = [Constants createCustomButton:@"" andTextColor:[UIColor clearColor] andFrame:self.incidentenDetailMessagesScrollV.frame andBackgroundImagePath:@"" andBackgroundHoverImagePath:@"" andFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]];
            [self.btnResignTextfield addTarget:self action:@selector(resignTextfield:) forControlEvents:UIControlEventTouchUpInside];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNewMessage:) name:@"MESSAGE_SENT" object:nil];
        }
        
        //INCIDENTEN DETAIL INFO
        self.incidentenDetailInfoV = [[IncidentenDetailInfoView alloc] initWithFrame:CGRectMake(0, self.headerV.frame.origin.y + self.headerV.frame.size.height, [[UIScreen mainScreen] bounds].size.width, contentHeight)];
        [self addSubview:self.incidentenDetailInfoV];
        self.currentShownView = self.incidentenDetailInfoV;
    }
    return self;
}

-(void)showNewMessage:(id)sender{
    [self scrollBackToOriginalPosition:@""];
    [self.incidentenDetailMessagesScrollV addNewMessage:self.messageFormV.lastSentMessage];
    self.messageFormV.numMessages++;
}

-(void)showMessageForm:(id)sender{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToShowSearchForm:) name:@"TEXTFIELD_FOCUS" object:nil];
    
    self.messageFormV = [[MessageFormView alloc] initWithFrame:CGRectMake(0, self.incidentenDetailMessagesScrollV.frame.origin.y + self.incidentenDetailMessagesScrollV.frame.size.height, [[UIScreen mainScreen] bounds].size.width, 46) andNumMessages:self.incidentenDetailMessagesScrollV.numMessages];
    [self.messagesContainerScrollV addSubview:self.messageFormV];
}

-(void)scrollToShowSearchForm:(id)sender{
    NSLog(@"scrollToShowSearchForm");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TEXTFIELD_FOCUS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollBackToOriginalPosition:) name:@"TEXTFIELD_FOCUSOUT" object:nil];
    [self.messagesContainerScrollV setContentOffset:CGPointMake(0, 167) animated:YES];
    [self.messagesContainerScrollV addSubview:self.btnResignTextfield];
}

-(void)scrollBackToOriginalPosition:(id)sender{
    NSLog(@"scrollToShowSearchForm");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TEXTFIELD_FOCUSOUT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToShowSearchForm:) name:@"TEXTFIELD_FOCUS" object:nil];
    [self.messagesContainerScrollV setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.btnResignTextfield removeFromSuperview];
}

-(void)resignTextfield:(id)sender{
    [self scrollBackToOriginalPosition:nil];
    [self.messageFormV hideTextField];
}

-(void)showIncidentInfo:(id)sender{
    [self switchToView:self.incidentenDetailInfoV];
}

-(void)showIncidentMessages:(id)sender{
    [self switchToView:self.messagesContainerScrollV];}

-(void)switchToView:(UIView*)view{
    [UIView animateWithDuration:0.15 animations:^{
        self.currentShownView.alpha = 0;
    } completion:^(BOOL finished){
        [self.currentShownView removeFromSuperview];
        
        [self addSubview:view];
        [view setAlpha:0];
        [UIView animateWithDuration:0.15 animations:^{
            view.alpha = 1;
        } completion:^(BOOL finished){
            self.currentShownView = view;
        }];
    }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_INCIDENT_INFO" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_INCIDENT_MESSAGES" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MESSAGES_LOADED" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TEXTFIELD_FOCUS" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TEXTFIELD_FOCUSOUT" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MESSAGE_SENT" object:nil];
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
