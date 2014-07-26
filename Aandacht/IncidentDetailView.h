//
//  IncidentDetailView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 11/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderView.h"
#import "IncidentenDetailInfoView.h"
#import "IncidentenDetailMessagesScrollView.h"
#import "MessageFormView.h"

@interface IncidentDetailView : UIView

@property(strong, nonatomic) HeaderView *headerV;
@property(strong, nonatomic) UIView *currentShownView;
@property(strong, nonatomic) IncidentenDetailInfoView *incidentenDetailInfoV;
@property(strong, nonatomic) UIScrollView *messagesContainerScrollV;
@property(strong, nonatomic) IncidentenDetailMessagesScrollView *incidentenDetailMessagesScrollV;
@property(strong, nonatomic) MessageFormView *messageFormV;
@property(strong, nonatomic) UIButton *btnResignTextfield;

@end
