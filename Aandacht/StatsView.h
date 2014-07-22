//
//  StatsView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 21/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationView.h"
#import "StatsScrollView.h"

@interface StatsView : UIView

@property(strong, nonatomic) NavigationView *navigationV;
@property(strong, nonatomic) StatsScrollView *statsScrollV;

@end
