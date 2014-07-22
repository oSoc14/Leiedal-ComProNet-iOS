//
//  StatsItemView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 21/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "StatsItemView.h"
#import "Constants.h"

@implementation StatsItemView

@synthesize imageDir = _imageDir;
@synthesize dictionary = _dictionary;
@synthesize lblTitle = _lblTitle;
@synthesize imageV = _imageV;
@synthesize lblTime = _lblTime;
@synthesize lblTimeUnit = _lblTimeUnit;

- (id)initWithFrame:(CGRect)frame andWithData:(NSDictionary*)dictionary
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"%@", dictionary);
        
        // Initialization code
        self.imageDir = [[NSString alloc] initWithFormat:@"%@views/profile/",imageDir];
        self.dictionary = dictionary;
        self.layer.borderColor = defaultLightGrayBorder.CGColor;
        self.layer.borderWidth = 0.3;
        
        //STATS ITEM TITLE
        self.lblTitle = [Constants createLabel:[NSLocalizedString([self.dictionary objectForKey:@"name"], @"") uppercaseString] andFrame:CGRectMake(self.frame.size.width*0.2, 12, self.frame.size.width*0.8, 40) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentCenter andTextColor:[UIColor colorWithRed:(18/255.0) green:(72/255.0) blue:(120/255.0) alpha:1] andFont:[UIFont fontWithName:@"BrandonGrotesque-Black" size:16]];
        self.lblTitle.numberOfLines = 0;
        [self.lblTitle sizeToFit];
        [self addSubview:self.lblTitle];
    
        //ICON
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[self.dictionary objectForKey:@"src"] ofType:@"png" inDirectory:self.imageDir]];
        self.imageV = [[UIImageView alloc] initWithImage:image];
        [self.imageV setFrame:CGRectMake((self.frame.size.width - image.size.width)/2, self.lblTitle.frame.origin.y + self.lblTitle.frame.size.height + 14, image.size.width, image.size.height)];
        [self addSubview:self.imageV];

        //STATS ITEM TITLE
        int time = [[self.dictionary objectForKey:@"time"] intValue];
        if(time > hour){
            time = time/hour;
        }
        NSString *strTime = [[NSString alloc] initWithFormat:@"%d",time];
        self.lblTime = [Constants createLabel:strTime andFrame:CGRectMake(self.frame.size.width*0.1, self.imageV.frame.origin.y + self.imageV.frame.size.height + 9, self.frame.size.width*0.8, 33) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentCenter andTextColor:incidentListItemTextColor andFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:36]];
        [self addSubview:self.lblTime];
        
        //TIME UNIT
        self.lblTimeUnit = [Constants createLabel:NSLocalizedString([self.dictionary objectForKey:@"unit"], @"") andFrame:CGRectMake(self.frame.size.width*0.1, self.lblTime.frame.origin.y + self.lblTime.frame.size.height, self.frame.size.width*0.8, 16) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentCenter andTextColor:[UIColor colorWithRed:(0/255.0) green:(117/255.0) blue:(198/255.0) alpha:1] andFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:19]];
        [self addSubview:self.lblTimeUnit];
    }
    return self;
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
