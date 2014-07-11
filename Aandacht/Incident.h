//
//  Incident.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 10/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Incident : NSObject

@property(nonatomic) int incidentId;

@property(strong, nonatomic) NSString *address;
@property(strong, nonatomic) NSString *description;
@property(nonatomic) double latitude;
@property(nonatomic) double longitude;
@property(strong, nonatomic) NSString *timeStamp;
@property(strong, nonatomic) NSString *durationTimeStamp;
@property(strong, nonatomic) NSString *status;

-(id)initWithId:(int)incidentId andAddress:(NSString*)address andDescription:(NSString*)description andLatitude:(double)latitude andLongitude:(double)longitude andTimeStamp:(NSString*)timeStamp andDurationTimeStamp:(NSString*)durationTimeStamp andStatus:(NSString*)status;

@end
