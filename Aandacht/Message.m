//
//  Message.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 23/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "Message.h"

@implementation Message

@synthesize incidentId = _incidentId;
@synthesize messageId = _messageId;
@synthesize description = _description;
@synthesize sender = _sender;
@synthesize arrReceivers = _arrReceivers;

-(id)initWithIncidentId:(int)incidentId andMessageId:(int)messageId andDescription:(NSString*)description andSender:(NSString*)sender andReceivers:(NSArray*)arrReceivers{
    self = [super init];
    
    if(self){
        self.incidentId = incidentId;
        self.messageId = messageId;
        self.description = description;
        self.sender = sender;
        self.arrReceivers = arrReceivers;
    }
    
    return self;
}

@end
