//
//  FilterView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncidentenListScrollView.h"

@interface FilterView: UIView

@property(strong, nonatomic) UILabel *lblIncidenten;
@property(strong, nonatomic) NSArray *arrFilterItems;
@property(strong, nonatomic) UISegmentedControl *segmentedControl;

-(void)updateSelectedIncidents;
-(void)updateSegmentedControl;

@end
