//
//  IncidentenDetailMessagesScrollView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 23/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface IncidentenDetailMessagesScrollView : UIScrollView <UIScrollViewDelegate>

@property(nonatomic) int totalHeight;
@property(nonatomic) int numMessages;
@property(strong, nonatomic) UIImageView *loading;
@property(strong, nonatomic) NSMutableArray *arrMessages;
@property(strong, nonatomic) NSMutableArray *arrMessageViews;

-(void)addNewMessage:(Message*)message;

@end
