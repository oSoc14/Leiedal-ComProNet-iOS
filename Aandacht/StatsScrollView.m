//
//  StatsScrollView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 21/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "StatsScrollView.h"
#import "Constants.h"
#import "StatsItemView.h"

@implementation StatsScrollView

@synthesize arrItemViews = _arrItemViews;
@synthesize elOffset = _elOffset;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.arrItemViews = [[NSMutableArray alloc] init];
        self.elOffset = 5;
        
        int totalWidthScrollV = 0;
        for(int i = 0; i<[arrUserMetaData count]; i++){
            int elWidth = [[UIScreen mainScreen] bounds].size.width/2 - 1;
            StatsItemView *statsItemV = [[StatsItemView alloc] initWithFrame:CGRectMake(elWidth*i + self.elOffset, 0, elWidth, self.frame.size.height) andWithData:arrUserMetaData[i]];
            totalWidthScrollV += elWidth;
            [self addSubview:statsItemV];
        }
        self.contentSize = CGSizeMake(self.frame.size.width+(self.elOffset*2), self.frame.size.height);
        [self setContentOffset:CGPointMake(self.elOffset, 0) animated:NO];
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
