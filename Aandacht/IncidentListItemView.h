//
//  IncidentListItemView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 10/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Incident.h"

@interface IncidentListItemView : UIView

@property(strong, nonatomic) Incident *incident;

@property(strong, nonatomic) UIImageView *statusIcon;
@property(strong, nonatomic) UILabel *lblAddress;
@property(strong, nonatomic) UILabel *lblDescription;
@property(strong, nonatomic) UILabel *lblTime;
@property(strong, nonatomic) UIImageView *arrowRight;

- (id)initWithFrame:(CGRect)frame andIncident:(Incident*)incident;

@end
