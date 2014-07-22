//
//  SwitchView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 10/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchView : UIView

@property(strong, nonatomic) UILabel *lblTitle;
@property(strong, nonatomic) UISwitch *btnSwitch;

- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)title;

@end
