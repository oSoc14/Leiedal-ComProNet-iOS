//
//  IncidentenViewController.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncidentenView.h"

@interface IncidentenViewController : UIViewController

@property(strong, nonatomic) UINavigationController *navCont;

@property (strong, nonatomic) IncidentenView *incidentenV;

@end
