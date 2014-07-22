//
//  InstellingenView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderView.h"
#import "SwitchView.h"

@interface InstellingenView : UIView <UIAlertViewDelegate> 

@property(strong, nonatomic) HeaderView *headerV;
@property(strong, nonatomic) SwitchView *settingActive;
@property(strong, nonatomic) UILabel *lblActiveInfo;
@property(strong, nonatomic) UIButton *btnSendNotification;
@property(strong, nonatomic) UILabel *lblSendNotification;
@property(strong, nonatomic) UIAlertView *confirmInactive;

@end
