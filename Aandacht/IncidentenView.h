//
//  IncidentenView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderView.h"
#import "FilterView.h"

@interface IncidentenView : UIView <UIAlertViewDelegate> 

@property(strong, nonatomic) NSString *imageDir;
@property(strong, nonatomic) HeaderView *headerV;

@property(strong, nonatomic) UIButton *btnCall;
@property(strong, nonatomic) UIAlertView *confirmCall;

@property(strong, nonatomic) FilterView *filterV;
@property(strong, nonatomic) NSArray *arrIncidentenList;
@property(strong, nonatomic) IncidentenListScrollView *incidentenListScrollV;

-(void)fadeInElements;
-(void)updateIncidentsList:(NSArray*)incidentsList;
-(void)updateFilter;

@end
