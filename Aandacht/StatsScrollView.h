//
//  StatsScrollView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 21/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatsScrollView : UIScrollView <UIScrollViewDelegate>

@property(strong, nonatomic) NSMutableArray *arrItemViews;
@property(nonatomic) int elOffset;

@end
