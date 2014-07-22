//
//  StatsView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 21/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "StatsView.h"

@implementation StatsView

@synthesize navigationV = _navigationV;
@synthesize statsScrollV = _statsScrollV;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.navigationV = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44)];
        [self addSubview:self.navigationV];
        
        //STATS SCROLLVIEW
        self.statsScrollV = [[StatsScrollView alloc] initWithFrame:CGRectMake(0, self.navigationV.frame.origin.y + self.navigationV.frame.size.height, [[UIScreen mainScreen] bounds].size.width, 200)];
        self.statsScrollV.delegate = self.statsScrollV;
        self.statsScrollV.scrollEnabled = YES;
        self.statsScrollV.delaysContentTouches = YES;
        self.statsScrollV.canCancelContentTouches = NO;
        [self.statsScrollV setShowsHorizontalScrollIndicator:NO];
        [self.statsScrollV setShowsVerticalScrollIndicator:NO];
        [self addSubview:self.statsScrollV];
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
