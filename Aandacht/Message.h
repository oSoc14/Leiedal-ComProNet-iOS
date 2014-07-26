//
//  Message.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 23/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property(nonatomic) int incidentId;
@property(nonatomic) int messageId;
@property(strong, nonatomic) NSString *description;
@property(strong, nonatomic) NSString *sender;
@property(strong, nonatomic) NSArray *arrReceivers;

-(id)initWithIncidentId:(int)incidentId andMessageId:(int)messageId andDescription:(NSString*)description andSender:(NSString*)sender andReceivers:(NSArray*)arrReceivers;

@end
