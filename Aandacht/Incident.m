//
//  Incident.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 10/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "Incident.h"

@implementation Incident

@synthesize incidentId = _incidentId;

@synthesize address = _address;
@synthesize city = _city;
@synthesize description = _description;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize timeStamp = _timeStamp;
@synthesize durationTimeStamp = _durationTimeStamp;
@synthesize status = _status;

-(id)initWithId:(int)incidentId andAddress:(NSString*)address andCity:(NSString*)city andDescription:(NSString*)description andLatitude:(double)latitude andLongitude:(double)longitude andTimeStamp:(NSString*)timeStamp andDurationTimeStamp:(NSString*)durationTimeStamp andStatus:(NSString*)status{
    self = [super init];
    
    if(self){
        self.incidentId = incidentId;
        
        self.address = address;
        self.city = city;
        self.description = description;
        self.latitude = latitude;
        self.longitude = longitude;
        self.timeStamp = timeStamp;
        self.durationTimeStamp = durationTimeStamp;
        self.status = status;
    }
    
    return self;
}


@end
