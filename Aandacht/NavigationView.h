//
//  NavigationView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 21/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationView : UIView

@property(strong, nonatomic) NSString *imageDir;
@property(strong, nonatomic) UILabel *lblTitle;
@property(strong, nonatomic) UIButton *btnLeft;
@property(strong, nonatomic) UIButton *btnRight;

@end
