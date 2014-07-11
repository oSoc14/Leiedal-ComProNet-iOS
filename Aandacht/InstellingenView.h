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

@interface InstellingenView : UIView

@property(strong, nonatomic) HeaderView *headerV;
@property(strong, nonatomic) SwitchView *settingActive;
@property(strong, nonatomic) UILabel *lblActiveInfo;
@property(strong, nonatomic) SwitchView *settingSound;
@property(strong, nonatomic) UILabel *lblSoundInfo;

@end
